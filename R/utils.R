#' Remove units
#'
#' The main `rems_to_aquachem()` function downloads EMS data and formats it for
#' use in the external program, AquaChem. However, occasionally you may wish
#' to work with this formatted EMS data in R. This function removes the extra
#' 'units' row and then converts the columns to make the data usable in R.
#'
#' @param d Data frame output from `rems_to_aquachem()`
#'
#' @return Data frame
#' @export
#'
#' @examples
#'
#' \dontrun{
#' # Get and format one well for use in AquaChem
#' r <- rems_to_aquachem(ems_ids = "E289551", save = FALSE)
#'
#' # Remove units and convert columns to appropriate formats for use in R
#' r <- units_remove(r)
#'
#' }
#'
units_remove <- function(d) {

  if(all(sapply(d[1, ], is.character))) {

    num <- params %>%
      dplyr::filter(.data$data_type == "numeric", !is.na(.data$aqua_code)) %>%
      dplyr::pull(.data$aqua_code)
    num <- c(num, stringr::str_subset(
      names(d), "(_meq)|(_p)|(charge_balance)|(anion)|(cation)"))

    date <- params %>%
      dplyr::filter(.data$data_type == "date", !is.na(.data$aqua_code)) %>%
      dplyr::pull(.data$aqua_code)

    d <- d %>%
      dplyr::slice(-1) %>%
      dplyr::mutate(dplyr::across(dplyr::any_of(num), as.numeric)) %>%
      dplyr::mutate(dplyr::across(dplyr::any_of(date), lubridate::as_date))
  }
  d
}

units_convert <- function(x, from, to) {
  dplyr::case_when(from == "mg/L" & to == "ug/L" ~ x * 1000,
                   from == "ug/L" & to == "mg/L" ~ x / 1000,
                   from == to | (is.na(from) & is.na(to)) | from == "meq" ~ x,
                   TRUE ~ NA_real_)
}

#' Calculate MEQ values
#'
#' Calculates MEQ values for 'long' data in mg/L. Expects columns:
#' "aqua_code" and "RESULT", where "aqua_code" is the parameter type
#' (e.g., "Zn_diss") and RESULT is the numeric concentration in mg/L.
#'
#' For conversion details see the included data frame, `meq_conversion`.
#'
#' Also see `?meq_conversion` for a description of the data.
#'
#' MEQs are calculated by dividing the parameter concentration in mg/L by the
#' conversion factor.
#'
#' **Note: This is an internal function, exported for clarity in calculations**
#'
#' @param d Data frame. Long data containing parameters and results
#' @param drop_na Logical. Whether to omit missing parameters
#'
#' @examples
#'
#' d <- data.frame(aqua_code = c("Cl", "HCO3"), RESULT = c(5.7, 38.3))
#' d
#' meq(d, drop_na = TRUE)
#' meq(d)
#'
#'
#' @export

meq <- function(d, drop_na = FALSE) {
  # Values all in mg/L (RESULT) which is the standard reported by EMS
  d <- dplyr::select(meq_conversion, "aqua_code" = "param", "conversion") %>%
    dplyr::left_join(d, by = "aqua_code", multiple = "all") %>%
    dplyr::mutate(RESULT = .data$RESULT / .data$conversion,
                  aqua_code = paste0(.data$aqua_code, "_meq"),
                  UNIT = "meq",
                  aqua_unit = "meq") %>%
    dplyr::select(-"conversion")
  if(drop_na) d <- tidyr::drop_na(d)
  d
}


#' Calculate charge balance
#'
#' Calculates charge balances based on ALS formula. **Note:** Original EMS
#' charge balances, anion sums and cation sums have been **omitted**.
#'
#' Potential changes in workflows over the years have made it difficult to
#' ascertain exactly how charge balances were calculated in older samples. This
#' resulted in discrepancies between EMS and locally calculated charge balances.
#' Therefore for consistency, we calculate charge balances for all samples using
#' the ALS formula below.
#'
#' One difference between this calculation and that of ALS, is that we use more
#' significant digits when calculating MEQ.
#'
#' anion sum = Cl_meq + SO4_meq + F_meq + NO3_meq + NO2_meq + Means_Alk_meq
#'
#' cation sum = Ca_meq + Mg_meq + Na_meq + K_meq + Al_diss_meq +
#'              Cu_diss_meq + Fe_diss_meq + Mn_diss_meq + Zn_diss_meq + NH4_meq +
#'              (10 ^ (-pH_lab)) * 1000
#'
#' Charge balance = 100 x (Cation Sum - Anion sum) / (Cation Sum + Anion Sum)
#'
#' Missing values are ignored (ie. generally treated as 0). However, if all
#' values for cations or anions are missing the charge balance is `NA`.
#'
#' @param d Data set formatted for AquaChem (output of `rems_to_aquachem()`)
#'
#' @return Data frame
#'
#'
charge_balance <- function(d) {

  message("For consistency EMS charge balances, anion sums, and cation sums ",
          "have been replaced with recalculated values.\nSee `?charge_balance` ",
          "for more details.")

  d %>%
    dplyr::mutate(pH_lab_meq = (10^(-.data$pH_lab)) * 1000) %>%
    dplyr::select("Sample_Date", "SampleID", "StationID",

                  #anions
                  "Cl_meq", "SO4_meq", "F_meq", "NO3_meq",
                  "NO2_meq", "Meas_Alk_meq",

                  #cations
                  "Ca_meq", "Mg_meq", "Na_meq", "K_meq",
                  "Al_diss_meq", "Cu_diss_meq", "Fe_diss_meq",
                  "Mn_diss_meq", "Zn_diss_meq", "NH4_meq",
                  "pH_lab_meq") %>%

    tidyr::pivot_longer(cols = dplyr::ends_with("_meq"),
                        names_to = "ion", values_to = "value") %>%
    dplyr::mutate(type = dplyr::if_else(
      .data$ion %in% c("Cl_meq", "SO4_meq", "F_meq", "NO3_meq",
                       "NO2_meq", "Meas_Alk_meq"),
      "anion", "cation")) %>%
    dplyr::group_by(.data$Sample_Date, .data$SampleID, .data$StationID, .data$type) %>%
    dplyr::summarize(
      sum = sum(.data$value, na.rm = TRUE), # Ignore missing ions
      sum = dplyr::if_else(all(is.na(.data$value)), NA_real_, sum), .groups = "drop") %>%
    dplyr::mutate(type = paste0(.data$type, "_sum")) %>%
    tidyr::pivot_wider(names_from = "type", values_from = "sum") %>%
    dplyr::mutate(
      charge_balance = 100 * ((.data$cation_sum - .data$anion_sum) /
                                (.data$cation_sum + .data$anion_sum)),

      anion_sum = round(.data$anion_sum, 2),
      cation_sum = round(.data$cation_sum, 2),
      charge_balance = round(.data$charge_balance, 1)) %>%
    dplyr::left_join(
      dplyr::select(d, -dplyr::any_of(c("charge_balance", "anion_sum", "cation_sum"))),
      ., by = c("Sample_Date", "SampleID", "StationID"))

}


is_valid <- function(charge_balance) {
  abs(charge_balance) <= 10
}

#' Calculate water type
#'
#' Water type based on anions Cl, SO4, HCO3 and cations Ca, Mg, Na and K. Ions
#' are ranked by proportion MEQ, all greater than 10% are listed in descending
#' order of presence, cations first. Water type is only calculated for samples
#' with valid charge balances. If HCO3 is missing, we use Meas Alk as a
#' replacement (indicated by an '*' on HCO3 in the water type). Otherwise,
#' missing ions are ignored (i.e. treated as 0). The column `missing_ion`
#' indicates whether there is a problem with the water type, such that it is
#' missing a cation or anion (i.e. is all cations or all anions).
#' Water type is designed to compliment piper plots by using the same ions so
#' they are comparable.
#'
#' @param d Data frame. Must contain columns `Sample_Date`, `SampleID`,
#'   `StationID`, `Cl_meq`, `SO4_meq`, `HCO3_meq`, `Meas_Alk_meq`,
#'   `Ca_meq`, `Mg_meq`, `Na_meq`, `K_meq` and `charge_balance`.
#'
#' @return Data frame with added columns `water_type` and `missing_ion`.
#'
#' @examples
#'
#' d <- data.frame(Sample_Date = "2022-01-01", SampleID = "999990-01", StationID = 000,
#'                 Cl_meq = 0.0226, SO4_meq = 0.0208, HCO3_meq = 1.54, Meas_Alk_meq = 1.7,
#'                 Ca_meq = 0.187, Mg_meq = 0.490, Na_meq = 0.465, K_meq = 0.0665,
#'                 charge_balance = 0.5)
#' water_type(d)
#'
#' # If missing HCO3_meq, use Meas_Alk_meq
#' d <- data.frame(Sample_Date = "2022-01-01", SampleID = "999990-01", StationID = 000,
#'                 Cl_meq = 0.0226, SO4_meq = 0.0208, HCO3_meq = NA, Meas_Alk_meq = 1.7,
#'                 Ca_meq = 0.187, Mg_meq = 0.490, Na_meq = 0.465, K_meq = 0.0665,
#'                 charge_balance = 0.5)
#'
#' water_type(d)
#'
#'
#' @export

water_type <- function(d) {

  if(!all(
    c("Sample_Date", "SampleID", "StationID", "Cl_meq", "SO4_meq",
      "HCO3_meq", "Meas_Alk_meq", "Ca_meq", "Mg_meq", "Na_meq", "K_meq",
      "charge_balance") %in%
    names(d))) stop("Missing required columns. See ?water_type for details",
                    call. = FALSE)

  wt <- d %>%
    # Only calculate water_type where valid charge_balance
    dplyr::filter(is_valid(charge_balance))

  if(nrow(wt) > 0) {
    wt <- wt %>%
      # If missing HCO3, try Meas_Alk
      dplyr::mutate(
        HCO3_missing = is.na(HCO3_meq),
        HCO3_meq = dplyr::if_else(is.na(HCO3_meq), Meas_Alk_meq, HCO3_meq)) %>%

      # Define Ions
      dplyr::select("Sample_Date", "SampleID", "StationID", "HCO3_missing",

                    #anions
                    "Cl_meq", "SO4_meq", "HCO3_meq",

                    #cations
                    "Ca_meq", "Mg_meq", "Na_meq", "K_meq") %>%


      tidyr::pivot_longer(cols = dplyr::ends_with("_meq"),
                          names_to = "ion", values_to = "value") %>%
      dplyr::group_by(.data$Sample_Date, .data$SampleID, .data$StationID) %>%
      dplyr::mutate(
        type = dplyr::if_else(.data$ion %in% c("Cl_meq", "SO4_meq", "HCO3_meq"),
                              "anion", "cation"),
        total = sum(.data$value, na.rm = TRUE), # Ignore missing ions
        total = dplyr::if_else(all(is.na(.data$value)), NA_real_, unique(.data$total)),
        prop = round(.data$value / .data$total, 3)
      ) %>%
      dplyr::filter(.data$prop >= 0.1) %>%
      dplyr::arrange(dplyr::desc(.data$type), dplyr::desc(.data$prop),
                     .by_group = TRUE) %>%
      dplyr::mutate(
        ion = dplyr::if_else(HCO3_missing & ion == "HCO3_meq", "HCO3*_meq", ion)) %>%
      dplyr::summarize(
        missing_ion = !all(c("anion", "cation") %in% type),
        water_type = paste0(stringr::str_remove(.data$ion, "_meq"),
                            collapse = "-"), .groups = "drop") %>%
      dplyr::select("Sample_Date", "SampleID", "StationID", "water_type", "missing_ion") %>%
      dplyr::left_join(d, ., by = c("StationID", "SampleID", "Sample_Date"))

    # select(wt, -c(1:259)) |>
    #  readr::write_csv("testing.csv",  na = "")
  } else {
    wt <- dplyr::mutate(d, water_type = NA_character_)
  }
  wt
}

#' Find the dominant water types
#'
#' Find the dominant waters type in a group of samples, if there are more than
#' `n` samples. Match HCO3 and HCO3* types. Considered dominant types if in >`p`
#' of samples.
#'
#' @param ems Data frame. EMS data for a single site.
#' @param n Numeric. Number of samples above which to remove outliers.
#' @param p Numeric. Proportion of data required to assign a dominant water
#'   type.
#'
#' @returns ems data frame with added `dominant` column (TRUE or FALSE) if the
#'   water type is in the dominant set.
#' @export

dominant_water_types <- function(d, n = 5, p = 0.75) {

  if(nrow(d) > n) {
    wt <- dplyr::filter(d, water_type != "") %>% # Also omit NA
      dplyr::mutate(water_type = stringr::str_remove(water_type, "\\*")) %>%
      dplyr::count(water_type, name = "n_wt") %>%
      dplyr::arrange(dplyr::desc(.data$n_wt), dplyr::desc(.data$water_type)) %>%
      dplyr::mutate(
        p = .data$n_wt/sum(.data$n_wt),
        cum_p1 = cumsum(p)) %>%
      dplyr::arrange(.data$n_wt, .data$water_type) %>%
      dplyr::mutate(cum_p2 = cumsum(p)) %>%
      dplyr::filter(cum_p1 <= .env$p | cum_p2 >= (1 - .env$p)) %>%
      dplyr::pull(.data$water_type)

    # Mark if domiant
    d <- dplyr::mutate(
      d,
      dominant = stringr::str_remove(.data$water_type, "\\*") %in% .env$wt)
  } else d$dominant <- TRUE
  d
}

#' Create Piper plot
#'
#' @param d  Data frame. AquaChem formatted dataset
#' @param ems_id Character. Ids to plot if dataset includes more than one
#' @param group Character. Column by which to group data for colour, shape,
#'   filled and size.
#' @param legend Logical. Whether to show the legend
#' @param legend_position Character or Numeric.. Location of legend. Must be one
#'   of "topleft", "topright", etc. (see ?legend for more options), OR a vector
#'   of two numeric values x, and y to specify an exact position.
#' @param legend_title Character. Title of legend. Defaults to `group`.
#' @param valid Logical. Keep only valid data (charge balances <=10)
#' @param plot_data Logical. Whether to return plot data rather than a plot
#' @param omit_outliers Logical. Whether to omit outliers by looking at dominant
#'   water types (see `?dominant_water_types()`). Default FALSE.
#' @param with_Alk Logical. Whether to use `Meas_Alk_meq` for `HCO3_meq` if
#'   missing. Default FALSE. Matches behaviour of `water_type()`.
#' @param point_size Numeric. Point size. Either a single value (applied to
#'   all), or a vector of values the same length as the number of `groups`.
#' @param point_colour Character. Colour or colours by which to colour points.
#'   Either a single value (applied to all), or a vector of values the same
#'   length as the number of `groups`. Can also be "viridis", which will use the
#'   viridis colour scale.
#' @param point_filled Logical. Whether to fill point shapes or not. Either a
#'   single value (applied to all), or a vector of values the same length as the
#'   number of `groups`.
#' @param point_shape Character. Shape of points to use. Valid options are
#'   "circle", "square" or "triangle". Either a single value (applied to all),
#'   or a vector of values the same length as the number of `groups`.
#'
#' @export

piper_plot <- function(d, ems_id = NULL, group = "ems_id",
                       legend = TRUE, legend_position = "topleft",
                       legend_title = group,
                       valid = TRUE, plot_data = FALSE,
                       omit_outliers = FALSE,
                       with_Alk = FALSE,
                       point_colour = "viridis",
                       point_size = 0.1,
                       point_filled = TRUE,
                       point_shape = "circle") {
  d <- d %>%
    units_remove() %>%
    dplyr::mutate(ems_id = stringr::str_extract(.data$SampleID, "^[0-9A-Z]+"))

  if(!is.null(group) & !group %in% names(d)) {
    stop("'group' must be a column in the data", call. = FALSE)
  }

  if(!is.null(ems_id)) {
    d <- dplyr::filter(d, .data$ems_id %in% !!ems_id)
  }

  if(is.null(group)) group <- "ems_id"

  if(with_Alk) {
    d <- dplyr::mutate(
      d,
      HCO3_meq = dplyr::if_else(is.na(HCO3_meq), Meas_Alk_meq, HCO3_meq))
  }

  d <- d %>%
    dplyr::arrange(.data[[group]], .data$Sample_Date) %>%
    dplyr::select(c("ems_id", "charge_balance",
                    "Ca_meq", "Mg_meq",    # X and Y Cations
                    "Na_meq", "K_meq",     # Z Cations
                    "Cl_meq",              # X Anions
                    "HCO3_meq", "CO3_meq", # Y Anions
                    "SO4_meq",             # Z Anions
                    "water_type",
                    .env$group)) %>%       # Grouping variable

    dplyr::rowwise() %>%
    dplyr::mutate(

      # Add together, ignore missing, but if both missing, NA
      Na_meq_plus = dplyr::if_else(
        is.na(.data$Na_meq) & is.na(.data$K_meq),
        NA_real_,
        sum(.data$Na_meq, .data$K_meq, na.rm = TRUE)),

      # Add together, ignore missing, but if both missing, NA
      HCO3_meq_plus = dplyr::if_else(
        is.na(.data$HCO3_meq) & is.na(.data$CO3_meq),
        NA_real_,
        sum(.data$HCO3_meq, .data$CO3_meq, na.rm = TRUE))) %>%

    dplyr::ungroup()

  # Keep only valid data if specified
  if(valid) d <- dplyr::filter(d, is_valid(charge_balance))

  if(omit_outliers) {

    # Remove outliers if they are not in the dominant set
    # - If <= 5 samples, all are considered dominant
    d <- dominant_water_types(d) %>%
      dplyr::filter(.data$dominant)
  }
  d <- dplyr::select(d, -"water_type")

  # Remove completely empty rows
  d <- d %>%
    dplyr::rowwise() %>%
    dplyr::mutate(na = sum(!is.na(dplyr::c_across(
      cols = c(-"ems_id", -"charge_balance", -.env$group))))) %>%
    dplyr::filter(.data$na > 0)

  if(nrow(d) == 0) {
    message("Not enough ", dplyr::if_else(valid, "good quality ", ""), "data for this EMS ID")
    return(invisible())
  }

  if(!plot_data){
    g_labs <- unique(d[[group]])
    g <- length(g_labs)

    if(g < 1) stop("Not enough groups in 'groups'", call. = FALSE)

    if(!is.null(point_colour)) {
      if(length(point_colour) == 1) {
        if(point_colour == "viridis") {
          point_colour <- viridisLite::viridis(n = g, end = 0.8)
        } else point_colour <- point_colour
      } else if(length(point_colour) != g) {
        stop("The number of `point_colour` doesn't match the number of ",
             "categories in 'group'", call. = FALSE)
      }
    } else point_colour <- rep("black", g)

    if(!is.null(point_shape)) {
      point_shape[point_shape == "triangle"] <- "uptri"

      if(length(point_shape) == 1) {
        point_shape <- rep(point_shape, g)
      } else if(length(point_shape) != g) {
        stop("The number of `point_shape` doesn't match the number of ",
             "categories in 'group'", call. = FALSE)
      }
    }

    if(!is.null(point_filled)) {
      if(length(point_filled) == 1) {
        point_filled <- rep(point_filled, g)
      } else if(length(point_filled) != g) {
        stop("The number of `point_filled` doesn't match the number of ",
             "categories in 'group'", call. = FALSE)
      }
    }

    if(!is.null(point_size)) {
      if(length(point_size) == 1) {
        point_size <- rep(point_size, g)
      } else if(length(point_size) != g) {
        stop("The number of `point_size` doesn't match the number of ",
             "categories in 'group'", call. = FALSE)
      }
    }

    i <- 1
    opts <- list(name = g_labs[i],
                 color = point_colour[i],
                 symbol = point_shape[i],
                 size = point_size[i],
                 filled = point_filled[i])
    p <- piper_plot_single(
      data = dplyr::filter(d, .data[[group]] == g_labs[i]),
      plot = p, n = i, opts = opts)

    if(g > 1) {
      for(i in 2:g) {
        opts <- list(name = g_labs[i],
                     color = point_colour[i],
                     symbol = point_shape[i],
                     size = point_size[i],
                     filled = point_filled[i])
        piper_plot_single(
          data = dplyr::filter(d, .data[[group]] == g_labs[i]),
          plot = p, n = i, opts = opts)
      }
    }


    if(legend) {
      pts <- dplyr::tribble(~shape, ~filled, ~pch,
                          "circle", TRUE, 19,
                          "square", TRUE, 15,
                          "uptri", TRUE, 17,
                          "circle", FALSE, 1,
                          "square", FALSE, 0,
                          "uptri", FALSE, 2)
      pch <- dplyr::inner_join(data.frame(shape = point_shape,
                                         filled = point_filled),
                               pts, by = c("shape", "filled")) %>%
        dplyr::pull(.data$pch)

      if(length(legend_position) == 2 && is.numeric(legend_position)) {
        x <- legend_position[1]
        y <- legend_position[2]
      } else {
        x <- legend_position[1]
        y <- NULL
      }

      legend(x = x, y = y, title = legend_title,
             legend = g_labs, border = "white",
             bty = "n", pch = pch, col = point_colour,
             title.font = 2,
             pt.cex = point_size + 1.1, cex = 0.9, xpd = TRUE)
    } else p
  } else {
    d
  }
}


piper_plot_single <- function(data, plot = NULL, n = 1, opts) {

  if(n == 1) {
    pp <- with(data, smwrGraphs::piperPlot(
      xCat = Ca_meq, yCat = Mg_meq, zCat = Na_meq_plus,
      xAn = Cl_meq, yAn = HCO3_meq_plus, zAn = SO4_meq,

      xCat.title = "Ca",
      yCat.title = "Mg",
      zCat.title = "Na + K",

      xAn.title = "Cl",
      yAn.title = "HCO3 + CO3",
      zAn.title = "SO4",

      x.yCat.title = "Ca + Mg",
      x.zAn.title = "Cl + SO4",

      units.title = "",
      Plot = opts))
  } else {
    pp <- with(data, smwrGraphs::addPiper(
      xCat = Ca_meq, yCat = Mg_meq, zCat = Na_meq_plus,
      xAn = Cl_meq, yAn = HCO3_meq_plus, zAn = SO4_meq,
      Plot = opts, current = plot))
  }

  pp
}


#' Create Stiff plot
#'
#' @param d  AquaChem formatted dataset
#' @param ems_id Ids to plot if dataset includes more than one
#' @param colour Whether to add colour by ems_id
#' @param legend Whether to show the legend
#' @param valid Logical. Keep only valid data (charge balances <=10)
#'
#' @export

stiff_plot <- function(d, ems_id = NULL, colour = TRUE, legend = TRUE,
                       valid = TRUE) {


  d <- d %>%
    units_remove() %>%
    dplyr::mutate(ems_id = stringr::str_extract(.data$SampleID, "^[0-9A-Z]+"))

  if(!is.null(ems_id)) {
    if(length(ems_id) > 1 & !colour) {
      stop("Can only specify one ems_id at a time unless 'colour = TRUE'",
           call. = FALSE)
    }
    d <- dplyr::filter(d, .data$ems_id %in% !!ems_id)
  } else if(length(unique(d$ems_id)) > 1 & !colour) {
    stop("With more than one ems_id included in data, need to specify which id ",
         "OR 'colour = TRUE'" , call. = FALSE)
  }

  d <- dplyr::select(d, c("ems_id", "SampleID", "charge_balance",
                          "Ca_meq", "Mg_meq", "Na_meq",
                          "Cl_meq", "HCO3_meq", "SO4_meq"))

  # Keep only valid data if specified
  if(valid) d <- dplyr::filter(d, is_valid(charge_balance))

  # Remove rows with any NAs
  d <- d %>%
    dplyr::rowwise() %>%
    dplyr::mutate(na = sum(is.na(dplyr::c_across(
      cols = c(-"ems_id", -"SampleID", -"charge_balance"))))) %>%
    dplyr::filter(.data$na == 0)

  if(nrow(d) == 0) {
    message("Not enough ", dplyr::if_else(valid, "good quality ", ""), "data for this EMS ID")
    return(invisible())
  }

  stiff <- d %>%
    tidyr::pivot_longer(cols = c("Ca_meq", "Mg_meq", "Na_meq",
                                 "Cl_meq", "HCO3_meq", "SO4_meq"),
                        names_to = "element", values_to = "value") %>%
    dplyr::mutate(y = dplyr::case_when(.data$element == "Ca_meq" ~ 0,
                                       .data$element == "Mg_meq" ~ 1,
                                       .data$element == "Na_meq" ~ 2,
                                       .data$element == "Cl_meq" ~ 0,
                                       .data$element == "HCO3_meq" ~ 2,
                                       .data$element == "SO4_meq" ~ 1),
                  value = dplyr::if_else(.data$element %in% c("Ca_meq", "Mg_meq", "Na_meq"),
                                         -.data$value, .data$value),
                  element = factor(.data$element,
                                   levels = c("Ca_meq", "Mg_meq", "Na_meq",
                                              "HCO3_meq", "SO4_meq", "Cl_meq"))) %>%
    dplyr::arrange(.data$SampleID, .data$element) %>%
    dplyr::group_by(.data$SampleID) %>%
    dplyr::mutate(sample = factor(paste(.data$SampleID, .data$y)),
                  n = sum(!is.na(.data$value)),
                  element = stringr::str_remove(.data$element, "_meq")) %>%
    dplyr::filter(.data$n == 6)

  if(colour) fill <- "ems_id" else fill <- NULL
  ggplot2::ggplot(stiff, ggplot2::aes(x = .data$value, y = .data$sample,
                                      group = .data$SampleID, fill = .data[[fill]])) +
    ggplot2::theme_classic() +
    ggplot2::theme(axis.title.y = ggplot2::element_blank()) +
    ggplot2::geom_polygon(colour = "black", show.legend = legend) +
    ggplot2::geom_vline(xintercept = 0) +
    ggrepel::geom_label_repel(ggplot2::aes(label = .data$element), fill = "white",
                              min.segment.length = 0) +
    ggplot2::scale_y_discrete(labels = function(x) stringr::str_remove(x, " [0-9]{1}$"),
                              breaks = function(x) x[seq(2, by = 3, along.with = x)]) +
    ggplot2::scale_x_continuous(limits = function(x) c(-max(abs(x)), max(abs(x)))) +
    ggplot2::labs(x = "Milliequivalents per litre") +
    ggplot2::facet_wrap(~ ems_id, scales = "free_y") +
    ggplot2::scale_fill_viridis_d(name = "EMS ID", end = 0.8)
}


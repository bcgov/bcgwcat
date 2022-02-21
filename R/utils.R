#' Remove units
#'
#' The main `rems_to_aquachem()` function downloads EMS data and formats it for
#' use in the external program, AquaChem. However, occasionally you may wish
#' to work with this formatted EMS data in R. This function removes the extra
#' 'units' row and then converts the columns to make the data useable in R.
#'
#' @param d Data frame output from `rems_to_aquachem()`
#'
#' @return Data frame
#' @export
#'
#' @examples
#'
#' \dontrun{
#' # Get and format one well for use in aquachem
#' r <- rems_to_aquachem(ems_ids = "E289551", save = FALSE)
#'
#' # Remove units and convert columns to appropriate formats for use in R
#' r <- units_remove(r)
#'
#' }
#'
units_remove <- function(d) {

  num <- params %>%
    dplyr::filter(.data$data_type == "numeric", !is.na(.data$aqua_code)) %>%
    dplyr::pull(.data$aqua_code)
  num <- c(num, stringr::str_subset(names(d), "(_meq)|(_p)"))
  date <- dplyr::filter(params, .data$data_type == "date", !is.na(.data$aqua_code)) %>%
    dplyr::pull(.data$aqua_code)

  d %>%
    dplyr::slice(-1) %>%
    dplyr::mutate(dplyr::across(dplyr::any_of(num), as.numeric)) %>%
    dplyr::mutate(dplyr::across(dplyr::any_of(date), lubridate::as_date))
}

units_convert <- function(x, from, to) {
  dplyr::case_when(from == "mg/L" & to == "ug/L" ~ x * 1000,
                   from == "ug/L" & to == "mg/L" ~ x / 1000,
                   from == to | (is.na(from) & is.na(to)) ~ x,
                   TRUE ~ NA_real_)
}

meq <- function(d, format = "long") {

  meq_params <- dplyr::filter(params, !is.na(.data$smwr_code)) %>%
    dplyr::select("aqua_code", "smwr_code")

  if(format == "long") {
    # Values all in mg/L (RESULT) which is the standard reported by EMS and used by
    # smwrBase for these elements

    d2 <- dplyr::left_join(meq_params, d, by = "aqua_code") %>%
      dplyr::mutate(RESULT = purrr::map2_dbl(.data$RESULT, .data$smwr_code,
                                             ~smwrBase::conc2meq(.x, .y)),
                    RESULT2 = .data$RESULT,
                    aqua_code = paste0(.data$aqua_code, "_meq"),
                    UNIT = "meq",
                    aqua_unit = "meq") %>%
      dplyr::select(-"smwr_code")
    d <- dplyr::bind_rows(d, d2)
  }

  if(format == "wide") {
    d <- d %>%
      dplyr::mutate(
        dplyr::across(dplyr::any_of(meq_params$aqua_code),
                      ~ smwrBase::conc2meq(
                        .x,
                        meq_params$smwr_code[meq_params$aqua_code == .x]),
                      .names = "{.col}_meq"))
  }
  d
}


#' Calculate charge balance
#'
#' @param d AquaChem formatted dataset
#'
#' From ALS Global (AquaChem code)
#'
#' anion sum = p01/35.45 + p02/48.03 + p03/19 + p04/14.01 + p05/14.01 + p06/50.04
#'
#' - P01 = chloride          (Cl)
#' - P02 = sulfate           (SO4)
#' - P03 = fluoride          (F)
#' - P04 = nitrate as N      (NO3)
#' - P05 = nitrite as N      (NO2)
#' - P06 = alkalinity total  (Meas_Alk)
#'
#' cation sum = p01/20.04 + p02/12.16 + p03/22.99 + p04/39.10 + p05/8.99 +
#'              p06/31.77 + p07/27.9 + p08/27.47 + p09/32.70 + p10/14.01 +
#'              func_pow((10),(-1*p11))*1000
#'
#' - P01 = calcium    (Ca)      [dissolved]
#' - P02 = magnesium  (Mg)      [dissolved]
#' - P03 = sodium     (Na)      [dissolved]
#' - P04 = potassium  (K)       [dissolved]
#' - P05 = aluminum   (Al_diss) [dissolved]
#' - P06 = copper     (Cu_diss) [dissolved]
#' - P07 = iron       (Fe_diss) [dissolved]
#' - P08 = manganese  (Mn_diss) [dissolved]
#' - P09 = zinc       (Zn_diss) [dissolved]
#' - P10 = ammonia    (NH4)     [dissolved]
#' - P11 = pH         (pH_lab)
#'
#' Charge balance = 100 x (Cation Sum - Anion sum) / (Cation Sum + Anion Sum)
#'
#' For ALS, the values are converted to MEQ in the equation.
#'
#' For charge_balance() some are preconverted `_meq` some are converted in the
#' equations.
#'
#' @return Data frame
#'
#'
charge_balance <- function(d) {

  d %>%
    dplyr::mutate(
      anion_sum2 = .data$Cl_meq + .data$SO4_meq + .data$F_meq + .data$NO3_meq +
        .data$NO2_meq + .data$Meas_Alk/50.04,

      cation_sum2 = .data$Ca_meq + .data$Mg_meq + .data$Na_meq + .data$K_meq +
        .data$Al_diss_meq + .data$Cu_diss/31.77 + .data$Fe_diss_meq +
        .data$Mn_diss_meq + .data$Zn_diss/32.695 + .data$NH4/14.01 +
        (10^(-.data$pH_lab)) * 1000,

      charge_balance2 = 100 * ((.data$cation_sum2 - .data$anion_sum2) /
                                 (.data$cation_sum2 + .data$anion_sum2)),

      anion_sum2 = round(.data$anion_sum2, 2),
      cation_sum2 = round(.data$cation_sum2, 2),
      charge_balance2 = round(.data$charge_balance2))

}

water_type <- function(d) {

  d_new <- d %>%
    dplyr::mutate(

      total = .data$Cl_meq + .data$SO4_meq + .data$HCO3_meq +     # Anions
        .data$Ca_meq + .data$Mg_meq + .data$Na_meq + .data$K_meq, # Cations

      # Anion proportions
      Cl_p = .data$Cl_meq / .data$total,
      SO4_p = .data$SO4_meq / .data$total,
      HCO3_p = .data$HCO3_meq / .data$total,

      # Cation proportions
      Ca_p = .data$Ca_meq / .data$total,
      Mg_p = .data$Mg_meq / .data$total,
      Na_p = .data$Na_meq / .data$total,
      K_p = .data$K_meq / .data$total) %>%
    dplyr::mutate(dplyr::across(dplyr::ends_with("_p"), ~round(., 3))) %>%
    dplyr::select(-"total")


  d_wt <- d_new %>%
    dplyr::select("StationID", "SampleID", "Sample_Date",
                  dplyr::ends_with("_p")) %>%
    tidyr::pivot_longer(cols = dplyr::ends_with("_p"), names_to = "element",
                        values_to = "prop") %>%
    dplyr::filter(prop >= 0.1) %>%
    dplyr::mutate(type = dplyr::if_else(element %in% c("Cl_p", "HCO3_p", "SO4_p"),
                                 "anion", "cation")) %>%
    dplyr::group_by(.data$StationID, .data$SampleID, .data$Sample_Date) %>%
    dplyr::arrange(dplyr::desc(type), dplyr::desc(prop), .by_group = TRUE) %>%
    dplyr::summarize(water_type = paste0(stringr::str_remove(element, "_p"),
                                      collapse = "-"))

  dplyr::left_join(d_new, d_wt, by = c("StationID", "SampleID", "Sample_Date"))
}

#' Create Piper plot
#'
#' @param d  AquaChem formatted dataset
#' @param ems_id Ids to plot if dataset includes more than one
#' @param point_size Point size
#' @param colour Whether to add colour by ems_id
#' @param legend Whether to show the legend
#'
#' @export

piper_plot <- function(d, ems_id = NULL, point_size = 0.1,
                       colour = TRUE, legend = TRUE) {
  d <- d[-1, ] %>%
    dplyr::mutate(ems_id = stringr::str_extract(.data$SampleID, "^[0-9A-Z]+"))

  if(!is.null(ems_id)) {
    if(length(ems_id) > 1 & !colour) {
      stop("Can only specify one ems_id at a time unless 'colour = TRUE'",
           call. = FALSE)
    }
    d <- dplyr::filter(d, .data$ems_id %in% !!ems_id)
  } else if(length(unique(d$ems_id)) > 1 & !colour) {
    stop("With more than one ems_id included in data, need to specify which id ",
         "OR 'colour = TRUE'", call. = FALSE)
  }

  d <- dplyr::select(d, c("ems_id", "Ca_meq", "Mg_meq", "Na_meq",
                          "Cl_meq", "HCO3_meq", "SO4_meq")) %>%
    dplyr::mutate(dplyr::across(-"ems_id", as.numeric))

  if(colour) {
    col <- list(name = unique(d$ems_id),
                color = viridisLite::viridis(n = length(unique(d$ems_id)), end = 0.8),
                size = point_size)
  } else {
    col <- list()
  }

  pp <- with(d, smwrGraphs::piperPlot(
    Ca_meq, Mg_meq, Na_meq,
    Cl_meq, HCO3_meq, SO4_meq,
    x.zAn.title = "Cl + SO4",
    x.yCat.title = "Ca + Mg",
    zCat.title = "Na + K",
    #xAn.title = "Cl",
    xAn.title = "Cl- + F- + NO2- + NO3-",
    yAn.title = "HCO3 + CO3",
    zAn.title = "SO4",
    xCat.title = "Ca",
    yCat.title = "Mg",
    units.title = "",
    Plot = col))

  if(legend) smwrGraphs::addExplanation(pp, title = "EMS ID", where = "ul", box.off = FALSE)
}

#' Create Stiff plot
#'
#' @param d  AquaChem formatted dataset
#' @param ems_id Ids to plot if dataset includes more than one
#' @param colour Whether to add colour by ems_id
#' @param legend Whether to show the legend
#'
#' @export

stiff_plot <- function(d, ems_id = NULL, colour = TRUE, legend = TRUE) {

  d <- d[-1, ] %>%
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

  stiff <- dplyr::select(d, c("ems_id", "SampleID", "Ca_meq", "Mg_meq", "Na_meq",
                              "Cl_meq", "HCO3_meq", "SO4_meq")) %>%
    dplyr::mutate(dplyr::across(c(-"ems_id", -"SampleID"), as.numeric)) %>%
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

  if(nrow(stiff) == 0) stop("Not enough non-NA data to plot", call. = FALSE)

  if(colour) fill <- "ems_id" else fill <- NULL
  ggplot2::ggplot(stiff, ggplot2::aes_string(x = "value", y = "sample",
                                                  group = "SampleID", fill = fill)) +
    ggplot2::theme_classic() +
    ggplot2::theme(axis.title.y = ggplot2::element_blank()) +
    ggplot2::geom_polygon(colour = "black", show.legend = legend) +
    ggplot2::geom_vline(xintercept = 0) +
    ggrepel::geom_label_repel(ggplot2::aes_string(label = "element"), fill = "white",
                              min.segment.length = 0) +
    ggplot2::scale_y_discrete(labels = function(x) stringr::str_remove(x, " [0-9]{1}$"),
                              breaks = function(x) x[seq(2, by = 3, along.with = x)]) +
    ggplot2::scale_x_continuous(limits = function(x) c(-max(abs(x)), max(abs(x)))) +
    ggplot2::labs(x = "Milliequivalents per litre") +
    ggplot2::facet_wrap(~ ems_id, scales = "free_y") +
    ggplot2::scale_fill_viridis_d(name = "EMS ID", end = 0.8)
}


units_remove <- function(d) {

  num <- dplyr::filter(params, data_type == "numeric", !is.na(aqua_code)) %>%
    dplyr::pull(aqua_code)
  num <- c(num, "Ca_meq", "Mg_meq", "Na_meq", "K_meq", "Cl_meq",
           "HCO3_meq", "SO4_meq")
  date <- dplyr::filter(params, data_type == "date", !is.na(aqua_code)) %>%
    dplyr::pull(aqua_code)

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

  if(format == "long") {
    # Values all in mg/L (RESULT) which is the standard reported by EMS and used by
    # smwrBase for these elements
   d2 <- d %>%
     dplyr::filter(.data$aqua_code %in% c("Ca", "Mg", "Na", "K", "Cl", "HCO3", "SO4")) %>%
     dplyr::mutate(type = dplyr::case_when(.data$aqua_code == "Ca" ~ "calcium",
                                           .data$aqua_code == "Mg" ~ "magnesium",
                                           .data$aqua_code == "Na" ~ "sodium",
                                           .data$aqua_code == "K" ~ "potassium",
                                           .data$aqua_code == "Cl" ~ "chloride",
                                           .data$aqua_code == "HCO3" ~ "bicarb",
                                           .data$aqua_code == "SO4" ~ "sulfate"),
                   RESULT = purrr::map2_dbl(.data$RESULT, .data$type,
                                            ~smwrBase::conc2meq(.x, .y)),
                   RESULT2 = .data$RESULT,
                   aqua_code = paste0(.data$aqua_code, "_meq"),
                   UNIT = "meq",
                   aqua_unit = "meq") %>%
     dplyr::select(-"type")
   d <- dplyr::bind_rows(d, d2)
  }

  if(format == "wide") {
    d <- dplyr::mutate(d,
                       Ca_meq = smwrBase::conc2meq(.data$Ca, "calcium"),
                       Mg_meq = smwrBase::conc2meq(.data$Mg, "magnesium"),
                       Na_meq = smwrBase::conc2meq(.data$Na, "sodium"),
                       K_meq = smwrBase::conc2meq(.data$K, "potassium"),
                       Cl_meq = smwrBase::conc2meq(.data$Cl, "chloride"),
                       HCO3_meq = smwrBase::conc2meq(.data$HCO3, "bicarb"),
                       SO4_meq = smwrBase::conc2meq(.data$SO4, "sulfate"))
  }
  d
}


#' Calculate charge balance
#'
#' @param d AquaChem formatted dataset
#' @param return Return "all" columns or only "relevant" columns?
#'
#' @return Data frame
#'
#'
charge_balance <- function(d) {
  d %>%
    dplyr::mutate(cations = .data$Ca_meq + .data$Mg_meq + .data$Na_meq + .data$K_meq,
                  anions = .data$Cl_meq + .data$HCO3_meq + .data$SO4_meq,
                  charge_balance = ((.data$cations - abs(.data$anions)) /
                                      (.data$cations + abs(.data$anions))) * 100)
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
                  n = sum(!is.na(.data$value))) %>%
    dplyr::filter(.data$n == 6)

  if(colour) fill <- "ems_id" else fill <- NULL
  ggplot2::ggplot(stiff, ggplot2::aes_string(x = "value", y = "sample",
                                                  group = "SampleID", fill = fill)) +
    ggplot2::theme_classic() +
    ggplot2::theme(axis.title.y = ggplot2::element_blank()) +
    ggplot2::geom_polygon(colour = "black", show.legend = legend) +
    ggplot2::geom_vline(xintercept = 0) +
    ggplot2::scale_y_discrete(labels = function(x) stringr::str_remove(x, " [0-9]{1}$"),
                              breaks = function(x) x[seq(2, by = 3, along.with = x)]) +
    ggplot2::scale_x_continuous(limits = function(x) c(-max(abs(x)), max(abs(x)))) +
    ggplot2::labs(x = "Milliequivalents per litre") +
    ggplot2::facet_wrap(~ ems_id, scales = "free_y") +
    ggplot2::scale_fill_viridis_d(name = "EMS ID", end = 0.8)
}


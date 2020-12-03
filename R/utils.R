meq <- function(d) {
  dplyr::mutate(d,
                Ca_meq = smwrBase::conc2meq(.data$Ca, "calcium"),
                Mg_meq = smwrBase::conc2meq(.data$Mg, "magnesium"),
                Na_meq = smwrBase::conc2meq(.data$Na, "sodium"),
                Cl_meq = smwrBase::conc2meq(.data$Cl, "chloride"),
                HCO3_meq = smwrBase::conc2meq(.data$HCO3, "bicarb"),
                SO4_meq = smwrBase::conc2meq(.data$SO4, "sulfate"))
}


#' Calculate charge balance
#'
#' @param d AquaChem formatted dataset
#' @param return Return "all" columns or only "relevant" columns?
#'
#' @return Data frame
#' @export
#'
charge_balance <- function(d) {
  d %>%
    dplyr::mutate(cations = .data$Ca_meq + .data$Mg_meq + .data$Na_meq,
                  anions = .data$Cl_meq + .data$HCO3_meq + .data$Na_meq,
                  charge_balance = ((.data$cations - abs(.data$anions)) /
                                      (.data$cations + abs(.data$anions))) * 100)
}


#' Create Piper plot
#'
#' @param d  AquaChem formatted dataset
#' @param ems_id Ids to plot if dataset includes more than one
#'
#' @export

piper_plot <- function(d, ems_id = NULL) {

  d <- d[-1, ]

  if(!is.null(ems_id)) {
    if(length(ems_id) > 1) stop("Can only specify one ems_id at a time", call. = FALSE)
    d <- dplyr::filter(d, stringr::str_extract(.data$SampleID, "^[0-9A-Z]+") %in% ems_id)
  } else if(length(unique(d$StationID)) > 1) {
    stop("With more than one ems_id included in data, need to specify which id", call. = FALSE)
  }


  d <- dplyr::select(d, c("SampleID", "Ca_meq", "Mg_meq", "Na_meq", "Cl_meq", "HCO3_meq", "SO4_meq")) %>%
    dplyr::mutate(dplyr::across(-"SampleID", as.numeric))

  with(d, smwrGraphs::piperPlot(Ca_meq, Mg_meq, Na_meq,
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
                                 units.title = ""))
}

#' Create Stiff plot
#'
#' @param d  AquaChem formatted dataset
#' @param ems_id Ids to plot if dataset includes more than one
#'
#' @export

stiff_plot <- function(d, ems_id = NULL) {

  d <- d[-1, ]

  if(!is.null(ems_id)) {
    if(length(ems_id) > 1) stop("Can only specify one ems_id at a time", call. = FALSE)
    d <- dplyr::filter(d, stringr::str_extract(.data$SampleID, "^[0-9A-Z]+") %in% ems_id)
  } else if(length(unique(d$StationID)) > 1) {
    stop("With more than one ems_id included in data, need to specify which id", call. = FALSE)
  }

  stiff <- dplyr::select(d, c("SampleID", "Ca_meq", "Mg_meq", "Na_meq", "Cl_meq", "HCO3_meq", "SO4_meq")) %>%
    dplyr::mutate(dplyr::across(-"SampleID", as.numeric)) %>%
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

  ggplot2::ggplot(stiff, ggplot2::aes_string(x = "value", y = "sample", group = "SampleID")) +
    ggplot2::theme_classic() +
    ggplot2::theme(axis.title.y = ggplot2::element_blank()) +
    ggplot2::geom_polygon(colour = "black", fill = "grey50") +
    ggplot2::geom_vline(xintercept = 0) +
    ggplot2::scale_y_discrete(labels = function(x) stringr::str_remove(x, " [0-9]{1}$"),
                              breaks = function(x) x[seq(2, by = 3, along.with = x)]) +
    ggplot2::scale_x_continuous(limits = function(x) c(-max(abs(x)), max(abs(x)))) +
    ggplot2::labs(x = "Milliequivalents per litre")
}


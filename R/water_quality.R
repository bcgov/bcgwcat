
#' Assess problems with water quality
#'
#' @param d EMS data formated for AquaChem as returned by `rems_to_aquachem()`
#'
#' @return Tibble of sites, samples, parameters, water quality limits and problems.
#' @export
#'
water_quality <- function(d) {
  d %>%
    units_remove() %>%
    dplyr::select("StationID", "SampleID", "Sample_Date",
                  dplyr::any_of(wq_std$aqua_code)) %>%
    tidyr::pivot_longer(cols = c(-"StationID", -"SampleID", -"Sample_Date"),
                        names_to = "aqua_code") %>%
    dplyr::left_join(dplyr::select(wq_std, -"uniqueid", -"variable", -"component", -"ems_code"),
                     by = "aqua_code", multiple = "all") %>%
    dplyr::left_join(dplyr::select(params, "aqua_code", "aqua_unit"),
                     by = "aqua_code", multiple = "all") %>%
    dplyr::mutate(value2 = units_convert(.data$value, .data$aqua_unit, .data$units),
                  quality_problem = dplyr::if_else(.data$value2 > .data$limit, TRUE, FALSE))
}
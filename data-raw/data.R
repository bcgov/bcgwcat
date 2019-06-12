params <- readr::read_csv("data-raw/params_list.csv")

library(bcdata)

#bcdc_search("WHSE_WATER_MANAGEMENT.GW_WATER_WELLS_WRBC_SVW")

ow <- bcdc_get_data("e4731a85-ffca-4112-8caf-cb0a96905778") %>%
  as.data.frame() %>%
  dplyr::select(ow = OBSERVATION_WELL_NUMBER, ems_id = CHEMISTRY_SITE_ID) %>%
  dplyr::filter(!is.na(ow), !is.na(ems_id))


usethis::use_data(params, ow, internal = TRUE, overwrite = TRUE)

# Copyright 2021 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and


params <- readr::read_csv("data-raw/params_list.csv") %>%
  dplyr::mutate(water_quality = tidyr::replace_na(water_quality, TRUE),
                # Add missing leading zeros
                rems_code = dplyr::if_else(stringr::str_detect(rems_code, "^[0-9]{1,3}$"),
                                           stringr::str_pad(rems_code, width = 4, pad = "0"),
                                           rems_code))


httr::GET("https://s3.ca-central-1.amazonaws.com/gwells-export/export/gwells.zip",
          httr::write_disk("gwells.zip", overwrite = TRUE), httr::progress())
unzip("gwells.zip", files = "well.csv", overwrite = TRUE)

ow <- readr::read_csv("well.csv", guess_max = 200000) %>%
  dplyr::select(ow = observation_well_number, ems_id = ems) %>%
  dplyr::filter(!is.na(ow), !is.na(ems_id))

wq_std <- bcdata::bcdc_get_data("85d3990a-ec0a-4436-8ebd-150de3ba0747") %>%
  dplyr::rename_all(tolower) %>%
  dplyr::filter(use == "Drinking Water", media == "Water",
                direction == "Upper Limit",   # All upper limit anyway, but be explicit
                type == "Maximum Acceptable Concentration") %>% # Remove Aesthetic objectives
  dplyr::mutate(ems_code = stringr::str_remove(ems_code, "^EMS_"),
                ems_code = stringr::str_replace_all(ems_code, "_", "-")) %>%
  dplyr::filter(ems_code %in% params$rems_code, !is.na(ems_code),
                days == 1,
                !is.na(limit),
                !uniqueid %in% c(588, 624)) %>%  # remove Nitrate and Nitrite "reported as N."
  dplyr::select(uniqueid, variable, component, ems_code, limit, limitnotes,
                units, condition, predictedeffectlevel, status) %>%
  dplyr::left_join(dplyr::select(params, rems_code, aqua_code),
                   by = c("ems_code" = "rems_code")) %>%
  dplyr::mutate(limit = as.numeric(limit))

usethis::use_data(params, ow, wq_std, internal = TRUE, overwrite = TRUE)

unlink("gwells.zip")
unlink("well.csv")


# MEQ Conversions ------------------------------------
# Atomic mass values from https://en.wikipedia.org/wiki/List_of_elements_by_atomic_properties

meq_conversion <- dplyr::tribble(
  ~param,     ~mass,         ~valency_state,
  # Anions
  "Cl",       35.453,                 1,
  "SO4",      32.065 + 4*(15.9994),   2,
  "F",        18.9984032,             1,
  "NO3",      14.0067,                1,           # as N
  "NO2",      14.0067,                1,           # as N
  "Meas_Alk", 40.078 + 12.0107 + 3*(15.9994), 2,   # as CaCO3
  "HCO3",     1.007 + 12.0107 + 3*(15.9994),  1,
  "CO3",      12.0107 + 3*(15.9994),          2,

  # Cations
  "Ca",       40.078,                 2,
  "Mg",       24.3050,                2,
  "Na",       22.98976928,            1,
  "K",        39.0983,                1,
  "Al_diss",   8.993615,              1,
  "Cu_diss",  63.546,                 2,
  "Fe_diss",  55.845,                 2,
  "Mn_diss",  54.938045,              2,
  "Zn_diss",  65.38,                  2,
  "NH4",      14.0067,                1,           # as N
  ) %>%
  dplyr::mutate(conversion = round(mass / valency_state, 5)) %>%
  dplyr::arrange(param)

usethis::use_data(meq_conversion, internal = FALSE, overwrite = TRUE)



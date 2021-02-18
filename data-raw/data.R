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

params <- readr::read_csv("data-raw/params_list.csv")

httr::GET("https://s3.ca-central-1.amazonaws.com/gwells-export/export/gwells.zip",
          httr::write_disk("gwells.zip", overwrite = TRUE), httr::progress())
unzip("gwells.zip", files = "well.csv", overwrite = TRUE)

ow <- readr::read_csv("well.csv", guess_max = 200000) %>%
  dplyr::select(ow = observation_well_number, ems_id = ems) %>%
  dplyr::filter(!is.na(ow), !is.na(ems_id))


usethis::use_data(params, ow, internal = TRUE, overwrite = TRUE)

unlink("gwells.zip")
unlink("well.csv")

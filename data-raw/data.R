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

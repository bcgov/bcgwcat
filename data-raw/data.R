params <- readr::read_csv("data-raw/params_list.csv")
usethis::use_data(params, internal = TRUE, overwrite = TRUE)

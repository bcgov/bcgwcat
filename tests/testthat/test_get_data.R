


test_that("general returned data", {
  expect_message(r1 <- rems_to_aquachem(ems_ids = c("1401030", "1401377", "E292373")),
                 "Last download") %>%
    expect_message("Checking for locally stored historical") %>%
    expect_message("If you would like") %>%
    expect_message("Checking for locally stored recent") %>%
    expect_message("Fetching data")

  expect_snapshot_value(r1, style = "json2")

  expect_message(r2 <- rems_to_aquachem(ems_ids = c("1401030", "1401377"),
                                        date_range = c("1991-01-01", "1992-01-01")),
               "Last download") %>%
  expect_message("Checking for locally stored historical") %>%
  expect_message("If you would like") %>%
  expect_message("Some EMS ID")

  expect_snapshot_value(r2, style = "json2")

  unlink(list.files(pattern = "aquachem_[0-9]{4}-[0-9]{2}-[0-9]{2}.csv"))
})

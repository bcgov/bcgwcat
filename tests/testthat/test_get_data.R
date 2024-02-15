


test_that("general returned data", {
  skip_on_ci()
  expect_message(r1 <- rems_to_aquachem(ems_ids = c("1401030", "1401377", "E292373"),
                                        interactive = FALSE),
                 "Checking for locally stored") %>%
    expect_message("Fetching data") %>%
    suppressMessages()

  expect_snapshot_value(r1, style = "json2")

  expect_message(r2 <- rems_to_aquachem(ems_ids = c("1401030", "1401377"),
                                        date_range = c("1991-01-01", "1992-01-01"),
                                        interactive = FALSE),
                 "Some EMS ID") %>%
    suppressMessages()

  expect_snapshot_value(r2, style = "json2")

  unlink(list.files(pattern = "aquachem_[0-9]{4}-[0-9]{2}-[0-9]{2}.csv"))
})

test_that("water_quality()", {
  expect_message(r1 <- rems_to_aquachem(ems_ids = c("1401030", "1401377", "E292373"),
                                        interactive = FALSE, save = FALSE)) %>%
    suppressMessages()
  expect_silent(w1 <- water_quality(r1))

  expect_snapshot_value(w1, style = "json2")

  expect_message(r2 <- rems_to_aquachem(ems_ids = c("1401030", "1401377"),
                                        date_range = c("1991-01-01", "1992-01-01"),
                                        interactive = FALSE, save = FALSE)) %>%
    suppressMessages()

  expect_silent(w2 <- water_quality(r2))

  expect_snapshot_value(w2, style = "json2")

})
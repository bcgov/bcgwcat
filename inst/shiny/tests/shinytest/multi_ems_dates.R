app <- ShinyDriver$new("../../", loadTimeout = 100000)
app$snapshotInit("multi_ems_dates")

app$setInputs(ems_ids = "\"1401030\", \"1401377\"",
              date_range = c("1990-01-01", "2000-01-01"),
              get_data = "click", timeout_ = 50000)
app$setInputs(data_rows_current = c(1, 2, 3, 4), allowInputNoBinding_ = TRUE,
              wait_ = FALSE, values_ = FALSE)
app$setInputs(data_rows_all = c(1, 2, 3, 4), allowInputNoBinding_ = TRUE,
              wait_ = FALSE, values_ = FALSE)
app$snapshot()

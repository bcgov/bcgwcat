app <- ShinyDriver$new("../")
app$snapshotInit("single_ems_dates")

app$setInputs(ems_ids = "1401030")
app$setInputs(date_range = c("2000-01-01", "2099-01-01"))
app$setInputs(get_data = "click", timeout_ = 50000)
app$setInputs(data_rows_current = c(1, 2, 3, 4, 5, 6), allowInputNoBinding_ = TRUE,
              wait_ = FALSE, values_ = FALSE)
app$setInputs(data_rows_all = c(1, 2, 3, 4, 5, 6), allowInputNoBinding_ = TRUE,
              wait_ = FALSE, values_ = FALSE)
app$snapshot()

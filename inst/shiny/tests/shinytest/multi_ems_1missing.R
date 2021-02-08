app <- ShinyDriver$new("../../", loadTimeout = 100000)
app$snapshotInit("multi_ems_1missing")

app$setInputs(ems_ids = "\"1401030\", \"1401377\"",
              date_range = c("1991-01-01", "1992-01-01"),
              get_data = "click", timeout_ = 50000)
app$setInputs(box = "Results")
app$setInputs(data_rows_current = c(1, 2), allowInputNoBinding_ = TRUE,
              wait_ = FALSE, values_ = FALSE)
app$setInputs(data_rows_all = c(1, 2), allowInputNoBinding_ = TRUE,
              wait_ = FALSE, values_ = FALSE)
app$snapshot()
app$setInputs(box = "Plots")
app$snapshot()
app$setInputs(box = "About")
app$snapshot()
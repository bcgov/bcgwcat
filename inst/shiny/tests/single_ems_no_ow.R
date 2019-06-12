app <- ShinyDriver$new("../")
app$snapshotInit("single_ems_no_ow")

app$setInputs(ems_ids = "E292373")
app$setInputs(get_data = "click", timeout_ = 50000)
app$setInputs(data_rows_current = c(1, 2, 3), allowInputNoBinding_ = TRUE,
              wait_ = FALSE, values_ = FALSE)
app$setInputs(data_rows_all = c(1, 2, 3), allowInputNoBinding_ = TRUE,
              wait_ = FALSE, values_ = FALSE)
app$snapshot()

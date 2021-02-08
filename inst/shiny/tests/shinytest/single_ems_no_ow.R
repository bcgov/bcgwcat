app <- ShinyDriver$new("../../", loadTimeout = 100000)
app$snapshotInit("single_ems_no_ow")

app$setInputs(ems_ids = "E292373",
              get_data = "click", timeout_ = 500000)
app$setInputs(box = "Results")
app$setInputs(data_rows_current = c(1, 2, 3), allowInputNoBinding_ = TRUE,
              wait_ = FALSE, values_ = FALSE)
app$setInputs(data_rows_all = c(1, 2, 3), allowInputNoBinding_ = TRUE,
              wait_ = FALSE, values_ = FALSE)
app$snapshot()
app$setInputs(box = "Plots")
app$snapshot()
app$setInputs(box = "About")
app$snapshot()
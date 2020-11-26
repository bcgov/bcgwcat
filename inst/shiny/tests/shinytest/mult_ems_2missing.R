app <- ShinyDriver$new("../../", loadTimeout = 100000)
app$snapshotInit("mult_ems_2missing")

app$setInputs(ems_ids = "\"1401030\", \"1401377\"",
              date_range = c("1992-01-01", "1993-01-01"),
              get_data = "click")
app$snapshot()

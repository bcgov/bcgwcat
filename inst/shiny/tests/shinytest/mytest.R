app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(ems_ids = "\"1401030\", \"1401377\", \"E292373\"")
app$setInputs(get_data = "click")

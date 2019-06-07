app <- ShinyDriver$new("../")
app$snapshotInit("status")

app$setInputs(check_status = "click")
app$snapshot()

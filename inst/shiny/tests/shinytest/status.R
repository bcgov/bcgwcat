app <- ShinyDriver$new("../../", loadTimeout = 100000)
app$snapshotInit("status")

app$setInputs(check_status = "click")
app$snapshot()

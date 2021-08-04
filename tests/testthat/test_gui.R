library(shinytest)

test_that("ac_gui() works", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  appdir <- system.file(package = "rems2aquachem", "shiny")
  expect_pass(testApp(appdir, compareImages = FALSE, testnames = "multi_ems_1missing"))

  # For interactive tests:
  # MAKE SURE TO BUILD PACKAGE FIRST!!!
  # testApp(appdir, compareImages = TRUE)
  # testApp(appdir, compareImages = TRUE, testnames = "multi_ems_1missing")
})

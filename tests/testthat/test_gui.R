context("ac_gui")

library(shinytest)

test_that("ac_gui() works", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  appdir <- system.file(package = "rems2aquachem", "shiny")
  expect_pass(testApp(appdir, compareImages = FALSE))
})
context("ac_gui")

library(shinytest)

test_that("ac_gui() works", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()

  expect_pass(testApp("apps/ac_gui", compareImages = FALSE))
})
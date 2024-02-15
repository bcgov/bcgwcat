library(shinytest2)

# Make sure you REBUILD the package before testing!
test_that("sample_app works", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  skip_on_ci()

  appdir <- system.file(package = "bcgwcat", "shiny")
  test_app(appdir)
})

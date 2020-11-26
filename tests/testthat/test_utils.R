save_plot <- function(code, width = 400, height = 400) {
  path <- tempfile(fileext = ".png")
  png(path, width = width, height = height)
  on.exit(dev.off())
  code

  path
}

test_that("meq()", {
  expect_message(p <- rems_to_aquachem("E298873", save = FALSE, interactive = FALSE,
                                       date_range = c("2014-01-01", "2014-12-31")))
  expect_true(all(c("Ca_meq", "Mg_meq", "Na_meq", "Cl_meq", "HCO3_meq") %in% names(p)))
  expect_equal(as.numeric(dplyr::select(p, dplyr::contains("meq")) %>% dplyr::slice(2)),
               c(0.483531, 0.1366014, 0.22446, 0.160797, 0.627737, 0.0599616))

  expect_silent(cb <- charge_balance(p))
  expect_equal(cb$charge_balance, -9.065613, tolerance = 0.000001)
})


test_that("plots", {
  expect_message(p <- rems_to_aquachem("E298873", save = FALSE, interactive = FALSE,
                                       date_range = c("2014-01-01", "2014-12-31")))

  expect_snapshot_file(save_plot(stiff_plot(p)), name = "stiff1.png")

})

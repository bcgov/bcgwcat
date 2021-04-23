
save_plot <- function(code, width = 400, height = 400) {
  path <- tempfile(fileext = ".png")
  png(path, width = width, height = height)
  print(code)
  dev.off()

  path
}

test_that("meq()", {
  expect_silent(p <- rems_to_aquachem("E298873", save = FALSE, interactive = FALSE,
                                       date_range = c("2014-01-01", "2014-12-31")))
  expect_true(all(c("Ca_meq", "Mg_meq", "Na_meq", "Cl_meq", "HCO3_meq", "K_meq", "SO4_meq") %in% names(p)))
  expect_equal(dplyr::select(p, dplyr::contains("meq")) %>% dplyr::slice(2),
               dplyr::tribble(
                 ~Ca_meq, ~Cl_meq, ~HCO3_meq, ~K_meq, ~Mg_meq, ~Na_meq, ~SO4_meq,
                 0.483531, 0.160797, 0.627737, 0.0353004, 0.1366014, 0.22446, 0.0599616) %>%
                 dplyr::mutate(dplyr::across(dplyr::everything(), as.character)))
  #expect_silent(cb <- charge_balance(p))
  #expect_equal(cb$charge_balance, -9.065613, tolerance = 0.000001)
})


test_that("plots", {
  expect_silent(p <- rems_to_aquachem("E298873", save = FALSE, interactive = FALSE,
                                      date_range = c("2014-01-01", "2014-12-31")))

  path <- save_plot(stiff_plot(p))
  expect_snapshot_file(path, name = "stiff1.png")

  path <- save_plot(piper_plot(p))
  expect_snapshot_file(path, name = "piper1.png")

})

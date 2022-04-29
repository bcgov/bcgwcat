
save_plot <- function(code, width = 400, height = 400) {
  path <- tempfile(fileext = ".png")
  png(path, width = width, height = height)
  print(code)
  dev.off()

  path
}

# meq and charge balance --------------------------------------------
test_that("meq() and charge_balance()", {
  expect_message(p <- rems_to_aquachem("E298873", save = FALSE, interactive = FALSE,
                                       date_range = c("2014-01-01", "2014-12-31")) %>%
                   units_remove(), "For consistency") %>%
    suppressMessages()

  expect_equal(
    dplyr::select(p, dplyr::contains("_meq")),
    dplyr::tibble(
      Al_diss_meq = 7.6721053e-05,
      Ca_meq = 0.48355706,
      Cl_meq = 0.16077624,
      CO3_meq = 0.016664195,
      Cu_diss_meq = 6.2317062e-06,
      F_meq = 0.00126326427,
      Fe_diss_meq = 3.5813412e-05,
      HCO3_meq = 0.62770524,
      K_meq = 0.035295652,
      Meas_Alk_meq = 0.62745474,
      Mg_meq = 0.136597408,
      Mn_diss_meq = 0.00029123718,
      Na_meq = 0.224447657,
      NH4_meq = 0.00035697202,
      NO2_meq = 0.000142788808,
      NO3_meq = 0.038196006,
      SO4_meq = 0.0599609,
      Zn_diss_meq = 3.12022025e-05))

  expect_message(cb <- charge_balance(p), "For consistency")
  expect_equal(cb$charge_balance, -0.4, tolerance = 0.000001)
  expect_equal(cb$anion_sum, 0.89, tolerance = 0.000001)
  expect_equal(cb$cation_sum, 0.88, tolerance = 0.000001)

  expect_message(p <- rems_to_aquachem("E314330", save = FALSE,
                                       interactive = FALSE,
                                       date_range = c("2019-01-01", "2019-12-31")) %>%
                   units_remove(), "For consistency") %>%
    suppressMessages()

  expect_message(cb <- charge_balance(p), "For consistency")
  expect_equal(dplyr::select(cb, "anion_sum", "cation_sum", "charge_balance"),
               dplyr::select(p, "anion_sum", "cation_sum", "charge_balance"))

  expect_equal(cb$charge_balance, c(23.2, 21.0))
  expect_equal(cb$anion_sum, c(1.08, 1.09))
  expect_equal(cb$cation_sum, c(1.73, 1.67))

  expect_message(p <- rems_to_aquachem("E307047", save = FALSE, interactive = FALSE,
                                       date_range = c("2018-01-01", "2022-02-01")) %>%
                   units_remove(), "For consistency") %>%
    suppressMessages()

  expect_message(cb <- charge_balance(p), "For consistency")
  expect_equal(dplyr::select(cb, "anion_sum", "cation_sum", "charge_balance"),
               dplyr::select(p, "anion_sum", "cation_sum", "charge_balance"))

  expect_equal(cb$charge_balance, c(-1.4, -3.8, -11.7))
  expect_equal(cb$anion_sum, c(6.25, 6.61, 5.97))
  expect_equal(cb$cation_sum, c(6.08, 6.13, 4.72))
})

test_that("is_valid", {
  expect_true(all(is_valid(c(-10:10))))
  expect_true(all(!is_valid(c(-10.1, 10.1, 20, 50, -20, -100))))
})



# water type ---------------------------------------------------------
test_that("water_type", {
  expect_message(p <- rems_to_aquachem(c("E298873", "E292373"),
                                      save = FALSE, interactive = FALSE,
                                      date_range = c("2015-01-01", "2016-12-31")) %>%
                  units_remove(), "For consistency") %>%
    suppressMessages()

  expect_equal(p$water_type,
               c("Ca-Mg-Na", "Ca-Na-HCO3-Cl", "Ca-Na-HCO3-Cl", "Ca-Na-HCO3"))
})

# plots -------------------------------------
test_that("plots", {
  set.seed(1111)
  expect_message(p <- rems_to_aquachem("E298873", save = FALSE, interactive = FALSE,
                                       date_range = c("2014-01-01", "2014-12-31")),
                 "For consistency")

  path <- save_plot(stiff_plot(p))
  expect_snapshot_file(path, name = "stiff1.png")

  path <- save_plot(piper_plot(p))
  expect_snapshot_file(path, name = "piper1.png")

})
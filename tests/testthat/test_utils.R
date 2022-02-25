
save_plot <- function(code, width = 400, height = 400) {
  path <- tempfile(fileext = ".png")
  png(path, width = width, height = height)
  print(code)
  dev.off()

  path
}

test_that("meq() and charge_balance()", {
  expect_silent(p <- rems_to_aquachem("E298873", save = FALSE, interactive = FALSE,
                                       date_range = c("2014-01-01", "2014-12-31")) %>%
                  units_remove())
  expect_true(all(c("Ca_meq", "Mg_meq", "Na_meq", "Cl_meq",
                    "HCO3_meq", "K_meq", "SO4_meq") %in% names(p)))
  expect_equal(dplyr::select(p, dplyr::contains("meq")),
               dplyr::tibble(
                 Al_diss_meq = 7.67211e-05,
                 HCO3_meq = 0.627737,
                 Br_meq = NA_real_,
                 Ca_meq = 0.483531,
                 CO3_meq = 0.016665,
                 Cl_meq = 0.160797,
                 F_meq = 0.00126336,
                 Fe_diss_meq = 3.581e-05,
                 Mg_meq = 0.1366014,
                 Mn_diss_meq = 0.0002912,
                 NO3_meq = 0.03819365,
                 NO2_meq = 0.00014278,
                 K_meq = 0.0353004,
                 Na_meq = 0.22446,
                 SO4_meq = 0.0599616))

  expect_silent(cb <- charge_balance(dplyr::select(p, -charge_balance, -charge_balance2,
                                                   -anion_sum2, -cation_sum2)))
  expect_equal(cb$charge_balance2, 2, tolerance = 0.000001)
  expect_equal(cb$anion_sum2, 0.89, tolerance = 0.000001)
  expect_equal(cb$cation_sum2, 0.92, tolerance = 0.000001)
})

test_that("water_type", {
  expect_silent(p <- rems_to_aquachem(c("E298873", "E292373"),
                                      save = FALSE, interactive = FALSE,
                                      date_range = c("2015-01-01", "2016-12-31")) %>%
                  units_remove())
  expect_true(all(c("Ca_p", "Mg_p", "Na_p", "K_p",
                    "Cl_p", "HCO3_p", "SO4_p") %in% names(p)))

  m <- dplyr::select(p, "Ca_meq", "Mg_meq", "Na_meq", "K_meq", "Cl_meq",
                 "HCO3_meq", "SO4_meq") %>%
    as.matrix()
  m / rowSums(m)

  expect_equal(dplyr::select(p, dplyr::ends_with("_p")),
               dplyr::tibble(
                 Cl_p = c(NA_real_, 0.188, 0.139, 0.098),
                 SO4_p = c(NA_real_, 0.036, 0.040, 0.042),
                 HCO3_p = c(NA_real_, 0.262, 0.298, 0.329),
                 Ca_p = c(NA_real_, 0.284, 0.293, 0.297),
                 Mg_p = c(NA_real_, 0.076, 0.077, 0.087),
                 Na_p = c(NA_real_, 0.135, 0.133, 0.124),
                 K_p = c(NA_real_, 0.019, 0.021, 0.022)))

  expect_equal(p$water_type,
               c(NA_character_, "Ca-Na-HCO3-Cl", "Ca-Na-HCO3-Cl", "Ca-Na-HCO3"))
})


test_that("plots", {
  set.seed(1111)
  expect_silent(p <- rems_to_aquachem("E298873", save = FALSE, interactive = FALSE,
                                      date_range = c("2014-01-01", "2014-12-31")))

  path <- save_plot(stiff_plot(p))
  expect_snapshot_file(path, name = "stiff1.png")

  path <- save_plot(piper_plot(p))
  expect_snapshot_file(path, name = "piper1.png")

})
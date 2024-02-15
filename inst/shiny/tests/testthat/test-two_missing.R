library(shinytest2)

test_that("{shinytest2} recording: two_missing", {
  app <- AppDriver$new(seed = 1111, timeout = 30000,
                       variant = platform_variant(), name = "two_missing",
                       height = 948, width = 1551)

  app$set_inputs(ems_ids = "\"1401030\", \"1401377\"",
                 date_range = c("1992-01-01", "1993-01-01"))
  app$click("get_data")
  app$wait_for_idle(500)
  app$expect_screenshot()

  app$set_inputs(box = "Preview/Export")
  tbl <- app$wait_for_idle(duration = 500)
  app$expect_values()

  app$set_inputs(box = "Water Quality Summary")
  tbl <- app$wait_for_value(output = "data_wq", ignore = list(NULL))
  app$expect_values()

  app$set_inputs(box = "Plots")
  plot <- app$wait_for_value(output = "stiff", ignore = list(NULL))
  plot <- app$wait_for_value(output = "piperplot", ignore = list(NULL))
  app$expect_screenshot()

  app$set_inputs(box = "Details")
  app$wait_for_idle(500)
  app$expect_screenshot()

  app$set_inputs(box = "About")
  app$wait_for_idle(500)
  app$expect_screenshot()
})

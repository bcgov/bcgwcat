library(shinytest2)

test_that("{shinytest2} recording: basic", {
  app <- AppDriver$new(seed = 1111, timeout = 30000,
                       variant = platform_variant(), name = "basic",
                       height = 948, width = 1551)
  app$set_inputs(ems_ids = "\"1401030\", \"1401377\", \"E292373\"")

  app$click("get_data")

  app$set_inputs(box = "Results")
  tbl <- app$wait_for_value(output = "data", ignore = list(NULL))
  app$expect_values()

  app$set_inputs(box = "Water Quality Summary")
  tbl <- app$wait_for_value(output = "data_wq", ignore = list(NULL))
  app$expect_values()

  app$set_inputs(box = "Plots")
  plot <- app$wait_for_value(output = "stiff", ignore = list(NULL))
  plot <- app$wait_for_value(output = "piperplot", ignore = list(NULL))
  app$expect_screenshot()

  app$set_inputs(box = "About")
  app$wait_for_idle(500)
  app$expect_screenshot()
})

ac_gui <- function() {
  appDir <- system.file("shiny", package = "rems2aquachem")
  if (appDir == "") {
    stop("Could not find shiny app directory. ",
         "Try re-installing `rems2aquachem`.", call. = FALSE)
  }

  shiny::runApp(appDir, launch.browser = TRUE)
}
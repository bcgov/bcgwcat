#' REMS to Aquachem GUI
#' Shiny app to launch an interactive interface for getting and formating data.
#'
#' @examples
#' \dontrun{ac_gui()}
#'
#' @export
ac_gui <- function() {

  if(packageVersion("rems") < package_version("0.6.0")) {
    stop("Please update rems to v0.6.0 with 'remotes::install_github(\"bcgov/rems\")'",
         call. = FALSE)
  }

  appDir <- system.file("shiny", package = "rems2aquachem")
  if (appDir == "") {
    stop("Could not find shiny app directory. ",
         "Try re-installing `rems2aquachem`.", call. = FALSE)
  }

  shiny::runApp(appDir, launch.browser = TRUE)
}
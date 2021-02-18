# Copyright 2021 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' REMS to Aquachem GUI
#' Shiny app to launch an interactive interface for getting and formating data.
#'
#' @examples
#' \dontrun{ac_gui()}
#'
#' @export
ac_gui <- function() {

  if(utils::packageVersion("rems") < package_version("0.6.0")) {
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
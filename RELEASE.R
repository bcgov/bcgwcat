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

# Update NEWS.md

# Check version


# Run tests - Compare snapshots - BUILD PACKAGE FIRST
devtools::test()
testthat::snapshot_review()
shinytest::snapshotCompare("inst/shiny/")

shinytest::testApp("./inst/shiny", interactive = TRUE) # Shiny tests only

# Check
devtools::check()

# Render README.Rmd
rmarkdown::render("README.Rmd")
unlink("README.html")

# Update website
pkgdown::build_site()

# Push to GitHub!

## Going up a version? Create signed release on github
usethis::use_github_release()

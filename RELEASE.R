# Update NEWS.md

# Check version

# Render README.Rmd
rmarkdown::render("README.Rmd")
unlink("README.html")
# Updated screenshots


# Update website
pkgdown::build_site()

# Push to GitHub!

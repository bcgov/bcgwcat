.onLoad <- function(libname = find.package("rems2aquachem"), pkgname = "rems2aquachem"){
  # CRAN Note avoidance
  if(getRversion() >= "2.15.1")
    utils::globalVariables(
      # Vars used in Non-Standard Evaluations, declare here to avoid CRAN warnings
      c(".") # piping requires '.' at times

    )
  invisible()
}
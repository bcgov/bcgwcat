#' Details used to calculate milli-equivalents per litre
#'
#' A dataset containing the atomic mass, valency state and corresponding MEQ
#' conversion factor for relevant parameters.
#'
#' @format A data frame 4 variables:
#' \describe{
#'   \item{param}{Parameter name (corresponds to AquaChem names)}
#'   \item{mass}{Atomic mass (https://en.wikipedia.org/wiki/List_of_elements_by_atomic_properties)}
#'   \item{valency_state}{Valency}
#'   \item{conversion}{Conversion constant (mass/valency_state)}
#' }
"meq_conversion"
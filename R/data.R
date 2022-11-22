
#' Air density measurements
#'
#' A data.table of air properties at room temperature, simulating multiple
#' measurements at approximately steady state,
#'
#' @usage data(air, package = "formatdown")
#'
#' @format A data frame with 5 rows and 7 columns:
#' \describe{
#'  \item{date}{Date, R class "Date", format \code{YYYY-MM-DD}.}
#'  \item{trial}{Character, label a--e.}
#'  \item{humidity}{Factor, low, medium, or high.}
#'  \item{temperature}{Numeric, units K.}
#'  \item{pressure}{Numeric, atmospheric pressure, units Pa.}
#'  \item{R}{Integer, gas constant, units
#'           J kg\eqn{^{-1}}{^{-1}}K\eqn{^{-1}}{^{-1}}.}
#'  \item{density}{Numeric, calculated air density, units
#'        kg/m\eqn{^{3}}{^3}.}
#' }
"air"



#' Water properties
#'
#' A data.table with properties of water at different temperatures.
#'
#' @usage data(water, package = "formatdown")
#'
#' @source Excerpt from the R hydraulics package,
#'         \url{https://CRAN.R-project.org/package=hydraulics}
#'
#' @format A data frame with 5 rows and 5 columns:
#' \describe{
#'  \item{temperature}{Numeric, temperature, units K.}
#'  \item{density}{Numeric, density, units kg/m\eqn{^{3}}{^3}.}
#'  \item{specific_weight}{Numeric, specific weight, units
#'        N/m\eqn{^{3}}{^3}.}
#'  \item{viscosity}{Numeric, dynamic viscosity, units Pa-s.}
#'  \item{bulk_modulus}{Numeric, bulk modulus, units Pa.}
#' }
"water"


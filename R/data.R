
#' Air density measurements
#'
#' A table of air properties at room temperature, simulating multiple
#' measurements at approximately steady state,
#'
#' @usage data(air, package = "formatdown")
#'
#' @format Classes data.table and data.frame:	5 observations of 7 variables:
#' \describe{
#'  \item{date}{Date, R class "Date", format \code{YYYY-MM-DD}.}
#'  \item{trial}{Character, label a through e.}
#'  \item{humidity}{Factor, low, medium, or high.}
#'  \item{temperature}{Numeric, [K] }
#'  \item{pressure}{Numeric, atmospheric pressure [Pa] }
#'  \item{R}{Integer, gas constant
#'           [J kg\eqn{^{-1}}{^{-1}}K\eqn{^{-1}}{^{-1}}] }
#'  \item{density}{Numeric, calculated air density
#'        [kg m\eqn{^{-3}}{^{-13}}] }
#' }
"air"

#' Water properties
#'
#' A table with properties of water at different temperatures.
#'
#' @usage data(water, package = "formatdown")
#'
#' @source Excerpt from the R hydraulics package,
#'         \url{https://CRAN.R-project.org/package=hydraulics}
#'
#' @format Classes data.table and data.frame:	5 observations of 5 variables:
#' \describe{
#'  \item{temperature}{Numeric, temperature [K] }
#'  \item{density}{Numeric, density  [kg m\eqn{^{-3}}{^{-3}}] }
#'  \item{specific_weight}{Numeric, specific weight
#'        [N m\eqn{^{-3}}{^{-3}}] }
#'  \item{viscosity}{Numeric, dynamic viscosity  [Pa-s] }
#'  \item{bulk_modulus}{Numeric, bulk modulus  [Pa] }
#' }
"water"

#' Properties of standard atmosphere
#'
#' A table of atmospheric properties as a function of altitude from
#' sea level to approximately 14 km.
#'
#' @usage data(atmosphere, package = "formatdown")
#'
#' @format Classes data.table and data.frame: 10 observations of 5 variables:
#' \describe{
#'  \item{altitude}{Numeric    [m] }
#'  \item{temperature}{Numeric [K] }
#'  \item{pressure}{Numeric    [Pa] }
#'  \item{density}{Numeric     [kg m\eqn{^{-3}}{^{-13}}] }
#'  \item{speed_sound}{Numeric [m/s] }
#' }
"atmosphere"

#' Properties of metals
#'
#' A table of basic properties of several metals
#'
#' @usage data(metals, package = "formatdown")
#'
#' @format Classes data.table and data.frame:	5 observations of  5 variables:
#' \describe{
#'  \item{material}{Character}
#'  \item{rho}{Numeric, density [kg m\eqn{^{-3}}{^{-3}}] }
#'  \item{alpha}{Numeric, coefficient of thermal expansion [m m\eqn{^{-1}}{^{-1}}K\eqn{^{-1}}{^{-1}}] }
#'  \item{k}{Numeric, thermal conductivity [W m\eqn{^{-1}}{^{-1}}K\eqn{^{-1}}{^{-1}}] }
#'  \item{E}{Numeric, modulus of elasticity [Pa] }
#' }
"metals"

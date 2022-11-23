
#' Air density measurements
#'
#' A table of air properties at room temperature, simulating multiple
#' measurements at approximately steady state,
#'
#' @usage data(air_meas, package = "formatdown")
#'
#' @format Classes data.table and data.frame:	5 observations of 7 variables:
#' \describe{
#'  \item{date}{Date, R class "Date", format \code{YYYY-MM-DD}.}
#'  \item{trial}{Character, label a through e.}
#'  \item{humid}{Factor, low, med, or high.}
#'  \item{temp}{Numeric, [K] }
#'  \item{pres}{Numeric, atmospheric pressure [Pa] }
#'  \item{sp_gas}{Numeric, specific gas constant, ideal gas constant in mass form
#'           [J kg\eqn{^{-1}}{^{-1}}K\eqn{^{-1}}{^{-1}}] }
#'
#'  \item{dens}{Numeric, calculated air density
#'        [kg m\eqn{^{-3}}{^{-13}}] }
#' }
"air_meas"

#' Properties of standard atmosphere
#'
#' A table of atmospheric properties as a function of altitude from
#' sea level to approximately 14 km.
#'
#' @usage data(atmosphere, package = "formatdown")
#'
#' @format Classes data.table and data.frame: 10 observations of 5 variables:
#' \describe{
#'  \item{alt}{Numeric, altitude [m]   }
#'  \item{temp}{Numeric, air temperature [K]   }
#'  \item{pres}{Numeric, atmospheric pressure [Pa]  }
#'  \item{dens}{Numeric, air density [kg m\eqn{^{-3}}{^{-13}}] }
#'  \item{spd_snd}{Numeric, speed of sound [m/s] }
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
#'  \item{metal}{Character, name of material}
#'  \item{dens}{Numeric, density [kg m\eqn{^{-3}}{^{-3}}] }
#'  \item{thrm_exp}{Numeric, coefficient of thermal expansion [m m\eqn{^{-1}}{^{-1}}K\eqn{^{-1}}{^{-1}}] }
#'  \item{thrm_cond}{Numeric, thermal conductivity [W m\eqn{^{-1}}{^{-1}}K\eqn{^{-1}}{^{-1}}] }
#'  \item{elast_mod}{Numeric, modulus of elasticity [Pa] }
#' }
"metals"

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
#'  \item{temp}{Numeric, temperature [K] }
#'  \item{dens}{Numeric, density  [kg m\eqn{^{-3}}{^{-3}}] }
#'  \item{sp_wt}{Numeric, specific weight [N m\eqn{^{-3}}{^{-3}}] }
#'  \item{visc}{Numeric, dynamic viscosity  [Pa-s] }
#'  \item{bulk_mod}{Numeric, bulk modulus  [Pa] }
#' }
"water"





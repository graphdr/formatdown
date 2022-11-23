
#' Air density measurements
#'
#' Table of air properties at room temperature and pressure, simulating
#' multiple measurements at approximately steady state,
#'
#' @usage data(air_meas, package = "formatdown")
#'
#' @format Classes data.table and data.frame:	5 observations of 7 variables:
#' \describe{
#'  \item{date}{"Date" class format "YYYY-MM-DD".}
#'  \item{trial}{Character, label "a" through "e".}
#'  \item{humid}{Factor, humidity, "low", "med", or "high."}
#'  \item{temp}{Numeric, measured temperature [K].}
#'  \item{pres}{Numeric, measured atmospheric pressure [Pa].}
#'  \item{sp_gas}{Numeric, specific gas constant in mass form \eqn{R_{sp}},
#'        ideal gas reference value,
#'        [J kg\eqn{^{-1}}{^{-1}}K\eqn{^{-1}}{^{-1}}].}
#'  \item{dens}{Numeric, calculated air density
#'        \eqn{\rho} = \eqn{p}\eqn{R_{sp}^{-1}}{^{-1}}\eqn{T^{-1}}{^{-1}}
#'        [kg m\eqn{^{-3}}{^{-3}}].}
#' }
"air_meas"

#' Properties of standard atmosphere
#'
#' Table of atmospheric properties as a function of altitude, sea level to
#' 80 km.
#'
#' @usage data(atmos, package = "formatdown")
#'
#' @format Classes data.table and data.frame: 9 observations of 5 variables:
#' \describe{
#'  \item{alt}{Numeric, altitude [m]   }
#'  \item{temp}{Numeric, air temperature [K]   }
#'  \item{pres}{Numeric, atmospheric pressure [Pa]  }
#'  \item{dens}{Numeric, air density [kg m\eqn{^{-3}}{^{-13}}] }
#'  \item{sound}{Numeric, speed of sound [m/s] }
#' }
#'
#' @source \emph{Marks' Standard Handbook for Mechanical Engineers 9/e} (1987)
#'         E.A. Avallone and T. Baumeister (ed.),
#'         "Table 4.2.2 International Standard Atmosphere",
#'         pp. 4-38,  McGraw-Hill, NY.
#'
"atmos"

#' Properties of metals
#'
#' Table of mechanical and thermal properties of selected metals.
#'
#' @usage data(metals, package = "formatdown")
#'
#' @format Classes data.table and data.frame:	6 observations of  5 variables:
#' \describe{
#'  \item{metal}{Character, name of material}
#'  \item{dens}{Numeric, density [kg m\eqn{^{-3}}{^{-3}}] }
#'  \item{thrm_exp}{Numeric, coefficient of thermal expansion [m m\eqn{^{-1}}{^{-1}}K\eqn{^{-1}}{^{-1}}] }
#'  \item{thrm_cond}{Numeric, thermal conductivity [W m\eqn{^{-1}}{^{-1}}K\eqn{^{-1}}{^{-1}}] }
#'  \item{elast_mod}{Numeric, modulus of elasticity [Pa] }
#' }
#'
#' @source \emph{Marks' Standard Handbook for Mechanical Engineers 9/e} (1987)
#'         E.A. Avallone and T. Baumeister (ed.),
#'         "Basic Properties of Several Metals",
#'         pp. 6-11,  McGraw-Hill, NY.
#'
"metals"

#' Properties of water
#'
#' Table of water properties at atmospheric pressure as a function of
#' temperature.
#'
#' @usage data(water, package = "formatdown")
#'
#' @format Classes data.table and data.frame:	11 observations of 5 variables:
#' \describe{
#'  \item{temp}{Numeric, temperature [K] }
#'  \item{dens}{Numeric, density  [kg m\eqn{^{-3}}{^{-3}}] }
#'  \item{sp_wt}{Numeric, specific weight [N m\eqn{^{-3}}{^{-3}}] }
#'  \item{visc}{Numeric, dynamic viscosity  [Pa-s] }
#'  \item{bulk_mod}{Numeric, bulk modulus  [Pa] }
#' }
#'
#' @source E. Maurer E and I. Embry (2022) \emph{hydraulics: Basic Pipe and
#' Open Channel Hydraulics}, R package ver. 0.6.0,
#' \url{https://edm44.github.io/hydraulics/}.
#'
"water"





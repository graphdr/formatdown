#' Air as an ideal gas
#'
#' Air density at room temperature. A data frame to illustrate features of
#' the \code{format_power()}.
#'
#' @usage data(density, package = "formatdown")
#'
#' @format A data frame with 5 rows and 7 columns:
#' \describe{
#'  \item{date}{A date variable.}
#'  \item{trial}{A character variable.}
#'  \item{humidity}{A factor variable.}
#'  \item{T_K}{Numeric air temperature in Kelvin.}
#'  \item{p_Pa}{Numeric air pressure in Pascals.}
#'  \item{R}{Numeric gas constant in J/(kg K)}
#'  \item{density}{Numeric air density in kg/m^3}
#' }
"density"


#' Water properties
#'
#' Properties of water at different temperatures. A data frame to illustrate
#' features of the \code{format_power()}.
#'
#' @usage data(water, package = "formatdown")
#'
#' @format A data frame with 5 rows and 5 columns:
#' \describe{
#'  \item{temperature}{Numeric. K.}
#'  \item{density}{Numeric. kg/m^3.}
#'  \item{specific_weight}{Numeric. }
#'  \item{viscosity}{Numeric. Pa-s.}
#'  \item{bulk_modulus}{Numeric. Pa.}
#' }
"water"

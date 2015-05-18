#' @title A Google Analytics and Doubleclick Campaign Manager API client for R
#'
#' @description
#' A package to do advanced tasks with Google Analytics and Doubleclick Campaign Manager, especially data integration and analysis
#'
#' @section Accessible Google Products:
#'
#'
#' To report a bug please type: \code{utils::bug.report(package = "analytics")}.
#'
#' @section Useage:
#'
#' Once you have the package loaded, there are 3 steps you need to use to get data from Google Analytics:
#'
#' \enumerate{
#'   \item Authorize this package to access your Google Analytics data with the \code{\link{oauth}} function;
#' }
#'
#' For details about this steps please type into R: \code{browseVignettes(package = "analytics")}
#'
#' @section Bug reports:
#'
#' To report a bug please type into R: \code{utils::bug.report(package = "analytics")}
#'
#' @author
#' BadriNarayanan Srinivasan \email{badri.it@@gmail.com}
#'
#' @name analytics
#' @docType package
#' @keywords package
#' @aliases analytics doubleclick
#'
#' @examples
#' \dontrun{
#' # load package
#' library(analytics)
#' # get access token
#' oauth()
#' }
#'
NULL
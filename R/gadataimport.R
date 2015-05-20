#' @title List Google Analytics custom data source configuration details
#'
#' @param accountId integer or character. Account ID for the upload to retrieve.
#' @param webPropertyId character. Web property ID for the upload to retrieve, for example UA-123456-1.
#' @param token \code{\link[httr]{Token2.0}} class object with a valid authorization data.
#'
#' @return A dataframe that has a list of custom data sources, emplty list if none found.
#' 
#' \enumerate{
#'  \item More information in references.
#' }
#'
#' @seealso \code{\link{oauth}}
#'
#' @references
#' 
#' \href{https://developers.google.com/analytics/devguides/config/mgmt/v3/mgmtReference/management/uploads#resource}{Uploads Resources}
#'
#' \href{https://developers.google.com/analytics/devguides/config/mgmt/v3/mgmtReference/management/uploads/get}{Uploads Get Method}
#'
#' @family Google Analytics Management API
#'
#' @include authenticate.R
#'
#' @importFrom httr GET config accept_json content
#' 
#' @export
#'
listGaCustomDatasources <- function(accountId = NULL, webPropertyId = NULL, token) {
  url <- paste("https://www.googleapis.com/analytics/v3/management/accounts/",
               accountId,"/webproperties/",webPropertyId,
               "/customDataSources?fields=items(accountId%2Ccreated%2Cdescription%2Cid%2CimportBehavior%2Ckind%2Cname%2Ctype%2Cupdated%2CwebPropertyId)&key=",
               token$credentials$access_token, sep = "")
  response <- GET(url, accept_json(), config(token = token))
  responseToJson <- fromJSON(content(x = response, as = "text"))
  return(responseToJson$items)
}
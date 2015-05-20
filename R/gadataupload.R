#' @title Google Analytics data upload
#'
#' @param accountId integer or character. Account ID for the upload to retrieve.
#' @param webPropertyId character. Web property ID for the upload to retrieve, for example UA-123456-1.
#' @param customDataSourceId character. Custom data source ID to which the data being uploaded belongs.
#' @param filename character. Custom data filename along with path.
#' @param token \code{\link[httr]{Token2.0}} class object with a valid authorization data.
#'
#' @return uploaded or failed
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
#' \href{https://developers.google.com/analytics/devguides/config/mgmt/v3/mgmtReference/management/uploads/list}{Uploads list Method}
#'
#' @family Google Analytics Management API
#'
#' @include authenticate.R
#'
#' @importFrom httr POST config content
#' 
#' @export
#'
gaUploadData <- function(accountId = NULL, webPropertyId = NULL, customDataSourceId = NULL, filename = NULL, token) {
  url <- paste("https://www.googleapis.com/upload/analytics/v3/management/accounts/",
               accountId,"/webproperties/",webPropertyId,
               "/customDataSources/", customDataSourceId,
               '/uploads?', 'access_token=', token$credentials$access_token,
               '&type=cost','&appendNumber=1', sep = "")
  response <- system(paste('curl -X POST "',url,'" -F "upload=@',
                            filename,';type=application/octet-stream"', sep=""), intern = TRUE)
  if(grepl("accountId",response)){
    return("uploaded")
  } else {
    return("failed")
  }
  return(response)
}
# Function to check report file status
#' @importFrom httr GET config accept_json content
#' @importFrom httr POST config accept_json content
#' @importFrom jsonlite fromJSON
dcmGetReportFile <- function(profileId, reportId, token){
  url <- paste("https://www.googleapis.com/dfareporting/v2.1/userprofiles/",
               profileId,"/reports/",
               reportId,"/run?key=",token$credentials$access_token, sep = "")
  response <- POST(url, accept_json(), config(token = token))
  responseToJson <- fromJSON(content(x = response, as = "text"))
  return(responseToJson$id)
}

dcmGetReportStatus <- function(reportId, fileId, token){
  url <- paste("https://www.googleapis.com/dfareporting/v2.1/reports/",
               reportId,"/files/",
               fileId,"?key=",token$credentials$access_token, sep = "")
  response <- GET(url, accept_json(), config(token = token))
  responseToJson <- fromJSON(content(response, as = "text"))
  return(responseToJson)
}

#' @title Get report configuration details from Doubleclick Campaign Manager
#'
#' @param profileId integer or character. Profile ID where the report resides.
#' @param reportId integer or character. Report ID within report builder section of DCM.
#' @param token \code{\link[httr]{Token2.0}} class object with a valid authorization data.
#'
#' @return Report configuration details.
#' 
#' \enumerate{
#'  \item More information in references.
#' }
#'
#' @seealso \code{\link{oauth}}
#'
#' @references
#' 
#' \href{https://developers.google.com/doubleclick-advertisers/reporting/v2.1/reports#resource}{DCM Report Resources}
#'
#' \href{https://developers.google.com/doubleclick-advertisers/reporting/v2.1/reports/get}{DCM Report File Get Method}
#'
#' @family DCM/DFA Reporting and Trafficking API
#'
#' @include authenticate.R
#'
#' @importFrom httr GET config accept_json content
#' @import RCurl
#' 
#' @export
#'
runDcmReport <- function(profileId = NULL, reportId = NULL, token) {
  
  # Run the report
  fileId <- dcmGetReportFile(profileId, reportId, token)
  
  # Check report file status
  status = F
  
  while(status == F){
    getReportFile <- dcmGetReportStatus(reportId, fileId, token)
    getStatus <- getReportFile$status
    if(getStatus == "REPORT_AVAILABLE"){
      status <- T
      apiUrl <- getReportFile$urls$apiUrl
    }
  }
  
  if(status == T){
    retrieveUrl <- GET(url = apiUrl, accept_json(), config = config(token = token))
    url <- retrieveUrl$url # has expiry
    download.file(url = url, destfile = "localFile.csv", method = "curl")
  }
  
  return("dowloaded")
}
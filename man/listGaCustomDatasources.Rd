% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/gadataimport.R
\name{listGaCustomDatasources}
\alias{listGaCustomDatasources}
\title{List Google Analytics custom data source configuration details}
\usage{
listGaCustomDatasources(accountId = NULL, webPropertyId = NULL, token)
}
\arguments{
\item{accountId}{integer or character. Account ID for the upload to retrieve.}

\item{webPropertyId}{character. Web property ID for the upload to retrieve, for example UA-123456-1.}

\item{token}{\code{\link[httr]{Token2.0}} class object with a valid authorization data.}
}
\value{
A dataframe that has a list of custom data sources, emplty list if none found.

\enumerate{
 \item More information in references.
}
}
\description{
List Google Analytics custom data source configuration details
}
\references{
\href{https://developers.google.com/analytics/devguides/config/mgmt/v3/mgmtReference/management/uploads#resource}{Uploads Resources}

\href{https://developers.google.com/analytics/devguides/config/mgmt/v3/mgmtReference/management/uploads/get}{Uploads Get Method}
}
\seealso{
\code{\link{oauth}}

Other Google Analytics Management API: \code{\link{gaUploadData}}
}


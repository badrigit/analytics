# Set global variables to be shared with other functions
if (getRversion() >= "2.15.1") utils::globalVariables(c("GADCMToken"))

# Environment for OAuth token
GADCMEnv <- new.env(parent = emptyenv())

# Check token exists
token_exists <- function(name) {
  exists(name, envir = GADCMEnv)
}

# Set token to environment
set_token <- function(name, value) {
  assign(name, value, envir = GADCMEnv)
  return(value)
}

# Get token from environment
get_token <- function(name) {
  get(name, envir = GADCMEnv)
}

# Check if environment variables exists
env_exists <- function(...) {
  dots <- list(...)
  res <- lapply(dots, Sys.getenv)
  vapply(res, nzchar, logical(1))
}

# Scopes to connect to Google Analytics & Doubleclick Campaign Manager
scopes <- c("https://www.googleapis.com/auth/analytics", 
            "https://www.googleapis.com/auth/analytics.edit", 
            "https://www.googleapis.com/auth/dfareporting")

#' @title Authorise analytics package to connect with Google Analytics and Doubleclick Campaign Manager (DFA) using OAuth 2.0
#'
#' @description \code{oauth} function uses \code{\link[httr]{oauth2.0_token}} to obtain the OAuth tokens. Expired tokens will be refreshed automamaticly. If clientId and clientSecret are missing the package will use predefined values.
#'
#' @param clientId character. OAuth client ID. if clientId is missing, we'll look in the environment variable \code{gadcmClientId}.
#' @param clientSecret character. OAuth client secret. if clientSecret is missing, we'll look in the environment variable \code{gadcmClientSecret}.
#' @param cache logical or character. \code{TRUE} means to cache using the default cache file \code{.oauth-httr}, \code{FALSE} means not to cache. A string means to use the specified path as the cache file.
#'
#' @details
#'
#' After calling this function first time, a web browser will be opened. First, log in with a Google Account, confirm the authorisation to access the Google Analytics and DoubleClick Campaign Manager data. Note that the package has multiple scopes including edit level access.
#'
#' When the \code{oauth} function is used the \code{GADCMToken} variable is created in the separate \code{GADCMToken} environment which is not visible for user. So, there is no need to pass the token argument to any function which requires authorisation every time. Also there is a possibility to store token in separate variable and to pass it to the functions. It can be useful when you are working with several accounts at the same time.
#'
#' @section Use custom clientId and clientSecret:
#'
#' For some reasons you may need to use a custom client ID and client secret. In order to obtain these, you will have to register an application with the Google API. To find your project's client ID and client secret, do the following:
#'
#' \enumerate{
#'   \item Go to the \href{https://console.developers.google.com/}{Google Developers Console}.
#'   \item Select a project (create if needed).
#'   \item Select \emph{APIs & auth} in the sidebar on the left. Then in the list of APIs make sure that the status is \emph{ON} for the Analytics API.
#'   \item Select \emph{Credentials} in the sidebar on the left.
#'   \item To set up a service account select \emph{Create New Client ID}. Select \emph{Installed Application} and \emph{Others} options and then select \emph{Create Client ID}.
#' }
#' 
#' Note: The above steps can differ slightly due to constant upgrades to Google Developer Console
#'
#' You can return to the \href{https://console.developers.google.com/}{Google Developers Console} at any time to view the client ID and client secret on the \emph{Client ID for native application} section on \emph{Credentials} page.
#'
#' @return A \code{\link[httr]{Token2.0}} object containing all the data required for OAuth access.
#'
#' @references \href{https://console.developers.google.com/}{Google Developers Console}
#'
#' \href{http://en.wikipedia.org/wiki/Environment_variable}{Environment variable}
#'
#' @seealso
#' Other OAuth: \code{\link[httr]{oauth_app}} \code{\link[httr]{oauth2.0_token}} \code{\link[httr]{Token-class}}
#'
#' To revoke all tokens: \code{\link[httr]{revoke_all}}
#'
#' Setup environment variables: \code{\link{Startup}}
#'
#' @examples
#' \dontrun{
#' oauth(clientId = "myID", clientSecret = "mySecret")
#' # if set GADCMClientId and GADCMClientSecret environment variables
#' oauth()
#' # assign token to variable
#' gaToken <- oauth(clientId = "myID", clientSecret = "mySecret")
#' }
#'
#' @importFrom httr oauth_app oauth_endpoints oauth2.0_token
#' @import httpuv
#'
#' @export
#'

# OAuth to Google Analytics & Doubleclick Campaign Manager
oauth <- function(clientId, clientSecret, cache = getOption("gadcmCache")){
  if (missing(clientId) || missing(clientSecret)) {
    if (all(env_exists("gadcmClientId", "gadcmClientSecret"))) {
      message("client id and client secret loaded from environment variables")
      clientId <- Sys.getenv("gadcmClientId")
      clientSecret <- Sys.getenv("gadcmClientSecret")
    } else {
      clientId <- "14259072271-5qrjd7qu7k45r07l6ld5eb6qhvc3hsoq.apps.googleusercontent.com"
      clientSecret <- "75D1cLd-VMtbK4kkUO1ptumc"
    }
  }
  
  gadcmApp <- oauth_app(appname = "GADCM", key = clientId, secret = clientSecret)
  token <- oauth2.0_token(endpoint = oauth_endpoints("google"), app = gadcmApp, cache = cache,
                          scope = scopes)
  set_token(getOption("gadcmToken"), token)
  invisible(token)
}
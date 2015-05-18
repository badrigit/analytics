# Check environment variables exists
env_exists <- function(...) {
  dots <- list(...)
  res <- lapply(dots, Sys.getenv)
  vapply(res, nzchar, logical(1))
}

# Scopes to connect to Google Analytics & Doubleclick Campaign Manager
scopes <- c("https://www.googleapis.com/auth/analytics", 
            "https://www.googleapis.com/auth/analytics.edit", 
            "https://www.googleapis.com/auth/dfareporting")

# OAuth to Google Analytics & Doubleclick Campaign Manager
oauth <- function(clientId, clientSecret, cache = getOption("dacmCache")){
  if (missing(clientId) || missing(clientSecret)) {
    if (all(env_exists("gadcmClientId", "gadcmClientSecret"))) {
      message("client id and client secret loaded from environment variables")
      client.id <- Sys.getenv("gadcmClientId")
      client.secret <- Sys.getenv("gadcmClientSecret")
    } else {
      client.id <- "14259072271-5qrjd7qu7k45r07l6ld5eb6qhvc3hsoq.apps.googleusercontent.com"
      client.secret <- "75D1cLd-VMtbK4kkUO1ptumc"
    }
  }
  
  gadcmApp <- oauth_app(appname = "GADCM", key = clientId, secret = clientSecret)
  token <- oauth2.0_token(endpoint = oauth_endpoints("google"), app = gadcmApp, cache = cache,
                          scope = scopes)
  set_token(getOption("dacmToken"), token)
  invisible(token)
}
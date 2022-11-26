#' Get shiny server object
#'
get_shiny_server <- function() {
  return(server)
}

#' Wrapper for shinyApp function to start the dashboard
#'
#' @export start_app
#'
#' @examples
#' \donotrun{
#' start_app()
#' }
#'
#' @importFrom shiny shinyApp
#'
start_app <- function() {
  server <- get_shiny_server()
  shiny::shinyApp(
    ui = ui,
    server = server,
    options = list(
      launch.browser = TRUE
    )
  )
}

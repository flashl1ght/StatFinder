
# Shiny server function
server <- function(input, output, session) {
  
  # Stop app on windows close
  session$onSessionEnded(function() {
    shiny::stopApp()
  })
}
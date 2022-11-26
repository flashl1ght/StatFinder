#' Server-side calculations for sum_stats tab
#'
#' @param input shiny input object
#' @param output shiny output object
#' @param session shiny session object
#'
#' @importFrom shiny req
#' @importFrom shiny observeEvent
#' @importFrom shiny reactiveValues
#' @importFrom shiny renderTable
#'
sum_stats_server <- function(input, output, session) {
  session$userData$dice_sum_stats <- shiny::reactiveValues()

  # Simulate rolls
  shiny::observeEvent(
    {
      lapply(
        paste("sum_stats_no", global$dice_names, sep = "_"),
        function(x) input[[x]]
      )
      input$sim_number
    },
    {
      shiny::req(input$sim_number > 0)

      session$userData$dice_sum_stats$dice_rolled <- lapply(
        paste("sum_stats_no", global$dice_names, sep = "_"),
        function(x) input[[x]]
      )

      # Stop calculation if any numericInput is NA
      shiny::req(!any(is.na(session$userData$dice_sum_stats$dice_rolled)))

      session$userData$dice_sum_stats$roll_results <- simulate_dice_roll(
        session$userData$dice_sum_stats$dice_rolled,
        input$sim_number
      )
    }
  )

  # render dice stats table
  output$sum_stats_table <- shiny::renderTable(
    {
      shiny::req(
        session$userData$dice_sum_stats$roll_results,
        session$userData$dice_sum_stats$dice_rolled,
        !any(is.na(session$userData$dice_sum_stats$dice_rolled))
      )

      create_stats_table(
        unlist(session$userData$dice_sum_stats$dice_rolled),
        session$userData$dice_sum_stats$roll_results
      )
    },
    digits = 1,
    rownames = TRUE,
    width = "100%"
  )
}

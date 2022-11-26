#' Creates dice number inputs
#'
#' @param input_id prefix for inputIds
#' @param dice_names list of names for numericInput objects
#' @param default_dice_number initial value for numericInput objects
#'
#' @returns list of shiny numericInput objects
#'
#' @importFrom shiny numericInput
#'
create_dice_number_input <- function(input_id,
                                     dice_names = global$dice_names,
                                     default_dice_number = 0) {
  input_list <- lapply(dice_names, function(die_name) {
    shiny::numericInput(
      inputId = paste(input_id, die_name, sep = "_"),
      label = die_name,
      value = default_dice_number,
      min = 0,
      step = 1
    )
  })

  return(input_list)
}


#' Creates ui content for sum_stats_tab
#'
#' @returns list of ui elements for sum_stats_tab
#'
#' @importFrom shiny fluidRow
#' @importFrom shiny column
#' @importFrom shiny h1
#' @importFrom shiny span
#' @importFrom shiny numericInput
#' @importFrom shinydashboard box
#' @importFrom shinycssloaders withSpinner
#'
sum_stats_ui <- function() {
  tab_content <- list(
    shiny::fluidRow(
      shiny::column(
        width = 12,
        shiny::h1(global$sum_stats_header),
        shiny::span(global$sum_stats_description)
      )
    ),
    shiny::fluidRow(
      shinydashboard::box(
        title = "Number of simulations",
        width = 4,
        collapsible = TRUE,
        shiny::numericInput(
          "sim_number",
          label = "Sims",
          value = global$sum_stats_default_sim_number,
          min = 100,
          step = 1
        )
      )
    ),
    shiny::fluidRow(
      shinydashboard::box(
        title = "Dice selection",
        width = 4,
        create_dice_number_input(input_id = "sum_stats_no")
      ),
      shinydashboard::box(
        title = "Dice statistics",
        width = 3,
        shiny::tableOutput("sum_stats_table")
      )
    )
  )

  return(tab_content)
}

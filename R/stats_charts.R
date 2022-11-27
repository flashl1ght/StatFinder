#' Creates a histogram for given dice roll results
#'
#' @param results numeric vector containing roll results
#'
#' @returns plotly histogram chart
#'
#' @importFrom plotly plot_ly
#' @importFrom plotly layout
dice_histogram <- function(results) {
  dice_fig <- plotly::plot_ly(
    x = results,
    type = "histogram",
    histnorm = "probability"
  )

  return(dice_fig)
}

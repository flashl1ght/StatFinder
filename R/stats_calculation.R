#' Simulates sum of a number of iid (Independent and identically distributed)
#' discrete random variables
#'
#' @param no_variables number of variables to simulate
#' @param max maximal variable value
#' @param no_sims number of simulations
#' @param min minimal variable value, default set to 1
#'
#' @returns simulate sum vector
#'
#' @importFrom purrr rdunif
#'
simulate_iid_discrete_sum <- function(no_variables, max, no_sims, min = 1) {
  if (is.na(as.numeric(no_sims))) {
    variables_sum <- 0
  } else if (no_variables > 0 && max >= min && no_sims > 0) {
    iid_variables_list <- lapply(
      rep_len(as.integer(no_sims), no_variables),
      purrr::rdunif,
      b = as.integer(max),
      a = as.integer(min)
    )

    variables_sum <- Reduce(`+`, iid_variables_list)
  } else if (no_variables <= 0 && no_sims > 0) {
    variables_sum <- rep_len(0, no_sims)
  } else {
    variables_sum <- 0
  }

  return(variables_sum)
}

#' Simulates number of rolls of particular die type
#'
#' @param no_dice number of dice of selected type
#' @param die_type string indicating die type
#' @param no_sims number of simulations
#'
#' @returns vector of simulated roll sums
#'
simulate_die_type <- function(no_dice, die_type, no_sims) {
  check_type <- match(die_type, global$dice_names)

  if (!is.na(check_type)) {
    sim_roll <- simulate_iid_discrete_sum(
      no_dice,
      global$dice_no_sides[check_type],
      no_sims
    )
  } else {
    sim_roll <- 0
  }

  return(sim_roll)
}


#' Simulates dice rolls
#'
#' @param no_dices list or vector indicating number of each die type to simulate
#' @param no_sims number of simulations
#' @param dice_types names of dice types
#'
#' @returns vectors of rolls sums
#'
simulate_dice_roll <- function(no_dice,
                               no_sims,
                               dice_types = global$dice_names) {
  num_types <- length(no_dice)

  if (num_types > 0) {
    rolls_per_type <- lapply(seq_len(num_types), function(dice_index) {
      simulate_die_type(
        no_dice[[dice_index]],
        dice_types[[dice_index]],
        no_sims
      )
    })

    roll_sums <- Reduce(`+`, rolls_per_type)
  } else {
    roll_sums <- 0
  }

  return(roll_sums)
}

#' Creates dataframe with basic statistics for selected dice
#'
#' @returns dataframe with basic statistics
#'
#' @importFrom shiny isTruthy
#'
create_stats_table <- function(no_dice, rolls) {
  # convert to vector for calculations
  no_dice <- unlist(no_dice)
  # check input
  if (length(no_dice) != length(global$dice_no_sides) &&
    shiny::isTruthy(rolls)) {
    stats_table <- NULL
  } else {
    # expected values
    expected_mean <- sum(no_dice * global$dice_avg_value)
    expected_stddev <- sqrt(sum(no_dice * global$dice_variance_values))
    expected_min <- sum(no_dice)
    expected_max <- sum(no_dice * unlist(global$dice_no_sides))

    # simulated values
    simulated_mean <- mean(rolls)
    simulated_stddev <- sd(rolls)
    simulated_min <- min(rolls)
    simulated_max <- max(rolls)

    # col names
    stat_names <- c("Mean", "Standard deviation", "Min", "Max")

    # create dataframe
    stats_table <- data.frame(
      "Expected" = c(
        expected_mean,
        expected_stddev,
        expected_min,
        expected_max
      ),
      "Simulated" = c(
        simulated_mean,
        simulated_stddev,
        simulated_min,
        simulated_max
      ),
      row.names = stat_names
    )
  }

  return(stats_table)
}

test_that("create_stats_table returns df for single die", {
  # set params
  no_dice <- list(0, 0, 0, 0, 1, 0)
  no_sims <- 50
  dice_types <- global$dice_names
  die_sides <- 12
  die_index <- match(1, no_dice)
  die <- 1
  stat_names <- c("Mean", "Standard deviation", "Min", "Max")

  # set seed and simulate rolls
  set.seed(1)
  simulated_rolls <- simulate_dice_roll(no_dice, no_sims, dice_types)

  # create stats table
  stats_table <- create_stats_table(no_dice, simulated_rolls)

  # manual table calculation
  manual_table <- data.frame(
    "Expected" = c(
      global$dice_avg_value[die_index],
      sqrt(global$dice_stddev_values[die_index]),
      die,
      die_sides
    ),
    "Simulated" = c(
      mean(simulated_rolls),
      sd(simulated_rolls),
      min(simulated_rolls),
      max(simulated_rolls)
    ),
    row.names = stat_names
  )
  expect_equal(stats_table, manual_table)
})

test_that("create_stats_table returns df for multiple dice", {
  # set params
  no_dice <- list(0, 1, 0, 0, 1, 0)
  no_sims <- 50
  dice_types <- global$dice_names
  die1_sides <- 12
  die2_sides <- 6
  die1_index <- 2
  die2_index <- 5
  dice <- 2
  stat_names <- c("Mean", "Standard deviation", "Min", "Max")

  # set seed and simulate rolls
  set.seed(1)
  simulated_rolls <- simulate_dice_roll(no_dice, no_sims, dice_types)

  # create stats table
  stats_table <- create_stats_table(no_dice, simulated_rolls)

  # manual table calculation
  manual_table <- data.frame(
    "Expected" = c(
      global$dice_avg_value[die1_index] + global$dice_avg_value[die2_index],
      sqrt(
        global$dice_stddev_values[die1_index] +
          global$dice_stddev_values[die2_index]
      ),
      dice,
      die1_sides + die2_sides
    ),
    "Simulated" = c(
      mean(simulated_rolls),
      sd(simulated_rolls),
      min(simulated_rolls),
      max(simulated_rolls)
    ),
    row.names = stat_names
  )
  expect_equal(stats_table, manual_table)
})

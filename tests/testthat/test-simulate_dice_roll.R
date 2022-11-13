test_that("simulate_dice_roll simulates a die roll", {
  
  # set params
  no_dice <- list(1, 0, 0, 0, 0, 0)
  no_sims <- 50
  dice_types = global$dice_names
  die_sides <- 4
  
  # set seed and simulate using simulate_die_type
  set.seed(1)
  simulate_roll <- simulate_dice_roll(no_dice, no_sims, dice_types)
  
  # reset seed and simulate manually
  set.seed(1)
  dice_roll <- purrr::rdunif(no_sims, die_sides, 1)
  
  expect_equal(simulate_roll, dice_roll)
})

test_that("simulate_dice_roll simulates a number of dice roll", {
  
  # set params
  no_dice <- list(1, 0, 0, 0, 0, 2)
  no_sims <- 50
  dice_types = global$dice_names
  
  # set seed and simulate using simulate_die_type
  set.seed(1)
  simulate_roll <- simulate_dice_roll(no_dice, no_sims, dice_types)
  
  # reset seed and simulate manually
  set.seed(1)
  dice_roll_1 <- purrr::rdunif(no_sims, 4, 1)
  dice_roll_2 <- purrr::rdunif(no_sims, 20, 1)
  dice_roll_3 <- purrr::rdunif(no_sims, 20, 1)
  dice_roll <- dice_roll_1 + dice_roll_2 + dice_roll_3
  
  expect_equal(simulate_roll, dice_roll)
})

test_that("simulate_dice_roll returns zeros for zero dice selected", {
  
  # set params
  no_dice <- list(0, 0, 0, 0, 0, 0)
  no_sims <- 50
  dice_types = global$dice_names
  
  # set seed and simulate using simulate_die_type
  set.seed(1)
  simulate_roll <- simulate_dice_roll(no_dice, no_sims, dice_types)
  
  # reset seed and simulate manually
  set.seed(1)
  dice_roll <- rep_len(0, no_sims)
  
  expect_equal(simulate_roll, dice_roll)
})

test_that("simulate_dice_roll returns zero for invalid sims number", {
  
  # set params
  no_dice <- list(0, 0, 0, 0, 3, 0)
  no_sims <- "xyz"
  dice_types = global$dice_names
  
  # set seed and simulate using simulate_die_type
  set.seed(1)
  simulate_roll <- simulate_dice_roll(no_dice, no_sims, dice_types)
  
  # reset seed and simulate manually
  set.seed(1)
  dice_roll <- 0
  
  expect_equal(simulate_roll, dice_roll)
})



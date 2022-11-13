test_that("simulate_die_type simulates a die roll", {
  
  # set params
  no_dice <- 1
  die_type <- "d8"
  no_sims <- 100
  die_sides <- 8
  
  # set seed and simulate using simulate_die_type
  set.seed(1)
  simulate_roll <- simulate_die_type(no_dice, die_type, no_sims)
  
  # reset seed and simulate manually
  set.seed(1)
  dice_roll <- purrr::rdunif(no_sims, die_sides, 1)
  
  expect_equal(simulate_roll, dice_roll)
})

test_that("simulate_die_type simulates a number of dice roll", {
  
  # set params
  no_dice <- 3
  die_type <- "d20"
  no_sims <- 100
  die_sides <- 20
  
  # set seed and simulate using simulate_die_type
  set.seed(1)
  simulate_roll <- simulate_die_type(no_dice, die_type, no_sims)
  
  # reset seed and simulate manually
  set.seed(1)
  dice_roll_1 <- purrr::rdunif(no_sims, die_sides, 1)
  dice_roll_2 <- purrr::rdunif(no_sims, die_sides, 1)
  dice_roll_3 <- purrr::rdunif(no_sims, die_sides, 1)
  dice_roll <- dice_roll_1 + dice_roll_2 + dice_roll_3
  
  expect_equal(simulate_roll, dice_roll)
})

test_that("simulate_die_type returns zero for invalid die type", {
  
  # set params
  no_dice <- 3
  die_type <- "d9"
  no_sims <- 100

  # set seed and simulate using simulate_die_type
  set.seed(1)
  simulate_roll <- simulate_die_type(no_dice, die_type, no_sims)
  
  # reset seed and simulate manually
  set.seed(1)
  dice_roll <- 0
  
  expect_equal(simulate_roll, dice_roll)
})

test_that("simulate_die_type returns zero for invalid sims number", {
  
  # set params
  no_dice <- 3
  die_type <- "d4"
  no_sims <- "aa"
  
  # set seed and simulate using simulate_die_type
  set.seed(1)
  simulate_roll <- simulate_die_type(no_dice, die_type, no_sims)
  
  # reset seed and simulate manually
  set.seed(1)
  dice_roll <- 0
  
  expect_equal(simulate_roll, dice_roll)
})


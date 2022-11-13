test_that("simulate_iid_discrete_sum simulates single die roll", {
  
  # setting params
  no_variables = 1
  max = 6
  no_sims = 100
  min = 1
  
  # set seed and simulate using simulate_iid_discrete_sum
  set.seed(1)
  simulate_roll <- simulate_iid_discrete_sum(no_variables, max, no_sims, min)
  
  # reset seed and simulate manualy
  set.seed(1)
  dice_roll <- purrr::rdunif(no_sims, max, min)
  
  expect_equal(simulate_roll, dice_roll)
})

test_that("simulate_iid_discrete_sum simulates a number of dice roll", {
  
  # setting params
  no_variables = 2
  max = 10
  no_sims = 100
  min = 1
  
  # set seed and simulate using simulate_iid_discrete_sum
  set.seed(1)
  simulate_roll <- simulate_iid_discrete_sum(no_variables, max, no_sims, min)
  
  # reset seed and simulate manualy
  set.seed(1)
  dice_roll_1 <- purrr::rdunif(no_sims, max, min)
  dice_roll_2 <- purrr::rdunif(no_sims, max, min)
  dice_roll <- dice_roll_1 + dice_roll_2
  
  expect_equal(simulate_roll, dice_roll)
})

test_that("simulate_iid_discrete_sum return zeros for invalid dice number", {
  
  # setting params
  no_variables = -1
  max = 10
  no_sims = 100
  min = 1
  
  # set seed and simulate using simulate_iid_discrete_sum
  set.seed(1)
  simulate_roll <- simulate_iid_discrete_sum(no_variables, max, no_sims, min)
  
  # reset seed
  set.seed(1)
  dice_roll <- rep_len(0, no_sims)
  
  expect_equal(simulate_roll, dice_roll)
})

test_that("simulate_iid_discrete_sum return zero for invalid sims number", {
  
  # setting params
  no_variables = 2
  max = 10
  no_sims = -1
  min = 1
  
  # set seed and simulate using simulate_iid_discrete_sum
  set.seed(1)
  simulate_roll <- simulate_iid_discrete_sum(no_variables, max, no_sims, min)
  
  # reset seed
  set.seed(1)
  dice_roll <- 0
  
  expect_equal(simulate_roll, dice_roll)
})

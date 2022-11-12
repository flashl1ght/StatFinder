#' Simulates sum of a number of iid (Independent and identically distributed) discrete
#' random variables
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
  
  if (no_variables > 0 && max >= min && no_sims > 0) {
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
simulate_dice_roll <- function(no_dice, no_sims, dice_types = global$dice_names) {
  
  num_types <- length(no_dice)
  
  if (num_types > 0) {
    rolls_per_type <- lapply(seq_len(num_types), function(dice_index) {
      simulate_die_type(no_dice[[dice_index]], dice_types[[dice_index]], no_sims)
    })
    
    roll_sums <- Reduce(`+`, rolls_per_type)
  } else {
    roll_sums <- 0
  }
  
  return(roll_sums)
}
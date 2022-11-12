# Global variables for parameters
global <- new.env()

# Dice parameters
global$dice_names <- c("d4", "d6", "d8", "d10", "d12", "d20")
global$dice_no_sides <- list(4, 6, 8, 10, 12, 20)
names(global$dice_no_sides) <- global$dice_names

# sum_stats_tab params
global$sum_stats_default_sim_number <- 1000
global$sum_stats_header <- "Roll for damage"
global$sum_stats_description <- 
  "Select a number of dice and see what their sum distribution looks like"
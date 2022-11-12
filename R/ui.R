
# Shiny dashboard page
ui <- shinydashboard::dashboardPage(
  shinydashboard::dashboardHeader(
    title = "StatFinder"
  ),
  shinydashboard::dashboardSidebar(
    shinydashboard::sidebarMenu(
      id = "tabs_menu",
      shinydashboard::menuItem(
        "Home", 
        tabName = "home_tab",
        icon = shiny::icon("house", class = "fa-solid fa-house"),
        selected = TRUE
      ),
      shinydashboard::menuItem(
        "Roll for damage", 
        tabName = "sum_stats_tab",
        icon = shiny::icon("dice", class = "fa-solid fa-dice")
      )
    )
  ),
  shinydashboard::dashboardBody(
    # Prevent accidental window closing
    shiny::includeScript(
      system.file(file.path("www", "exit_popup.js"), package = "StatFinder")
    ),
    
    # Dashboard tabs
    shinydashboard::tabItems(
      shinydashboard::tabItem(
        tabName = "home_tab"
      ),
      shinydashboard::tabItem(
        tabName = "sum_stats_tab",
        
        # Call a function that creates the tab content
        sum_stats_ui()
      )
    )
  )
)
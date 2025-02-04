
# Packages
box::use(
  shiny[
    moduleServer, 
    NS, 
    tableOutput, 
    sliderInput, 
    fluidRow, 
    renderTable, 
    req
  ],
  shinydashboard[
    dashboardPage, 
    dashboardHeader,
    dashboardSidebar, 
    dashboardBody, 
    box
  ],
  stats[...], 
  readxl[read_excel], 
  datasets[...]
)

# Modules
box::use(
  app/view/read_in_data, 
  app/view/clean_validate
)


#' @export
ui <- function(id) {
  ns <- NS(id)
    
  
  dashboardPage(
    
    # HEADER ----
    dashboardHeader(title = "Bets"),
    
    # SIDEBAR ----
    dashboardSidebar(
      
      read_in_data$ui(ns("read_in_data_module"))
      
    ),
    
    # BODY ----
    dashboardBody(
      
      # Boxes need to be put in a row (or column)
      fluidRow(
        box(
          tableOutput(
            ns("input_data_table")
          ), width = 200
        )
      )
      
    )
  )
    
}

# SERVER ----
#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Files ----
    bets_template_file <- "data/bets_template.xlsx"
    
    # Read in data ----
    file_data <- read_in_data$server("read_in_data_module")
    
    output$input_data_table <- renderTable({
      req(file_data())
      file_data()
    })
    
    # Read in template
    # message(paste("--- Reading in template file", bets_template_file, "---"))
    # tryCatch({
    #   bets_template <- read_excel(bets_template_file)
    #   message(paste("--- Template file", bets_template_file, "read in successfully ---"))
    # }, error = \(e){
    #   message(
    #     paste(
    #       "---", 
    #       bets_template_file, 
    #       "not found ---"
    #     )
    #   )
    # })
    
  })
}






# Packages
box::use(
  shiny[
    moduleServer, 
    NS, 
    plotOutput, 
    sliderInput, 
    fluidRow, 
    renderPlot
  ],
  shinydashboard[
    dashboardPage, 
    dashboardHeader,
    dashboardSidebar, 
    dashboardBody, 
    box
  ],
  stats[...], 
  readxl[read_excel]
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
      
      read_in_data$ui(ns("read_in_data"))
      
    ),
    
    # BODY ----
    dashboardBody(
      
      # Boxes need to be put in a row (or column)
      # fluidRow(
      #   box(
      #     plotOutput(
      #       ns("plot1"),
      #       height = 250
      #     )
      #   ),
        
        # box(
        #   title = "Controls",
        #   sliderInput(
        #     ns("slider"),
        #     "Number of observations:", 
        #     1, 100, 50
        #   )
        # )
      # )
      
    )
  )
    
}

# SERVER ----
#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # set.seed(122)
    # histdata <- rnorm(500)
    # 
    # output$plot1 <- renderPlot({
    #   data <- histdata[seq_len(input$slider)]
    #   hist(data)
    # })
    
    # Files ----
    bets_template_file <- "data/bets_template.xlsx"
    
    # Read in data ----
    input_data <- read_in_data$server("read_in_data")
    
    # Read in template
    message(paste("--- Reading in", bets_template_file, "---"))
    tryCatch({
      bets_template <- read_excel(bets_template_file)
      message(paste("---", bets_template_file, "read in successfully ---"))
    }, error = \(e){
      message(
        paste(
          "---", 
          bets_template_file, 
          "not found ---"
        )
      )
    })
    
    # Clean and validate ----
    clean_validate$server("clean_validate", input_data, bets_template)
    
  })
}





#' #' @export
#' ui <- function(id) {
#'   ns <- NS(id)
#'   bootstrapPage(
#'     uiOutput(ns("message"))
#'   )
#' }
#' 
#' #' @export
#' server <- function(id) {
#'   moduleServer(id, function(input, output, session) {
#'     output$message <- renderUI({
#'       div(
#'         style = "display: flex; justify-content: center; align-items: center; height: 100vh;",
#'         tags$h1(
#'           tags$a("Check out Rhino docs!", href = "https://appsilon.github.io/rhino/")
#'         )
#'       )
#'     })
#'   })
#' }






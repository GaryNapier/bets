
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
  graphics[hist]
)

# Modules
box::use(
  app/view/read_in_data
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
      fluidRow(
        box(
          plotOutput(
            ns("plot1"),
            height = 250
          )
        ),
        
        box(
          title = "Controls",
          sliderInput(
            ns("slider"),
            "Number of observations:", 
            1, 100, 50
          )
        )
      )
      
    )
  )
    
}

# SERVER ----
#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    set.seed(122)
    histdata <- rnorm(500)
    
    output$plot1 <- renderPlot({
      data <- histdata[seq_len(input$slider)]
      hist(data)
    })
    
    # Read in data ----
    read_in_data$server("read_in_data")
    
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






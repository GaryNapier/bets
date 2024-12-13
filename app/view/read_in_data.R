
# READ IN DATA

box::use(
  shiny[
    moduleServer, 
    NS, 
    tagList, 
    fileInput, 
    reactive, 
    req, 
    observeEvent, 
    reactiveVal
  ], 
  readxl[read_excel]
)

# bets_data <- read_sheet(bets_clean_file)

#' @export
ui <- function(id) {
  ns <- NS(id)
  tagList(
    
    fileInput(
      ns("input_file"),
      "Input file",
    )
    
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    input_data_rctv <- reactiveVal()
    observeEvent(input$input_file, {
      
      req(input$input_file)
      
      input_data_rctv(
        read_excel(
          input$input_file$datapath
        )
      )
      
    })
    
    input_data_rctv
    
  })
}


# TODO
# bets_template error message - popup message with link if template not found














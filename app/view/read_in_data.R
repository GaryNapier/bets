
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
  readxl[read_excel], 
  shinyalert[shinyalert]
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
      
      input_data <- tryCatch(
          {
            message("--- Input file: reading in ", input$input_file$datapath)
            read_excel(input$input_file$datapath)
            message("--- Input file:", input$input_file$datapath, " read in successfully ---")
          }, error = \(e){
            print(
              utils::str(input$input_file)
            )
            err_msg <- paste(
              "Input file read-in error: ", input$input_file$name, 
              ";\nIs the file .xls or .xlsx?"
              )
            message(err_msg)
            shinyalert(
              title = "Error", 
              type = "error", 
              text = err_msg
            )
          }
        )
      
      # Set input data reactive
      input_data_rctv(input_data)
      
    })
    
    input_data_rctv
    
  })
}


# TODO
# bets_template error message - popup message with link if template not found














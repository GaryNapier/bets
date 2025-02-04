
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

#' @export
ui <- function(id) {
  ns <- NS(id)
  tagList(
    fileInput(
      ns("input_file"), 
      "Input file"
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    file_data <- reactive({
      req(input$input_file)
      tryCatch({
        message(paste("--- Input file: reading in", input$input_file$name, "---"))
        read_excel(input$input_file$datapath)
       }, error = \(e){
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
         err_msg
      })
    })
    return(file_data)
  })
}

# TODO
# bets_template error message - popup message with link if template not found




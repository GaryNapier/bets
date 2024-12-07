
# READ IN DATA

box::use(
  shiny[
    moduleServer, 
    NS, 
    tagList, 
    fileInput, 
    reactive
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
      width = NULL
    )
    
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Files ----
    bets_template_file <- "data/bets_template.xlsx"
    
    input_file <- reactive({
      req(input$input_file)
    })
    
    # Read in template ----
    message(paste("--- Reading in", bets_template_file, "---"))
    bets_template <- tryCatch({
      read_excel(bets_template_file)
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
    
    # Read in input file ----
    message("--- Reading in input file ---")
    reactive({
      read_excel(req(input_file()))
    })
    
  })
}




# TODO
# bets_template error message - popup message with link if template not found














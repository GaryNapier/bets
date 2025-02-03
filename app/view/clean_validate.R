
# CLEAN AND VALIDATE DATA

box::use(
  shiny[
    moduleServer, 
    NS, 
    req, 
    reactive
  ],
  readxl[read_excel]
)

box::use(
  app/logic/bets_app_functions[TestHeaders]
)

ui <- function(id) {
  # Create unique variable name
  ns <- NS(id)
  
}


server <- function(id, input_data, bets_template) {
  moduleServer(
    id = id,
    module = function(input, output, session) {
      
      # Test headers, returns TRUE or FALSE and issues shiny alert if fail
      headers_test <- reactive({
        
        req(input_data())
        
        # Headers
        template_headers <- names(bets_template)
        input_file_headers <- names(input_data())
        
        TestHeaders(template_headers, input_file_headers)
      })
      
    }
  )
}

# input_file <- "../../Downloads//bets_clean_prelim_wrangle.xlsx"
# 
# bets_template_file <- "data/bets_template.xlsx"
# 
# input_file <- read_excel(input_file)
# 
# bets_template <- read_excel(bets_template_file)




# Break down template file into metadata 
# i.e. get the headers and datatypes of each col

# # Headers
# template_headers <- names(bets_template)
# input_file_headers <- names(input_file)
# 
# extra_header <- c(input_file_headers, "extra_header")
# 
# UnionSetdiff(template_headers, extra_header)
# 
# header_missing <- input_file_headers[-length(input_file_headers)]
# 
# UnionSetdiff(header_missing, template_headers)
# 
# header_incorrect <- replace(
#   input_file_headers, 
#   input_file_headers == "Comments", 
#   "comments"
# )
# 
# setdiff(header_incorrect, template_headers)
# setdiff(template_headers, header_incorrect)
# 
# multiple_wrong <- replace(
#   input_file_headers, 
#   input_file_headers %in% c("n", "SP", "Comments"), 
#   c("N", "xyz", "comments")
# )
# 
# setdiff(multiple_wrong, template_headers)
# setdiff(template_headers, multiple_wrong)
# 
# multiple_wrong_and_extra <- c(multiple_wrong, "abc")
# 
# setdiff(multiple_wrong_and_extra, template_headers)
# setdiff(template_headers, multiple_wrong_and_extra)
# 
# multiple_wrong_and_missing <- multiple_wrong[-3]
# 
# setdiff(multiple_wrong_and_missing, template_headers)
# setdiff(template_headers, multiple_wrong_and_missing)
















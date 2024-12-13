

# library(data.table)
# library(stringr)

box::use(
  data.table[...], 
  stringr[...], 
  shinyalert[shinyalert]
)


# Clean vector of prices
# Remove rubbish strings "ex", RF etc
# Convert fraction to decimal price and concat with already decimal 
# Only used in preliminary_wrangling.R
#' @export
CleanPrice <- function(price){
  
  price <- gsub("ex|\\(RF\\)|\\*|\\+|R4", "", price)
  # Split the fractions by "/" and make 2 cols
  price_split <- data.table(str_split(price, "/", simplify = TRUE))
  setnames(price_split, c("num", "den"))
  # Flag decimal prices
  price_split[, is_dec := grepl("\\.", price_split$num), ]
  # If the price is a fraction (not dec) but the den is missing, then make 1
  price_split[den == "" & !is_dec, den := "1", ]
  price_split[ , num := as.numeric(num), ]
  price_split[ , den := as.numeric(den), ]
  # Calc the dec from the fraction and move the dec across to the new dec col
  price_split[is_dec == FALSE, dec := round((num/den) + 1, 1), ]
  price_split[is_dec == TRUE, dec := num, ]
  price_split$dec
}

#' @export
CleanMoney <- function(x){
  as.numeric(gsub(",", "", gsub("£", "", x)))
}

#' @export
PcTable <- function(x, rnd = 1){
  tab <- table(x)
  nms <- names(tab)
  pcs <- paste0("(", round(prop.table(tab)*100, rnd), "%)")
  pcs_table <- paste(tab, pcs)
  names(pcs_table) <- nms
  pcs_table
  data.table(
    x = nms,
    "n (%)" = pcs_table
  )
}

# Validation ----

#' @export
TestHeaders <- function(template_headers, input_file_headers){
  
  # Test headers
  headers_test <- identical(template_headers, input_file_headers)
  
  if(headers_test){
    
    message("--- Headers match ---")
    return(TRUE)
    
  }else{
    
    # If headers are not the same, get the mismatches
    message("--- Headers do not match ---")
    
    # Get what's wrong in input file
    wrong_headers <- setdiff(input_file_headers, template_headers)
    
    # Get what's right in template
    right_headers <- setdiff(template_headers, input_file_headers)
    
    if(length(wrong_headers) > 0 | length(right_headers) > 0 ){
      
      msg <- paste0(
        "Wrong headers\n", 
        wrong_headers, 
        "\n",
        "Should be\n", 
        right_headers
      )
      
      shinyalert(
        msg, 
        type = "error"
      )
    }
    return(FALSE)
  }
  
}

# Utils ----

# setdiff depends on order if there's one extra or one missing, so call both
#' @export
UnionSetdiff <- function(x, y){
  union(
    setdiff(x, y), 
    setdiff(y, x)
  )
}





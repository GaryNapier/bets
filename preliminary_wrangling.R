
# Wrangle "clean" version of data to produce:
# 1. Even cleaner version of data e.g. wrangle the result column to 0, 1, 2, 3 from result character col (e.g. "Won*" etc)
# 2. This helps create the template because then can get the formula for e.g. win total (a cumulative count of result = 1)

# In other words, this scripts avoids going through e.g. the Result col ("PU", "unpl", "2nd", "PU", "Won*", etc..) and changing to 0, 1, 2, 3

library(dplyr)
library(googlesheets4)
library(janitor)

source("app/logic/bets_app_functions.R")

bets_clean_file <- "https://docs.google.com/spreadsheets/d/1W07fYGXmWTqsnwU4blM-ZxQTqA6mJW69JMVoBC3qde4/edit?usp=sharing"

bets_clean <- read_sheet(bets_clean_file)

# For some reason col n is read in as list
bets_clean$n <- bets_clean$n |> unlist() |> as.numeric()

# Put the two comments columns together
bets_clean <- bets_clean |> 
  unite(
    "comments", 
    comments, 
    comments_continued, 
    sep = "\n",
    na.rm = T
  )

# Remove empty columns
bets_clean <- remove_empty(bets_clean, which = "cols")

# Remove empty rows
bets_clean <- remove_empty(bets_clean, which = "rows")

# Remove empty rows from n onwards (lots of redundant n - index number col)
bets_clean <- bets_clean |> filter(
complete.cases(
  bets_clean |> select(-n)
  )
)

# Convert price to decimal
bets_clean <- bets_clean |> mutate(
  Price_taken_dec = CleanPrice(Price_taken),
  SP_dec = CleanPrice(sp)
)

# Save
write.csv(bets_clean, file = "data/bets_clean_prelim_wrangle.csv", row.names = F)

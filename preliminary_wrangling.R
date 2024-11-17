
# Wrangle "clean" version of data to produce:
# 1. Even cleaner version of data e.g. wrangle the result column to 0, 1, 2, 3 from result character col (e.g. "Won*" etc)
# 2. This helps create the template because then can get the formula for e.g. win total (a cumulative count of result = 1)

# In other words, this scripts avoids going through e.g. the Result col ("PU", "unpl", "2nd", "PU", "Won*", etc..) and changing to 0, 1, 2, 3

bets_clean_file <- "https://docs.google.com/spreadsheets/d/1W07fYGXmWTqsnwU4blM-ZxQTqA6mJW69JMVoBC3qde4/edit?usp=sharing"

bets_clean <- read_sheet(bets_clean_file)

bets_clean <- bets_clean |> mutate(
  n = n |> unlist() |> as.numeric()
)

bets_clean <- bets_clean |> mutate(
  Result = case_when(
    Result_comment == "Won*" ~ "1", 
    Result_comment == "2nd" ~ "2",
    Result_comment == "3rd" ~ "3", 
    .default = "0"
  ) |> as.numeric()
)


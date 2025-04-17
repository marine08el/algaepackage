library(readxl)
library(usethis)
library(dplyr)
library(janitor)

# 1. Excel file
algae <- read_excel("C:/Users/Startklar/Documents/EAGLE/Programming/R_Package/Algae/Algae/Algae.xlsx") |>
  clean_names()


# 2. Save data in the package
usethis::use_data(algae, overwrite = TRUE)

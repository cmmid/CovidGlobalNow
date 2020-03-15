# Packages ----------------------------------------------------------------
require(TimeVaryingNCovR0)
require(readxl)
require(dplyr)
require(tidyr)
require(tibble)
require(NCoVUtils)

# Read in linelist --------------------------------------------------------
linelist <- get_international_linelist(cities = "Hong Kong")

# Get WHO sit rep case counts ---------------------------------------------

total_cases <- TimeVaryingNCovR0::get_who_cases(country = "China-HongKongSAR", daily = TRUE)

total_cases <- total_cases[-c(1:3), ]

# deal with negative cases
total_cases$cases <- ifelse(total_cases$cases < 0, 0, total_cases$cases )

# Join imported and local cases -------------------------------------------

cases <- TimeVaryingNCovR0::get_local_import_case_counts(total_cases, linelist)


# Run analysis pipeline and save results ----------------------------------

## Set the target date
target_date <- as.character(max(cases$date))

## Run and save analysis pipeline
TimeVaryingNCovR0::analysis_pipeline(
  cases = cases,
  linelist = linelist,
  target_folder = file.path("inst/results/hong-kong", target_date),
  target_date = target_date)

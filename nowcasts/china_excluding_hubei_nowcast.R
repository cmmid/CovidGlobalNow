# Packages ----------------------------------------------------------------
require(TimeVaryingNCovR0)
require(readxl)
require(dplyr)
require(tidyr)
require(tibble)
require(NCoVUtils)
require(nCov2019)

# Read in linelist --------------------------------------------------------
linelist <- get_international_linelist("China")

# Get WHO sit rep case counts ---------------------------------------------

total_cases <- TimeVaryingNCovR0::get_who_cases(country = "China", daily = TRUE)

hubei_cases <-  TimeVaryingNCovR0::get_who_cases(country = "China-Hubei", daily = TRUE)

total_cases$cases <- total_cases$cases - hubei_cases$cases

total_cases <- total_cases

# Assume that all cases are local -----------------------------------------

## Drop data from 17th and before due to reporting changes
cases <- get_local_import_case_counts(total_cases, linelist) %>%
  dplyr::filter(date > as.Date("2020-02-01"))

# Run analysis pipeline and save results ----------------------------------

## Set the target date
target_date <- as.character(max(cases$date))

## Run and save analysis pipeline
TimeVaryingNCovR0::analysis_pipeline(
  cases = cases,
  linelist = linelist,
  target_folder = file.path("inst/results/china-excluding-hubei", target_date),
  target_date = target_date,
  earliest_allowed_onset = "2020-02-01")

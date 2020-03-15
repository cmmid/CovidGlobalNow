# Packages ----------------------------------------------------------------
require(TimeVaryingNCovR0)
require(dplyr)

# Read in linelist --------------------------------------------------------
linelist <- get_international_linelist("Germany") %>%
  tidyr::drop_na(date_confirm)

# Get WHO sit rep case counts ---------------------------------------------

total_cases <- TimeVaryingNCovR0::get_who_cases("Germany", daily = TRUE)


# Join imported and local cases -------------------------------------------

cases <- TimeVaryingNCovR0::get_local_import_case_counts(total_cases, linelist) %>%
  dplyr::filter(date >= "2020-02-26")

# Run analysis pipeline and save results ----------------------------------

## Set the target date
target_date <- as.character(max(cases$date))

## Run and save analysis pipeline
TimeVaryingNCovR0::analysis_pipeline(
  cases = cases,
  linelist = linelist,
  target_folder = file.path("inst/results/germany", target_date),
  target_date = target_date)

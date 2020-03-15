# Packages ----------------------------------------------------------------
require(TimeVaryingNCovR0)
require(readxl)
require(dplyr)
require(tidyr)
require(tibble)
require(NCoVUtils)
require(nCov2019)

# Read in linelist --------------------------------------------------------
linelist <- get_international_linelist("China") %>%
  dplyr::mutate(import_status = "local")

# Get WHO sit rep case counts ---------------------------------------------

total_cases <- TimeVaryingNCovR0::get_who_cases(country = "China", daily = TRUE)


# Assume that all cases are local -----------------------------------------

cases <- get_local_import_case_counts(total_cases, linelist)

# Run analysis pipeline and save results ----------------------------------

## Set the target date
target_date <- as.character(max(cases$date))

## Run and save analysis pipeline
TimeVaryingNCovR0::analysis_pipeline(
  cases = cases,
  linelist = linelist,
  target_folder = file.path("inst/results/china", target_date),
  target_date = target_date, save_plots = TRUE)

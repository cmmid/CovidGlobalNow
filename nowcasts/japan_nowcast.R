# Packages ----------------------------------------------------------------
require(TimeVaryingNCovR0)
require(readxl)
require(dplyr)
require(tidyr)
require(tibble)

# Read in linelist --------------------------------------------------------
linelist <- readxl::read_xlsx("data-raw/japan.xlsx") %>%
  dplyr::mutate(import_status =
                  dplyr::if_else(!is.na(Imported), "imported", "local"),
                ## Clean up onset date based on excel origin
                date_onset = as.numeric(`Sx onset`) %>%
                  as.Date(origin = "1900-01-01"),
                date_confirm = as.Date(`Dx date`),
                ## Estimate report delay - could also use isolation date here.
                report_delay = as.numeric(date_confirm - date_onset),
                ## Set negative report delays to 0
                report_delay = dplyr::if_else(report_delay < 0, 0, report_delay))

# Get WHO sit rep case counts ---------------------------------------------

total_cases <- TimeVaryingNCovR0::get_who_cases(country = "Japan", daily = TRUE)

# Manually correct cases
total_cases[total_cases$date %in% "2020-02-05", ]$cases <- 3
total_cases[total_cases$date %in% "2020-02-06", ]$cases <- 2

# Join imported and local cases -------------------------------------------

cases <- TimeVaryingNCovR0::get_local_import_case_counts(total_cases, linelist)

# Run analysis pipeline and save results ----------------------------------

## Set the target date
target_date <- as.character(max(cases$date))

## Run and save analysis pipeline
TimeVaryingNCovR0::analysis_pipeline(
  cases = cases,
  linelist = linelist,
  target_folder = file.path("inst/results/japan", target_date),
  target_date = target_date,
  start_rate_of_spread_est = "2020-01-27")

# Get utils ---------------------------------------------------------------

source("utils/rt_pipeline.R")

# Read in linelist --------------------------------------------------------
linelist <- NCoVUtils::get_international_linelist("Germany")

# Get WHO sit rep case counts ---------------------------------------------

total_cases <-NCoVUtils::get_who_cases("Germany", daily = TRUE)


# Join imported and local cases -------------------------------------------

cases <- EpiNow::get_local_import_case_counts(total_cases, linelist,
                                                         cases_from = "2020-02-26")

# Run analysis pipeline and save results ----------------------------------

## Set the target date
target_date <- as.character(max(cases$date))

## Run and save analysis pipeline
rt_pipeline(
  cases = cases,
  linelist = linelist,
  target_folder = file.path("results/germany", target_date),
  target_date = target_date)

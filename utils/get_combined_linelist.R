#' Get a combined linelist based on multiple countries data
get_combined_linelist <- function() {
  NCoVUtils::get_international_linelist("Germany") %>%
    dplyr::bind_rows(NCoVUtils::get_international_linelist("Italy")) %>%
    dplyr::bind_rows(NCoVUtils::get_international_linelist("France")) %>%
    dplyr::bind_rows(NCoVUtils::get_international_linelist("Spain")) %>%
    dplyr::bind_rows(NCoVUtils::get_international_linelist("Autria")) %>%
    dplyr::bind_rows(NCoVUtils::get_international_linelist("Netherlands")) %>%
    dplyr::bind_rows(NCoVUtils::get_international_linelist("Belgium")) %>%
    tidyr::drop_na(report_delay)
}

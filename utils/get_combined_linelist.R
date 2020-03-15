#' Get a combined linelist based on multiple countries data
#'
#' @return A linelist from multiple countries
#' @export
#' @importFrom tidyr drop_na
#' @examples
#'
get_combined_linelist <- function() {
  get_international_linelist("Germany") %>%
    dplyr::bind_rows(get_international_linelist("Italy")) %>%
    dplyr::bind_rows(get_international_linelist("France")) %>%
    dplyr::bind_rows(get_international_linelist("Spain")) %>%
    dplyr::bind_rows(get_international_linelist("Autria")) %>%
    dplyr::bind_rows(get_international_linelist("Netherlands")) %>%
    dplyr::bind_rows(get_international_linelist("Belgium")) %>%
    tidyr::drop_na(report_delay)
}

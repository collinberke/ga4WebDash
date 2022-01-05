#'
#' @export
#'
clean_col_names <- function(df) {
  dplyr::rename_with(df, ~stringr::str_to_title(stringr::str_replace_all(.x, "_", " ")))
}



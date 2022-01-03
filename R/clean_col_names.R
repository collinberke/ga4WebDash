
clean_col_names <- function(df) {
  rename_with(df, ~str_to_title(str_replace_all(.x, "_", " ")))
}



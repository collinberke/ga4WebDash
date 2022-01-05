#'
#' @export
#'
create_trend_plot <- function(data,
                              mean_data,
                              mean_trend = FALSE,
                              date_var,
                              y_var,
                              y_label
                              ){

  # Create the plot
  plot <- ggplot(data, aes(x = {{date_var}}, y = {{y_var}})) +
    geom_line(size = 2) +
    labs(x = "", y = y_label) +
    theme_minimal() +
    theme(axis.text = element_text(size = 14),
          panel.grid.minor = element_blank())

  # Option to add mean trend
  if(identical(mean_trend, "Mean")){
    plot +
      geom_hline(yintercept = mean_data,
                      size = 2, linetype = "dashed", color = "blue")
  } else if (identical(mean_trend, "Linear")) {
    plot + geom_smooth(method = "lm")
  } else if (identical(mean_trend, "Loess")) {
    plot + geom_smooth()
  } else {
    plot
  }

}

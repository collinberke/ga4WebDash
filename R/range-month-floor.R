#'
#' @export
#'
dateRangeFloorMonth <- function(id, date = Sys.Date(), ...) {
  dateRangeInput(id,
                 start = lubridate::floor_date(date, unit = "month"),
                 end = lubridate::ceiling_date(date, unit = "month"),
                 ...
                 )
}

# todo_ cleanup : remove intervals of zero lentgh (če isti začetek in konec)
# todo: naslednja funkcija - klasificiraj interval: če je 
# AFIB - N = during_AFIB
# N - AFIB = before_AFIB
# N - N  = normal
# AFIB - AFIB = during_AFIB

#' @title Labels intervals for AFIB 
#' 
#' @export
label_interval_type_AFIB <- function(data) {
  data[ ((data$Signal_at_start == "(N" ) & (data$Signal_at_end == "(N") ), "Interval_type"] <- "normal_to_normal"
  data[ ((data$Signal_at_start == "(N" ) & (data$Signal_at_end == "(AFIB") ), "Interval_type"] <- "normal_to_AFIB"
  data[ ((data$Signal_at_start == "(AFIB" ) & (data$Signal_at_end == "(AFIB") ), "Interval_type"] <- "AFIB_to_AFIB"
  data[ ((data$Signal_at_start == "(AFIB" ) & (data$Signal_at_end == "(N") ), "Interval_type"] <- "AFIB_to_normal"
  
  return(data)    
}

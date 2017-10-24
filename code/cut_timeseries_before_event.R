# cut up timeseries into series before the event taking place

# najprej za probo sddb
str(sddb_data)
# lahko se začne z (N ali pa ne
# kar je med (AFIB in (N zavržemo
# 1. za prvi del vzamem vse do prvega (AFIB
# 2. za naslednji del vzamem vse od naslednjega (N do (AFIB oz. do konca če ni več AFIB
# 3. ponovim 2.
# v prvi fazi zapisujem samo začetke in konce intervalov

str(sddb_data$`30`$annotations)

find_annotation <- function(annotation_time = "Seconds",
                            annotation_data,
                            lookup_column = "Aux",
                            lookup_texts) {
  # vrne naj Seconds in Annotation=lookupt column, kjer najde match v lookup column
  result <- annotation_data[(annotation_data[, lookup_column] %in% lookup_texts), c(annotation_time, lookup_column)]
  return(result)
}

result <- find_annotation(annotation_data = sddb_data$`30`$annotations, lookup_texts = c("(N", "(AFIB"))
head(result)
result
head(sddb_data$`30`$annotations)

# napiši funkcijo, ki pogleda zanimivie annotacije in vrne začetek in konec intervalov brez dogodka
# za prvi interval doda na -0.1 sekundo, da je začetek non-eventa (to bi moralo biti OK generalno?)
return_interval_boundaries <- function(event_start_signal = "(AFIB",
                                       event_end_signal = "(N" ) {
  
  # return a list or a dtaframe ? of start/ end pairs; 
}
  
  
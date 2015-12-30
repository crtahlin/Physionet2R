# data import for mimic2db ####

# # set the MIMIC II ver 2 database directory as working dir
workingDirWindows <- "c:/cygwin/usr/database/mimic2db/"

# Cygwin compliant path to database 
workingDirCygwin <- "/cygdrive/c/cygwin/usr/database/mimic2db/"

# load RECORDS list
parseRecords <- paste("cat ",workingDirCygwin, "RECORDS_with_alM_annotations.txt", sep="")
mimic2dbRecords <- system(parseRecords, intern=TRUE)


# import data  - RR intervals
# sddbPatientsRR <- list()
# dataframe <- data.frame()
# i <- 1
# for (rec in mimic2dbRecords) {
#   filename <- paste(workingDirWindows, rec, ".unauditedRR.txt", sep="")
#   dataframe <- read.table(filename, sep="\t", dec=".")
#   colnames(dataframe) <-
#     c("initialTimes","initialAnnotations","intervals",
#       "finalAnnotations","finalTimes")
#   sddbPatientsRR[[i]] <- dataframe
#   names(sddbPatientsRR)[i] <- paste("Zapis", rec)
#   i <- i+1
# }
# 
# # import data - BPM (constructed with ihr)
# sddbPatientsHR <- list()
# dataframe <- data.frame()
# i <- 1
# for (rec in mimic2dbRecords) {
#   filename <- paste(workingDirWindows, rec, ".unauditedHR.txt", sep="")
#   dataframe <- read.table(filename, sep="\t", dec=".")
#   colnames(dataframe) <-
#     c("initialTimes","BPM","followsRejected")
#   sddbPatientsHR[[i]] <- dataframe
#   names(sddbPatientsHR)[i] <- paste("Zapis", rec)
#   i <- i+1
# }
# 

# import data - heart rate (and the rest, just in case we need them later on)
mimic2dbPatientsNumerics <- list()
# dataframe <- data.frame()
i <- 1
for (rec in mimic2dbRecords) {
  filename <- paste(workingDirWindows, rec, ".timeseries.txt", sep="")
  # skip first two lines and load these header lines separately
  try(dataframe <- read.table(filename, sep="\t", dec=".", skip=2))
  try(header <- read.table(filename, sep="\t", dec=".", nrows=1, as.is=TRUE))
  try(colnames(dataframe) <- header)
  
  mimic2dbPatientsNumerics[[i]] <- dataframe
  names(mimic2dbPatientsNumerics)[i] <- paste("Zapis", rec)
  i <- i+1
}

# import the annotations - the human audited ones
mimic2dbPatientsAnnotations <- list()
dataframe <- data.frame()
i <- 1
for (rec in mimic2dbRecords) {
  filename <- paste(workingDirWindows, rec, ".audited.alarm.annotations.txt", sep=c(""))
  # doc <- paste(readLines(filename), collapse="\n")
  # doc <- gsub("0\n", "0\tNA\n", doc) # add a tab mark at the end of the line
  # doc <- gsub("0$", "0\tNA", doc)
  # write(doc, file=paste(filename,"_corrected.txt",  sep=""))
  
  #colnames(dataframe) <-
  #  c("Seconds", "Minutes", "Hours", "Type", "Sub", "Chan", "Num", "Aux")
  dataframe <- read.table(filename, sep="\t", dec=".", header=TRUE, quote="")

  mimic2dbPatientsAnnotations[[i]] <- dataframe
  names(mimic2dbPatientsAnnotations)[i] <- paste("Zapis", rec)
  i <- i+1
}


# plot all of the mimic2dbRecords
i <- 1
for (rec in mimic2dbRecords){
  jpeg(filename=paste("./figures/mimic2db_HR_", names(mimic2dbPatientsNumerics[i]),
                      ".jpg",
                      sep=""),
       width = 1500,
       height = 50,
       units="cm",
       res=72)
  try(plot(mimic2dbPatientsNumerics[[i]]$"     HR" ~ I(mimic2dbPatientsNumerics[[i]]$"   Elapsed time"/60),
       type="l", ylim=c(40,180), xlim=c(0,4000),
       xlab="Minute od začetka opazovanja",
       ylab="Srčni utrip v sekundah (HR)",
       main= names(mimic2dbPatientsNumerics[i]),
       lwd=0.1))
# TODO: need to draw graphs dynamically depending on their range or alternatively use a common large enough plot size
  # draw alarms
  try(text(x = mimic2dbPatientsAnnotations[[i]][,"Seconds"]/60,
         y = rep(50, length(mimic2dbPatientsAnnotations[[i]][,"Seconds"])),
         col="red",
         cex=5, 
       labels=mimic2dbPatientsAnnotations[[i]]$Aux
  ))

  axis(at=seq(0,1600,by=10), side=1)
  dev.off()
  i <- i + 1
}

# how much memory do the objects need?
sort( sapply(ls(),function(x){object.size(get(x))}))

# what levels of annotations exist?
i <- 1
for (rec in mimic2dbRecords) {
  print(levels(sddbPatientsAnnotations[[i]][["Aux"]]))
  i <- i+1
}
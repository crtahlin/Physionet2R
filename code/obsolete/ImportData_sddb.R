# data import for ssdb ####

# set working dir
workingDir <- "/home/crtah/CloudStation/Projects/physionet/sddb/" 

# load RECORDS list
parseRecords <- paste("cat ",workingDir, "RECORDS", sep="")
sddbRecords <- system(parseRecords, intern=TRUE)

# import data  - RR intervals
sddbPatientsRR <- list()
dataframe <- data.frame()
i <- 1
for (rec in sddbRecords) {
  filename <- paste(workingDir, rec, ".unauditedRR.txt", sep="")
  dataframe <- read.table(filename, sep="\t", dec=".")
  colnames(dataframe) <-
    c("initialTimes","initialAnnotations","intervals",
      "finalAnnotations","finalTimes")
  sddbPatientsRR[[i]] <- dataframe
  names(sddbPatientsRR)[i] <- paste(rec)
  i <- i+1
}

# import data - BPM (constructed with ihr)
sddbPatientsHR <- list()
dataframe <- data.frame()
i <- 1
for (rec in sddbRecords) {
  filename <- paste(workingDir, rec, ".unauditedHR.txt", sep="")
  dataframe <- read.table(filename, sep="\t", dec=".")
  colnames(dataframe) <-
    c("initialTimes","BPM","followsRejected")
  sddbPatientsHR[[i]] <- dataframe
  names(sddbPatientsHR)[i] <- paste("Zapis", rec)
  i <- i+1
}


# import data - const interval BPM (constructed with tach)
sddbPatientsHRconstint <- list()
dataframe <- data.frame()
i <- 1
for (rec in sddbRecords) {
  filename <- paste(workingDir, rec, ".unauditedHRconstint.txt", sep="")
  dataframe <- read.table(filename, sep="\t", dec=".")
  colnames(dataframe) <-
    c("initialTimes","BPM")
  sddbPatientsHRconstint[[i]] <- dataframe
  names(sddbPatientsHRconstint)[i] <- paste("Zapis", rec)
  i <- i+1
}

# import the annotations
sddbPatientsAnnotations <- list()
dataframe <- data.frame()
i <- 1
for (rec in sddbRecords) {
  filename <- paste(workingDir, rec, ".annotations.txt", sep=c(""))
  doc <- paste(readLines(filename), collapse="\n")
  doc <- gsub("0\n", "0\tNA\n", doc) # add a tab mark at the end of the line
  doc <- gsub("0$", "0\tNA", doc)
  write(doc, file=paste(filename,"_corrected.txt",  sep=""))
  
  #colnames(dataframe) <-
  #  c("Seconds", "Minutes", "Hours", "Type", "Sub", "Chan", "Num", "Aux")
  dataframe <- read.table(paste(filename,"_corrected.txt",  sep=""),
                          sep="", dec=".", header=TRUE)
  
  sddbPatientsAnnotations[[i]] <- dataframe
  names(sddbPatientsAnnotations)[i] <- paste("Zapis", rec)
  i <- i+1
}

# plot all of the sddbRecords
i <- 1
for (rec in sddbRecords){
  jpeg(filename=paste("./figures/sddb_RRinterval_", names(sddbPatientsRR[i]),
                     ".jpg",
                     sep=""),
      width = 1500,
      height = 50,
       units="cm",
       res=72)
  plot(sddbPatientsRR[[i]]$intervals ~ I(sddbPatientsRR[[i]]$finalTimes/60),
       type="l", ylim=c(0,5), xlim=c(0,1600),
       xlab="Minute od začetka opazovanja",
       ylab="Interval med utripi v sekundah (RR interval)",
       main= names(sddbPatientsRR[i]),
       lwd=0.1)
  # draw start of Atrial Fibrilations
  points(x = sddbPatientsAnnotations[[i]][which(sddbPatientsAnnotations[[i]]["Aux"]=="(AFIB"),"Seconds"]/60,
         y = rep(0, length(which(sddbPatientsAnnotations[[i]]["Aux"]=="(AFIB"))),
         pch=24,
         col="red",
         cex=2
  )
  # draw start of normal synus rhythm
  points(x = sddbPatientsAnnotations[[i]][which(sddbPatientsAnnotations[[i]]["Aux"]=="(N"),"Seconds"]/60,
         y = rep(0, length(which(sddbPatientsAnnotations[[i]]["Aux"]=="(N"))),
         pch=24,
         col="green",
         cex=2
  )
  axis(at=seq(0,1600,by=10), side=1)
  dev.off()
  i <- i + 1
}

# how much memory do the objects need?
sort( sapply(ls(),function(x){object.size(get(x))}))

# what levels of annotations exist?
i <- 1
for (rec in sddbRecords) {
print(levels(sddbPatientsAnnotations[[i]][["Aux"]]))
i <- i+1
}
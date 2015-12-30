# data import for nsr2db ####

# # set the Normal Synus Rhythm RR databse directory as working dir
workingDirWindows <- "c:/cygwin/usr/database/nsr2db/"

# Cygwin compliant path to database 
workingDirCygwin <- "/cygdrive/c/cygwin/usr/database/nsr2db/"

# load RECORDS list
parseRecords <- paste("cat ",workingDirCygwin, "RECORDS", sep="")
records <- system(parseRecords, intern=TRUE)


# import data  - RR intervals
normalRR <- list()
dataframe <- data.frame()
i <- 1
for (rec in records) {
  filename <- paste(workingDirWindows, rec, ".correctedRR.txt", sep="")
  dataframe <- read.table(filename, sep="\t", dec=".")
  colnames(dataframe) <-
    c("initialTimes","initialAnnotations","intervals",
      "finalAnnotations","finalTimes")
  normalRR[[i]] <- dataframe
  names(normalRR)[i] <- paste("Zapis", rec)
  i <- i+1
}

# import data - BPM (constructed with ihr)
normalHR <- list()
dataframe <- data.frame()
i <- 1
for (rec in records) {
  filename <- paste(workingDirWindows, rec, ".correctedHR.txt", sep="")
  dataframe <- read.table(filename, sep="\t", dec=".")
  colnames(dataframe) <-
    c("initialTimes","BPM","followsRejected")
  normalHR[[i]] <- dataframe
  names(normalHR)[i] <- paste("Zapis", rec)
  i <- i+1
}


# import data - const interval BPM (constructed with tach)
normalHRconstint <- list()
dataframe <- data.frame()
i <- 1
for (rec in records) {
  filename <- paste(workingDirWindows, rec, ".correctedHRconstint.txt", sep="")
  dataframe <- read.table(filename, sep="\t", dec=".")
  colnames(dataframe) <-
    c("initialTimes","BPM")
  normalHRconstint[[i]] <- dataframe
  names(normalHRconstint)[i] <- paste("Zapis", rec)
  i <- i+1
}

# plot all of the records
i <- 1
for (rec in records){
  jpeg(filename=paste("./figures/nsr2db_RRinterval_", names(normalRR[i]), ".jpg",
                      sep=""
                      ),
       width = 150,
       height = 10,
       units="cm",
       res=72)
  plot(normalRR[[i]]$intervals ~ I(normalRR[[i]]$finalTimes/60),
       type="l", ylim=c(0,5), xlim=c(0,1600),
       xlab="Minute od začetka opazovanja",
       ylab="Interval med utripi v sekundah (RR interval)",
       main= names(normalRR[i]),
       lwd=0.1,
       width = 1500,
       height = 50
       )
  axis(at=seq(0,1600,by=10), side=1)
  dev.off()
  i <- i + 1
}

# how much memory do the objects need?
sort( sapply(ls(),function(x){object.size(get(x))}))

# get a feeling for how many lagre values are in a subjects RR stream
for (i in names(normalRR)) {
  x <- (normalRR[[i]][which(normalRR[[i]][["intervals"]]>4),])
  print(dim(x)[1])
  # look a t values larger than 4?
}



plot(normalRR[["Zapis nsr003"]]$intervals ~ I(normalRR[["Zapis nsr003"]]$finalTimes/60),
     type="l", ylim=c(0.4,1.3), xlim=c(0,1500),
     xlab="Minute od začetka opazovanja",
     ylab="Interval med utripi v sekundah (RR interval)",
     main= names(normalRR["Zapis nsr003"]),
     cex=0.2,
     lwd=0.2)
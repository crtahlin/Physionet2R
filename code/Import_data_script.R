detach("package:physionet2R", unload = TRUE)
library(physionet2R)

getwd()

# sddb data
workingDir <- "../sklop3.physionet.data/sddb/"
sddb_data <- Import_physionet_HR(workingDir = workingDir)
str(sddb_data)
save(sddb_data, file = "./physionet_viewer/data/sddb_data.Rdata")

# nsrdb data
workingDir <- "../sklop3.physionet.data/nsrdb/"
nsrdb_data <- Import_physionet_HR(workingDir = workingDir)
str(nsrdb_data)
save(nsrdb_data, file = "./physionet_viewer/data/nsrdb_data.Rdata")
detach("package:physionet2R", unload = TRUE)
library(physionet2R)

# sddb data
workingDir <- "../sklop3.physionet.data/sddb/"
sddb_data <- Import_physionet_HR(workingDir = workingDir)

str(sddb_data)

active_data <- sddb_data
save(active_data, file = "./physionet_viewer/data/sddb_data.Rdata")
names(active_data)

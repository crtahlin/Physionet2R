detach("package:physionet2R", unload = TRUE)
library(physionet2R)

# sddb data
workingDir <- "../sklop3.physionet.data/sddb/"
sddb_data <- ImportHRConstantInterval(workingDir = workingDir, fileSuffix = ".unaudited_HR_constint.txt")

str(sddb_data)

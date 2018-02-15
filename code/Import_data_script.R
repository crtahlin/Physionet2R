# imports data for all physionet databases that are considered applicaple
# saves the data in a subfolder of the physionet viewer

detach("package:physionet2R", unload = TRUE)
library(physionet2R)

getwd()

# afdb data
workingDir <- "../sklop3.physionet.data/afdb/"
afdb_data <- Import_physionet_HR(workingDir = workingDir, fileSuffix_HR_constint = ".qrs_HR_constint.txt", fileSuffix_annotations = ".atr_annotations.txt")
str(afdb_data)
save(afdb_data, file = "./physionet_viewer/data/afdb_data.Rdata")

# chf2db data
workingDir <- "../sklop3.physionet.data/chf2db/"
chf2db_data <- Import_physionet_HR(workingDir = workingDir, fileSuffix_HR_constint = ".ecg_HR_constint.txt", fileSuffix_annotations = ".ecg_annotations.txt")
str(chf2db_data)
save(chf2db_data, file = "./physionet_viewer/data/chf2db_data.Rdata")

# chfdb data
workingDir <- "../sklop3.physionet.data/chfdb/"
chfdb_data <- Import_physionet_HR(workingDir = workingDir, fileSuffix_HR_constint = ".ecg_HR_constint.txt", fileSuffix_annotations = ".ecg_annotations.txt")
str(chfdb_data)
save(chfdb_data, file = "./physionet_viewer/data/chfdb_data.Rdata")

# cudb data
workingDir <- "../sklop3.physionet.data/cudb/"
cudb_data <- Import_physionet_HR(workingDir = workingDir, fileSuffix_HR_constint = ".atr_HR_constint.txt", fileSuffix_annotations = ".atr_annotations.txt")
str(cudb_data)
save(cudb_data, file = "./physionet_viewer/data/cudb_data.Rdata")

# ltafdb data
workingDir <- "../sklop3.physionet.data/ltafdb/"
# NOTE: deleted rows containing string " Aux", it seems as of some kind of bug
ltafdb_data <- Import_physionet_HR(workingDir = workingDir, fileSuffix_HR_constint = ".qrs_HR_constint.txt", fileSuffix_annotations = ".atr_annotations.txt")
str(ltafdb_data)
save(ltafdb_data, file = "./physionet_viewer/data/ltafdb_data.Rdata")

# mitdb data
workingDir <- "../sklop3.physionet.data/mitdb/"
mitdb_data <- Import_physionet_HR(workingDir = workingDir, fileSuffix_HR_constint = ".atr_HR_constint.txt", fileSuffix_annotations = ".atr_annotations.txt")
str(mitdb_data)
save(mitdb_data, file = "./physionet_viewer/data/mitdb_data.Rdata")

# nsr2db data
workingDir <- "../sklop3.physionet.data/nsr2db/"
nsr2db_data <- Import_physionet_HR(workingDir = workingDir, fileSuffix_HR_constint = ".ecg_HR_constint.txt", fileSuffix_annotations = ".ecg_annotations.txt")
str(nsr2db_data)
save(nsr2db_data, file = "./physionet_viewer/data/nsr2db_data.Rdata")

# nsrdb data
workingDir <- "../sklop3.physionet.data/nsrdb/"
nsrdb_data <- Import_physionet_HR(workingDir = workingDir, fileSuffix_HR_constint = ".atr_HR_constint.txt", fileSuffix_annotations = ".atr_annotations.txt")
str(nsrdb_data)
save(nsrdb_data, file = "./physionet_viewer/data/nsrdb_data.Rdata")

# sddb data
workingDir <- "../sklop3.physionet.data/sddb/"
sddb_data <- Import_physionet_HR(workingDir = workingDir, fileSuffix_HR_constint = ".ari_HR_constint.txt", fileSuffix_annotations = ".ari_annotations.txt")
str(sddb_data)
save(sddb_data, file = "./physionet_viewer/data/sddb_data.Rdata")

# svdb data
workingDir <- "../sklop3.physionet.data/svdb/"
svdb_data <- Import_physionet_HR(workingDir = workingDir, fileSuffix_HR_constint = ".atr_HR_constint.txt", fileSuffix_annotations = ".atr_annotations.txt")
str(svdb_data)
save(svdb_data, file = "./physionet_viewer/data/svdb_data.Rdata")


# szdb data
workingDir <- "../sklop3.physionet.data/szdb/"
szdb_data <- Import_physionet_HR(workingDir = workingDir, fileSuffix_HR_constint = ".ari_HR_constint.txt", fileSuffix_annotations = ".ari_annotations.txt")
str(szdb_data)
save(szdb_data, file = "./physionet_viewer/data/szdb_data.Rdata")











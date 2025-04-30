# On télécharge les packages nécessaires
install.packages(c("parallelMap", "clustMixType", "ggplot2", "tibble", "mice", "rpart", "fossil", "gtools"))

# On les charge dans la session
library(parallelMap)
library(clustMixType)
library(ggplot2)
library(tibble)
library(mice)
library(rpart)
library(fossil)
library(gtools)

# On importe les données 
dat_complete <- readRDS(url("http://sz.hochschule-stralsund.de/jclassif/repStudy_dat_complete.rds"))
dat_incomplete <- readRDS(url("http://sz.hochschule-stralsund.de/jclassif/repStudy_dat_incomplete.rds"))

# On exécute le code principal
source("C:/Users/vctrl/Desktop/ENSAE 2024-2025/S2/Modélisation/functions_clustering.R")
source("C:/Users/vctrl/Desktop/ENSAE 2024-2025/S2/Modélisation/functions_evaluation.R")
 



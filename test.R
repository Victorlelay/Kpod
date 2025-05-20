df<-readRDS("/home/onyxia/Kpod/repStudy_trial_design.rds")
colnames(df)
# Install if needed
install.packages("clusterMI")
install.packages("clustMixType")

devtools::install_github("https://github.com/ahaeusser/clusterMI")


# Load the library
library(clustMixType)

# Load the RDS file
data_list <- readRDS("/home/onyxia/Kpod/output_test.rds")



# Installer les packages nécessaires (si pas déjà installés)
if (!require("mice")) install.packages("mice")
if (!require("clustMixType")) install.packages("clustMixType")
if (!require("dplyr")) install.packages("dplyr")
if (!require("modeest")) install.packages("modeest")  # pour le vote majoritaire

# Charger les bibliothèques
library(mice)
library(clustMixType)
library(dplyr)
library(modeest)

# Charger vos données
df <- readRDS("/home/onyxia/Kpod/repStudy_trial_design.rds")
# Prérequis
library(mice)
library(clustMixType)
library(modeest)

# On suppose que tu as déjà chargé les simulations comme ceci :
# data_list <- readRDS("/home/onyxia/Kpod/output_test.rds")
# filtered_data <- ... # MCAR/MAR uniquement, comme tu l'as déjà filtré

# Appliquer le pipeline à chaque simulation
results <- lapply(filtered_data, function(sim) {
  # Identifier le vrai jeu de données (c'est celui avec les données manquantes)
  # Souvent c'est sim[[2]] ou sim[["incomplete_df"]], selon la structure
  # → Tu peux inspecter avec str(sim)
  
if (!is.data.frame(df)) return(NULL)

  # Imputation multiple
  imp <- mice(df, m = 5, maxit = 5, seed = 123)

  # Appliquer k-prototypes à chaque imputation
  k_results <- lapply(1:5, function(i) {
    df_imp <- complete(imp, i)
    kproto(df_imp, k = 4)  # tu peux faire sim[[1]][[1]]$nC au lieu de 2
  })

  # Extraire les clusters
  clusts <- sapply(k_results, function(res) res$cluster)

  # Vote majoritaire
  majority_vote <- apply(clusts, 1, mfv)

  # Ajouter au jeu de données imputé
  df_with_clusters <- complete(imp, 1)
  df_with_clusters$cluster_final <- majority_vote

  # Retourner le data.frame enrichi
  return(df_with_clusters)
})


# Exemple : afficher les clusters consensus de la première simulation
head(results[[1]]))


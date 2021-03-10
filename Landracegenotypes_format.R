#Set CRAN repository 
r = getOption("repos")
r["CRAN"] = "http://cran.us.r-project.org"
options(repos = r)


install.packages("dplyr")
library(dplyr)


install.packages("data.table")
library(data.table)


genotypes<- fread("genotypes.txt")
names(genotypes)<- c("An_ID", "Genotypes")

An_ID<- pull(genotypes, An_ID)
Genotypes<- pull(genotypes, Genotypes)

An_ID<- as.factor(as.character(An_ID))
An_ID<- as.numeric(as.factor(An_ID))
genotypes<- mutate(genotypes, An_ID)

chip<- 1 
SNP_num<- 49991

genotypes<- select(genotypes,"Genotypes")

genotypes<- mutate(genotypes, chip)
genotypes<- mutate(genotypes, SNP_num)
genotypes<- mutate(genotypes, An_ID)

genotypes<- select(genotypes, "An_ID", "chip", "SNP_num")


genotypes<- mutate(genotypes, Genotypes) 

genotypes<- select(genotypes, "An_ID", "chip", "SNP_num", "Genotypes")
genotypes$Genotypes<- strsplit(genotypes$Genotypes, split=NULL, fixed=FALSE, perl=FALSE, useBytes=FALSE) 

names(genotypes)<- c("Animal_ID", "chip", "SNP_num", "Genotypes")


Genotypes<- genotypes$Genotypes 

for(i in 1:length(Genotypes)){
  Genotypes[[i]] <- Genotypes[[i]][ordered_idx]
}


Genotypes_new<- Genotypes 
genotypes<- mutate(genotypes,Genotypes_new)
genotypes<- select(genotypes,"Animal_ID", "chip", "SNP_num", "Genotypes_new")
names(genotypes)<- c("Animal_ID", "chip", "SNP_num", "Genotypes")

fwrite(genotypes, file = "Landracegenotypes.txt", append = FALSE, quote = FALSE,
  sep = "")


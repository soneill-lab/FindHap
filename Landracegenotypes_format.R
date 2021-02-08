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


Genotypes<- strsplit(Genotypes, split=NULL, fixed=FALSE, perl=FALSE, useBytes=FALSE) 

genotypes<- mutate(genotypes, Genotypes) 

genotypes<- as.character(genotypes$Genotypes) 
write.table(genotypes, file= "Landracegenotypes.txt", append=FALSE, quote=FALSE, sep=" ", row.names=FALSE, col.names=TRUE)


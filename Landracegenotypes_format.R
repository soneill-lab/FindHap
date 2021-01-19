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


chip<- 1 
SNP_num<- 5000


genotypes<- mutate(genotypes, chip)
genotypes<- mutate(genotypes, SNP_num)


genotypes<- select(genotypes, "An_ID", "chip", "SNP_num", "Genotypes")


write.table(genotypes, file= "Landracegenotypes.txt", append=FALSE, sep=" ", row.names=FALSE, col.names=TRUE)


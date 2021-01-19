install.packages("dplyr")
library(dplyr)
install.packages("data.table")
library(data.table)


Ygenotypes<-fread("genotypeYorkshire.txt)
names(Ygenotypes)<- c("An_ID", "Genotypes")


An_ID<- pull(Ygenotypes, An_ID)
Genotypes<- pull(Ygenotypes, Genotypes)


chip<- 1 
SNP_num<- 5000


Ygenotypes<- mutate(Ygenotypes, chip1)
Ygenotypes<- mutate(Ygenotypes, SNP_num)


Ygenotypes<- select(Ygenotypes, "AN_ID", "chip", "SNP_num", "Genotypes")


write.table(Ygenotypes, file= "Yorkshiregenotypes.txt", append=FALSE, sep=" ", row.names=FALSE, col.names=TRUE) 

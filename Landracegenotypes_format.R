
library(dplyr)


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
  # added by Jiang
  # ordered_idx from chromosome.data
  Genotypes[[i]] <- Genotypes[[i]][ordered_idx]
  Genotypes[[i]] <- paste0(Genotypes[[i]], collapse="")
}

Genotypes_new<- Genotypes 
genotypes<- mutate(genotypes,Genotypes_new)
genotypes<- select(genotypes,"Animal_ID", "chip", "SNP_num", "Genotypes_new")
names(genotypes)<- c("Animal_ID", "chip", "SNP_num", "Genotypes")

genotypes$Animal_ID<- (genotypes$Animal_ID + 10000000)

# Added by Jiang
# Pad a String with Whitespace
library(stringr)
genotypes$Animal_ID = str_pad(genotypes$Animal_ID, width = 10, side = "left")
genotypes$chip = str_pad(genotypes$chip, width = 9, side = "left")
genotypes$SNP_num = str_pad(genotypes$SNP_num, width = 9, side = "left")

fwrite(genotypes, file = "Landracegenotypes.txt", append = FALSE, quote = FALSE, sep = " ", col.names=FALSE)


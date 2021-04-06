library(dplyr)


library(data.table)


genotypes<- fread("genotypes.txt")
names(genotypes)<- c("An_ID", "Genotypes")

genotypes_Animal_ID<- genotypes$An_ID
remove_genotypes_idx<- which(genotypes_Animal_ID%in% Animal_ID_ped==FALSE)

genotypes_Animal_ID<- genotypes_Animal_ID[- Ygenotype_remove_idx] 
genotypes<- genotypes[-c(Ygenotype_remove_idx),]

ped= data.frame(numeric= c(Animal_ID_ped_char), character=c(Animal_ID_ped_num))
gen= c(genotypes_Animal_ID_char)

h= hash(ped$character, ped$numeric)
genotypes_numeric_idx<- values(h, keys=gen)

genotypes<- mutate(genotypes, genotypes_numeric_idx)


Genotypes<- pull(genotypes, Genotypes)



chip<- 1 
SNP_num<- 49977

genotypes<- select(genotypes,"Genotypes")

genotypes<- mutate(genotypes, chip)
genotypes<- mutate(genotypes, SNP_num)
genotypes<-mutate(genotypes, genotypes_numeric_idx)


genotypes<- select(genotypes, "genotypes_numeric_idx", "chip", "SNP_num")


genotypes<- mutate(genotypes, Genotypes) 

genotypes<- select(genotypes, "genotypes_numeric_idx", "chip", "SNP_num", "Genotypes")
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
genotypes<- select(genotypes, "Animal_ID", "chip", "SNP_num", "Genotypes_new")
names(genotypes)<- c("Animal_ID", "chip", "SNP_num", "Genotypes")



# Added by Jiang
# Pad a String with Whitespace
library(stringr)
genotypes$Animal_ID = str_pad(genotypes$Animal_ID, width = 10)
genotypes$chip = str_pad(genotypes$chip, width = 9)
genotypes$SNP_num = str_pad(genotypes$SNP_num, width = 9)


fwrite(genotypes, file = "Yorkshiregenotypes.txt", append = FALSE, quote = FALSE, sep = " ", sep2 = c("",",",""), col.names=FALSE)

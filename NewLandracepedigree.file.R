#FindHap is used to impute missing genotypes in the genotype files for Landrace and Yorkshire swine breeds 
#Before running FindHap, we must make sure that our data formats align appropriately using R. 

#Landrace Pedigree File file format conversion

#Set CRAN repository 
r = getOption("repos")
r["CRAN"] = "http://cran.us.r-project.org"
options(repos = r)
#Install dplyr package
install.packages("dplyr")

#Routine start
library(dplyr)

        
#Landrace Pedigree file must be ordered in ascending order of birthday; oldest to youngest animal;
pedigree.file<- read.table("pedigree.file") 

#Rename columns appropriately with:
colnames(pedigree.file)<- c("Animal_ID", "Sire", "Dam", "Birthdate", "Sex") 
# names are based on format provided in README document pertaining to the swine data files 

#Convert 0,1,2 to F,M F respectively 
Sex<- pull(pedigree.file, Sex)

#Must change to factor and assign levels accordingly 
Sex<- as.factor(as.integer(Sex))
levels(Sex)= c("0","1","2")
levels(Sex)<- c("F", "M", "F")

#Order the Landrace Pedigree file from oldest animal to youngest animal: 
pedigree.file<- pedigree.file[order(pedigree.file$Birthdate),]
pedigree.file$Birthdate<- paste(pedigree.file$Birthdate,"01", sep="")

#Reorder columns in format that corresponds to findhap.f90 
pedigree.file<- select(pedigree.file, "Animal_ID", "Sire", "Dam", "Birthdate")
pedigree.file<- mutate(pedigree.file, Sex)
pedigree.file<- select(pedigree.file, "Sex", "Animal_ID", "Sire", "Dam", "Birthdate")


numberify <- function(pedigree) {
  ped_key <- with(pedigree, unique(c(as.character(Dam), as.character(Sire), as.character(Animal_ID))))
  numeric_pedigree <- pedigree %>%
    mutate(Animal_ID = as.integer(factor(Animal_ID, levels = ped_key)),
           Dam = as.integer(factor(Dam, levels = ped_key)),
           Sire = as.integer(factor(Sire, levels = ped_key)))

return(list(ped = numeric_pedigree, key = ped_key))
}

Landracepedigree.file <- numberify(pedigree.file)

Landracepedigree.file<- Landracepedigree.file$ped


Landracepedigree.file$Animal_ID<- (Landracepedigree.file$Animal_ID + 10000000)

#Must add the Animal_Num and the Animal_Name columns, both equal to Animal_ID column 
Animal_Num<- Landracepedigree.file$Animal_ID
Animal_Name<- Landracepedigree.file$Animal_ID

Landracepedigree.file<- cbind(Landracepedigree.file, Animal_Num= Animal_Num)
Landracepedigree.file<- cbind(Landracepedigree.file, Animal_Name= Animal_Name)

Landracepedigree.file$Sire[Landracepedigree.file$Sire==1]<- 0
Landracepedigree.file$Dam[Landracepedigree.file$Dam==1]<- 0


Landracepedigree.file$Sire<- (Landracepedigree.file$Sire + 10000000)
Landracepedigree.file$Dam<- (Landracepedigree.file$Dam + 10000000)

Landracepedigree.file<- format(Landracepedigree.file, scientific = FALSE)

Landracepedigree.file$Sire[Landracepedigree.file$Sire==10000000]<- 0
Landracepedigree.file$Dam[Landracepedigree.file$Dam==10000000]<- 0
        
#Rearrange columns into proper Findhap order 
Landracepedigree.file<- select(Landracepedigree.file,"Sex", "Animal_Num", "Sire", "Dam", "Birthdate", "Animal_ID", "Animal_Name")

write.table(Landracepedigree.file, file= "Landracepedigree.txt", append=FALSE, quote=FALSE, sep= " ", row.names= FALSE, col.names= FALSE)

#Added by Jiang
#Animal IDs will be used for processing genotypes.txt. 
Landracepedigree.file$Animal_ID




          

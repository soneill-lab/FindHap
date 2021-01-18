#FindHap is used to impute missing genotypes in the genotype files for Landrace and Yorkshire swine breeds 
#Before running FindHap, we must make sure that our data formats align appropriately using R. 

#Landrace Pedigree File file format conversion

#Set CRAN repository 
r = getOption("repos")
r["CRAN"] = "http://cran.us.r-project.org"
options(repos = r)

#Install dplyr package
install.packages("dplyr")
library(dplyr)

        
#Landrace Pedigree file must be ordered in ascending order of birthday; oldest to youngest animal;
Landracepedigree.file<- read.table("pedigree.file") 

#Check names of columns with: 
colnames(Landracepedigree.file)

#Rename columns appropriately with:
colnames(Landracepedigree.file)<- c("Animal_ID", "Sire", "Dam", "Birthdate", "Sex") 
# names are based on format provided in README document pertaining to the swine data files 

#Order the Landrace Pedigree file from oldest animal to youngest animal: 
Landracepedigree.file<- Landracepedigree.file[order(Landracepedigree.file$Birthdate),]


#Add on two duplicate columns of Animal_ID to serve as Animal# and Animal_Name
Animal_ID<- pull(Landracepedigree.file, Animal_ID)
y<- Animal_ID
z<- Animal_ID
Landracepedigree.file<- mutate(Landracepedigree.file, y)
Landracepedigree.file<- mutate(Landracepedigree.file, z)

#Reorder columns in format that corresponds to findhap.f90 
Landracepedigree.file<- select(Landracepedigree.file, "Sex", "Animal_ID", "Sire", "Dam", "Birthdate", "y","z")

#Rename columns appropriately according to acceptable data format:
colnames(Landracepedigree.file) <- c("Sex", "Animal#", "Sire", "Dam", "Birthdate", "Animal_ID", "Animal_Name")

#Convert Animal#, Animal_ID, and Animal_Name into numeric variable
Animal_ID<- as.factor(as.character(Animal_ID))
Animal_ID<- as.numeric(as.factor(Animal_ID))

#Remove current character columns to replace with new numeric columns w "select" command
Landracepedigree.file<- select(Landracepedigree.file, "Sex", "Sire", "Dam", "Birthdate")

#Recreate the Animal_ID y and z variable with the new numeric variable with: 
y<- Animal_ID
z<- Animal_ID

Landracepedigree.file<- mutate(Landracepedigree.file, Animal_ID)
Landracepedigree.file<- mutate(Landracepedigree.file, y) 
Landracepedigree.file<- mutate(Landracepedigree.file, z)

colnames(Landracepedigree.file)<- c("Sex", "Sire", "Dam", "Birthdate", "Animal_ID", "Animal#", "Animal_Name")

#Convert Sire and Dam names from character to numeric in same manner 
Sire<- pull(Landracepedigree.file, Sire)
Dam<- pull(Landracepedigree.file, Dam) 

Sire<- as.factor(as.character(Sire))
Dam<- as.factor(as.character(Dam))

Sire<- as.numeric(as.factor(Sire))
Dam<- as.numeric(as.factor(Dam))

#Remove Sire and Dam character columns and replace with numeric columns 
Landracepedigree.file<- select(Landracepedigree.file, "Sex", "Animal#", "Birthdate", "Animal_ID", "Animal_Name")

Landracepedigree.file<- mutate(Landracepedigree.file, Sire)
Landracepedigree.file<- mutate(Landracepedigree.file, Dam)

Landracepedigree.file<- select(Landracepedigree.file, "Sex","Animal#", "Sire", "Dam", "Birthdate", "Animal_ID", "Animal_Name")

#Remove and Replace Animal# column with numeric 

Landracepedigree.file<- select(Landracepedigree.file, "Sex","Sire", "Dam", "Birthdate", "Animal_ID", "Animal_Name")

Animal_Num<- Animal_ID 
Landracepedigree.file<- mutate(Landracepedigree.file, Animal_Num)
                               
Landracepedigree.file<- select(Landracepedigree.file, "Sex", "Animal_Num", "Sire", "Dam", "Birthdate", "Animal_ID", "Animal_Name") 

#Convert 0,1,2 to F,M F respectively 
Sex<- pull(Landracepedigree.file, Sex)

#Must change to factor and assign levels accordingly 
Sex<- as.factor(as.integer(Sex))
levels(Sex)= c("0","1","2")
levels(Sex)<- c("F", "M", "F")

#Remove existing Sex column and replace with factored version 
Landracepedigree.file<- select(Landracepedigree.file, "Animal_Num", "Sire", "Dam", "Birthdate", "Animal_ID", "Animal_Name")
Landracepedigree.file<- mutate(Landracepedigree.file, Sex)
Landracepedigree.file<- select(Landracepedigree.file, "Sex", "Animal_Num", "Sire", "Dam", "Birthdate", "Animal_ID", "Animal_Name")
    

write.table(Landracepedigree.file, file= "Landracepedigree.txt", append=FALSE, quote=FALSE, sep= " ", row.names= FALSE, col.names= TRUE)

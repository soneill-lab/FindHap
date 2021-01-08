#Establish .map file as chromosome data variable 
chromosome.data<- read.table("chromosome.data")

#Specify column names 
colnames(chromosome.data)<- c("chrome", "SNPname", "location")

#Sort position and chromosome number in ascending order 
list(chromosome.data, sort("location"))
list(chromosome.data, sort("chrome"))

#install dplyr package 
install.packages("dplyr")
library(dplyr)

#Rearrange order of columns to appropriate format 
chromosome.data<- select(chromosome.data, "SNPname", "chrome", "location")

#Rename SNPname column to "SNP(number)"
SNPname<- pull(chromosome.data, SNPName)
SNPname<- as.factor(SNPname)
SNPname<- as.numeric(as.factor(SNPname))

#Remove current character SNPname column to make room to add the numeric SNPname column
chromosome.data<- select(chromosome.data, "chrome", "Overall", "location", "chip1")

#Add numeric SNPname column
chromosome.data<- mutate(chromosome.data, SNPname)

#Add within, overall, and Chip# column 

#Create chip1 as a variable 
chip1<- 1 

#Add chip1 column 
chromosome.data<- mutate(chromosome.data, chip1)

#Create overall as a variable 
Overall<- rownames(chromosome.data)

#Add overall column
chromosome.data<- mutate(chromosome.data, Overall)

#Rearrange order of columns again 
chromosome.data<- select(chromosome.data, "SNPname", "chrome", "within", "Overall", "location", "chip1")

#Remove column "within" and replace with proper column; Create within as a variable equal to Overall column 
within<- Overall 
chromosome.data<- select(chromosome.data, "SNPname", "chrome","Overall", "location", "chip1")
chromosome.data<- mutate(chromosome.data, within) 
chromosome.data<- select(chromosome.data, "SNPname", "chrome", "within", "Overall", "location", "chip1")





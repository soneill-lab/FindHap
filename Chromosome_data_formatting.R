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
mutate(chromosome.data, SNPname)

#Add within, overall, and Chip# column 
#Adding within column first 
chromosome.data<- mutate(chromosome.data, within=Overall)

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



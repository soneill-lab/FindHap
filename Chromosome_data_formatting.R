#install dplyr package 
install.packages("dplyr")
library(dplyr)

#Establish .map file as chromosome data variable 
chromosome.data<- read.table("chromosome.data")

#Specify column names 
colnames(chromosome.data)<- c("chrome", "SNPname", "location")

#Sort position and chromosome number in ascending order 
list(chromosome.data, sort("location"))
list(chromosome.data, sort("chrome"))



#Rearrange order of columns to appropriate format 
chromosome.data<- select(chromosome.data, "SNPname", "chrome", "location")

#Rename SNPname column to "SNP(number)"
SNPname<- pull(chromosome.data, SNPname)
SNPname<- as.factor(SNPname)
SNPname<- as.numeric(as.factor(SNPname))

#Remove current character SNPname column to make room to add the numeric SNPname column
chromosome.data<- select(chromosome.data, "chrome", "location")

#Add numeric SNPname column
chromosome.data<- mutate(chromosome.data, SNPname)

#Create chip1 as a variable 
chip1<- 1 

#Add chip1 column 
chromosome.data<- mutate(chromosome.data, chip1)

#Create overall as a variable 
Overall<- rownames(chromosome.data)

#Add overall column
chromosome.data<- mutate(chromosome.data, Overall)

#Create "within" as a particular sequence of numbers that will change dependent on chrome # 
chromosome.data$within <- sequence(rle(chromosome.data$chrome)$lengths)

#Order columns appropriately
chromosome.data<- select(chromosome.data, "SNPname", "chrome", "within","Overall", "location", "chip1")

#Save file 
write.table(chromosome.data, file= chromosome.data, append=FALSE, quote=FALSE, sep=" ", row.names=FALSE, col.names=TRUE)






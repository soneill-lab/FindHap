#Set CRAN repository 
r = getOption("repos")
r["CRAN"] = "http://cran.us.r-project.org"
options(repos = r)

#install dplyr package 
install.packages("dplyr")
library(dplyr)

#Establish .map file as chromosome data variable 
chromosome.data<- read.table("chromosome.data")

#Specify column names 
colnames(chromosome.data)<- c("chrome", "SNPname", "location")

#Make "location" numeric 
location<- pull(chromosome.data, location)
location=as.numeric(location)

#Make chrome a variable
chrome<- chromosome.data$chrome

#Remove and add back proper location column
chromosome.data<- select(chromosome.data, "SNPname", "chrome")
chromosome.data<- mutate(chromosome.data, location)

#Sort position and chromosome number in ascending order
ordered_idx = order(chromosome.data[ ,"chrome"], chromosome.data[ ,"location"] )

#Added by Jiang
ordered_idx = ordered_idx[1:49977]

chromosome.data<- chromosome.data[ordered_idx,]

#Create overall as a variabl
#Edited by Jiang
overall<- (1:length(ordered_idx))

#Add overall column
chromosome.data<- mutate(chromosome.data, overall)                                   

#Alter SNPname column appropriately 
SNPname<- "Marker"
chromosome.data<- select(chromosome.data, "chrome", "location", "overall")
chromosome.data<- mutate(chromosome.data, SNPname)
chromosome.data<- select(chromosome.data, "SNPname", "chrome", "location", "overall")

SNPsequence<- 1:nrow(chromosome.data)
chromosome.data$SNPname<- paste(chromosome.data$SNPname,SNPsequence, sep="")
 


#Create chip1 as a variable 
chip1<- overall 
n_chips<- 1 
 
#Add chip1 column 
chromosome.data<- mutate(chromosome.data, chip1)
chromosome.data<- mutate(chromosome.data, n_chips)
 

#Create "within" as a particular sequence of numbers that will change dependent on chrome # 
chromosome.data$within <- sequence(rle(chromosome.data$chrome)$lengths)

#Order columns appropriately
chromosome.data<- select(chromosome.data, "SNPname", "chrome", "within","overall", "location", "n_chips", "chip1")

#Save file 
write.table(chromosome.data,file= "Landrace_chromosome.data",append=FALSE, quote=FALSE, sep=" ", row.names=FALSE, col.names=TRUE)



#Added by Jiang
# ordered_idx will be used for processing genotypes.txt.
ordered_idx


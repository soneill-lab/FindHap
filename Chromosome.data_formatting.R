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
chromosome.data<- chromosome.data[ order(chromosome.data[ ,"chrome"], chromosome.data[ ,"location"] ),]

#Create overall as a variabl
overall<- (1:49991)

#Add overall column
chromosome.data<- mutate(chromosome.data, overall)                                   
#Rearrange order of columns to appropriate format 
 
#Rename SNPname column to "SNP(number)"
SNPname<- pull(chromosome.data, SNPname)
SNPname<- as.factor(SNPname)
SNPname<- as.numeric(as.factor(SNPname))

#Remove current character SNPname column to make room to add the numeric SNPname column

chromosome.data<- select(chromosome.data, "chrome","location", "overall")
#Add numeric SNPname column
chromosome.data<- mutate(chromosome.data, SNPname)

#Create chip1 as a variable 
chip1<- 1 
n_chips<- 1 
 
#Add chip1 column 
chromosome.data<- mutate(chromosome.data, chip1)
chromosome.data<- mutate(chromosome.data, n_chips)
 

#Create "within" as a particular sequence of numbers that will change dependent on chrome # 
chromosome.data$within <- sequence(rle(chromosome.data$chrome)$lengths)

#Order columns appropriately
chromosome.data<- select(chromosome.data, "SNPname", "chrome", "within","overall", "location", "n_chips", "chip1")

#Save file 
write.table(chromosome.data,file= "chromosome.data2",append=FALSE, quote=FALSE, sep=" ", row.names=FALSE, col.names=TRUE)






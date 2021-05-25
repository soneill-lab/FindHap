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
#########################################################################################
#Make "location" numeric 
location<- pull(chromosome.data, location)
location=as.numeric(location)

#locate NA values 
which(is.na(location))

#Create index of NA values to modify in location column
modify_idx<- which(is.na(location))

#Obtain list of values given by modify_idx 
chromosome.data$location[modify_idx]

#Modify the chromosome.data$location index 
chromosome.data$location[modify_idx]<- c("7864132", "124569745", "19958367", "6730949", "41716843", "95890927", "31645297", "116633299", "142748807", "34964064", "56619202", "58737215", "172601926", "32309148", "150861922", "62238854", "16833521", "33400099", "134241213")

#Make chromosome.data location column numeric 
chromosome.data$location=as.numeric(chromosome.data$location)
########################################################################################

##The above code should make the location column numeric without soliciting any NA values 

#Make chrome a variable
chrome<- chromosome.data$chrome

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
chromosome.data<- select(chromosome.data, "SNPname", "chrome", "location", "overall")



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


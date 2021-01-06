#Will convert Yorkshire pedigree file in same way as Landrace 
Yorkshirepedigree.file<- read.table("pedigreeYorkshire.txt")

colnames(Yorkshirepedigree.file)<- c("Animal_ID", "Sire", "Dam", "Birthday", "Sex")

Yorkshirepedigree.file<- Yorkshirepedigree.file[order(x$Birthday),]
Yorkshirepedigree.file<- mutate(Yorkshirepedigree.file, y)
Yorkshirepedigree.file<- mutate(Yorkshirepedigree.file, z)
Yorkshirepedigree.file<- select(Yorkshirepedigree.file, "Sex", "Animal#", "Sire", "Dam", "Birthday", "y", "z")

colnames(Yorkshirepedigree.file) <- c("Sex", "Animal#", "Sire", "Dam", "Birthdate", "Animal_ID", "Animal_Name")

write.table(Yorkshirepedigree.file, file= "YorkshirePedigree.txt", append=FALSE, quote=FALSE, sep= " ", row.names= FALSE, col.names= TRUE)

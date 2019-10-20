#ID<-"RWS01"

singlevals<-as.data.frame(rbind(distancetoplane,
totalEClength,
TMtotalarea,
FPtotalarea,
CAtotalarea,
RWtotalarea,
totalcollength))
colnames(singlevals)<-ID
singlevals$measures<-paste(ID,rownames(singlevals), sep = "_")
write.csv(singlevals,paste(ID,"Singlevals summary.csv", sep = "_"))

#distancetoplane<-"NA"
#TMtotalarea<-"NA"

#fitTM
#planecoefficients
rownames(angles)<-paste(ID,"angles",make.names(rownames(angles), unique = TRUE),sep = "_")
rownames(TMcurve)<-paste(ID,"TMcurve",make.names(rownames(TMcurve), unique = TRUE),sep = "_")
rownames(FPcurve)<-paste(ID,"FPcurve",make.names(rownames(FPcurve), unique = TRUE),sep = "_")
rownames(CAcurve)<-paste(ID,"CAcurve",make.names(rownames(CAcurve), unique = TRUE),sep = "_")
rownames(ECpoints)<-paste(ID,"ECpoints",make.names(rownames(ECpoints), unique = TRUE),sep = "_")

rownames(CAcentroidsingle)<-paste(ID,"CAcentroidsingle",make.names(rownames(CAcentroidsingle), unique = TRUE),sep = "_")
rownames(RWcentroidsingle)<-paste(ID,"RWcentroidsingle",make.names(rownames(RWcentroidsingle), unique = TRUE),sep = "_")
rownames(FPcentroidsingle)<-paste(ID,"FPcentroidsingle",make.names(rownames(FPcentroidsingle), unique = TRUE),sep = "_")

allcoords<-rbind(TMcurve,ECpoints,FPcurve,CAcurve, CAcentroidsingle, RWcentroidsingle, FPcentroidsingle)
allcoords
TMcurve<-"NA"

write.csv(allcoords, paste(ID,"Coordinates summary.csv", sep = "_"))
write.csv(angles, paste(ID,"Angles summary.csv", sep = "_"))


library(Morpho)
library(geomorph)
library(rgl)

FPperimeter<-read.mpp(file.choose())#read landmarks from meshlab
#FPperimeter<-read.fcsv(file.choose())
FPcurve<-as.data.frame(digit.curves(start = FPperimeter[1,], curve = FPperimeter, nPoints = 17, closed = TRUE))#make equidistant points

#calculate 3D distance for perimeter
shiftedone<-rbind(FPcurve[2:dim(FPcurve)[1],],FPcurve[1,])# vector shifted by one to measure distance
curveDist<-(FPcurve-shiftedone)^2
totaldistFPcurve<-sqrt(curveDist[,1]+curveDist[,2]+curveDist[,3])
totaldistFPcurve<-as.data.frame(totaldistFPcurve)#final variable
remove(curveDist)
remove(shiftedone)
lines(totaldistFPcurve)
plot(totaldistFPcurve)
str(totaldistFPcurve)

#compute centroid
centroid<-as.data.frame(cbind(mean(FPcurve[,1]),mean(FPcurve[,2]),mean(FPcurve[,3])))#calculate centroid

#repeat centroid n x length of curve for euclidean distance measurements
centroid<-centroid[rep(seq_len(nrow(centroid)), each=dim(FPcurve)[1]),]
row.names(centroid)<-seq(1:dim(FPcurve)[1])# make row names integers

#calculate distance from each perimeter point to centroid
DisttoCentroid<-(FPcurve-centroid)^2
totaldisttoCentroid<-sqrt(DisttoCentroid[,1]+DisttoCentroid[,2]+DisttoCentroid[,3])
totaldisttoCentroid<-as.data.frame(totaldisttoCentroid) #final variable
remove(DisttoCentroid)
plot(totaldisttoCentroid)
str(totaldisttoCentroid)
length(totaldisttoCentroid)

#Shift "distance to centroid"by one element the to get other side of triangle
shiftdisttocentroid<-rbind(totaldisttoCentroid[2:length(totaldisttoCentroid),],totaldisttoCentroid[1,])
shiftdisttocentroid<-as.data.frame(shiftdisttocentroid)

#bind all together into one
lengths<-cbind(totaldistFPcurve,totaldisttoCentroid,totaldisttoCentroid)

#Heron's triangle formula:
#s<-(a+b+c)/2
#area<-sqrt(s*(s-a)*(s-b)*(s-c))
s<-(lengths[,1]+lengths[,2]+lengths[,3])/2
areaeachtriangle<-sqrt(s*(s-lengths[,1])*(s-lengths[,2])*(s-lengths[,3]))
areaeachtriangle<-as.data.frame(areaeachtriangle)
FPtotalarea<-sum(areaeachtriangle)
FPtotalarea

FPcentroidsingle<-as.data.frame(cbind(mean(FPcurve[,1]),mean(FPcurve[,2]),mean(FPcurve[,3])))#calculate centroid


#############################################################plotting
#insert centroid every other line for line plot:
# double all rows 
centroiddoubled <- FPcurve[rep(1:nrow(FPcurve),1,each=2),]
centroiddoubled
row.names(centroiddoubled)<- seq(1:38)
row.names(centroiddoubled)

# replace all dupliFPtes with blank cells
centroiddoubled[seq(2, dim(centroiddoubled)[1], by=2), ] <- centroid[1,]
centroiddoubled
centroideveryother<-as.data.frame(centroiddoubled)
#lines3d(centroideveryother[,1],centroideveryother[,2],centroideveryother[,3])

#addto original to 'every other' for correct plotting lineplot
#fullFP<-rbind(centroideveryother,FPcurve,FPcurve[1,])
#lines3d(fullFP[,1],fullFP[,2],fullFP[,3], col = "black")



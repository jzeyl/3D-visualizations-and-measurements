library(Morpho)
library(geomorph)
library(rgl)

RWperimeter<-read.mpp(file.choose())#read landmarks from meshlab
#RWperimeter<-read.fcsv(file.choose())
RWcurve<-as.data.frame(digit.curves(start = RWperimeter[1,], curve = RWperimeter, nPoints = 16, closed = TRUE))#make equidistant points

#calculate 3D distance for perimeter
shiftedone<-rbind(RWcurve[2:dim(RWcurve)[1],],RWcurve[1,])# vector shifted by one to measure distance
curveDist<-(RWcurve-shiftedone)^2
totaldistRWcurve<-sqrt(curveDist[,1]+curveDist[,2]+curveDist[,3])
totaldistRWcurve<-as.data.frame(totaldistRWcurve)#final variable
remove(curveDist)
remove(shiftedone)
lines(totaldistRWcurve)
plot(totaldistRWcurve)
str(totaldistRWcurve)

#compute centroid
centroid<-as.data.frame(cbind(mean(RWcurve[,1]),mean(RWcurve[,2]),mean(RWcurve[,3])))#calculate centroid

#repeat centroid n x length of curve for euclidean distance measurements
centroid<-centroid[rep(seq_len(nrow(centroid)), each=dim(RWcurve)[1]),]
row.names(centroid)<-seq(1:dim(RWcurve)[1])# make row names integers

#calculate distance from each perimeter point to centroid
DisttoCentroid<-(RWcurve-centroid)^2
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
lengths<-cbind(totaldistRWcurve,totaldisttoCentroid,totaldisttoCentroid)

#Heron's triangle formula:
#s<-(a+b+c)/2
#area<-sqrt(s*(s-a)*(s-b)*(s-c))
s<-(lengths[,1]+lengths[,2]+lengths[,3])/2
areaeachtriangle<-sqrt(s*(s-lengths[,1])*(s-lengths[,2])*(s-lengths[,3]))
areaeachtriangle<-as.data.frame(areaeachtriangle)
RWtotalarea<-sum(areaeachtriangle)
RWtotalarea

RWcentroidsingle<-as.data.frame(cbind(mean(RWcurve[,1]),mean(RWcurve[,2]),mean(RWcurve[,3])))#calculate centroid



#############################################################plotting
#insert centroid every other line for line plot:
# double all rows 
centroiddoubled <- RWcurve[rep(1:nrow(RWcurve),1,each=2),]
centroiddoubled
row.names(centroiddoubled)<- seq(1:38)
row.names(centroiddoubled)

# replace all duplicates with blank cells
centroiddoubled[seq(2, dim(centroiddoubled)[1], by=2), ] <- centroid[1,]
centroiddoubled
centroideveryother<-as.data.frame(centroiddoubled)
#lines3d(centroideveryother[,1],centroideveryother[,2],centroideveryother[,3])

#addto original to 'every other' for correct plotting lineplot
fullRW<-rbind(centroideveryother,RWcurve,RWcurve[1,])
lines3d(fullRW[,1],fullRW[,2],fullRW[,3], col = "green")


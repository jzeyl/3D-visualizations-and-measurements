#library(Morpho)
#library(geomorph)
#library(rgl)

CAperimeter<-read.mpp(file.choose())#read landmarks from meshlab
#CAperimeter<-read.fcsv(file.choose())
CAcurve<-as.data.frame(digit.curves(start = CAperimeter[1,], curve = CAperimeter, nPoints = 16, closed = TRUE))#make equidistant points

#calculate 3D distance for perimeter
shiftedone<-rbind(CAcurve[2:dim(CAcurve)[1],],CAcurve[1,])# vector shifted by one to measure distance
curveDist<-(CAcurve-shiftedone)^2
totaldistCAcurve<-sqrt(curveDist[,1]+curveDist[,2]+curveDist[,3])
totaldistCAcurve<-as.data.frame(totaldistCAcurve)#final variable
remove(curveDist)
remove(shiftedone)
lines(totaldistCAcurve)
plot(totaldistCAcurve)
str(totaldistCAcurve)

#compute centroid
centroid<-as.data.frame(cbind(mean(CAcurve[,1]),mean(CAcurve[,2]),mean(CAcurve[,3])))#calculate centroid

#repeat centroid n x length of curve for euclidean distance measurements
centroid<-centroid[rep(seq_len(nrow(centroid)), each=dim(CAcurve)[1]),]
row.names(centroid)<-seq(1:dim(CAcurve)[1])# make row names integers

#calculate distance from each perimeter point to centroid
DisttoCentroid<-(CAcurve-centroid)^2
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
lengths<-cbind(totaldistCAcurve,totaldisttoCentroid,totaldisttoCentroid)

#Heron's triangle formula:
#s<-(a+b+c)/2
#area<-sqrt(s*(s-a)*(s-b)*(s-c))
s<-(lengths[,1]+lengths[,2]+lengths[,3])/2
areaeachtriangle<-sqrt(s*(s-lengths[,1])*(s-lengths[,2])*(s-lengths[,3]))
areaeachtriangle<-as.data.frame(areaeachtriangle)
CAtotalarea<-sum(areaeachtriangle)
CAtotalarea

CAcentroidsingle<-as.data.frame(cbind(mean(CAcurve[,1]),mean(CAcurve[,2]),mean(CAcurve[,3])))#calculate centroid


#############################################################plotting
#insert centroid every other line for line plot:
# double all rows 
centroiddoubled <- CAcurve[rep(1:nrow(CAcurve),1,each=2),]
centroiddoubled
row.names(centroiddoubled)<- seq(1:38)
row.names(centroiddoubled)

# replace all duplicates with blank cells
centroiddoubled[seq(2, dim(centroiddoubled)[1], by=2), ] <- centroid[1,]
centroiddoubled
centroideveryother<-as.data.frame(centroiddoubled)
#lines3d(centroideveryother[,1],centroideveryother[,2],centroideveryother[,3])

#addto original to 'every other' for correct plotting lineplot
fullCA<-rbind(centroideveryother,CAcurve,CAcurve[1,])
lines3d(fullCA[,1],fullCA[,2],fullCA[,3], col = "green")


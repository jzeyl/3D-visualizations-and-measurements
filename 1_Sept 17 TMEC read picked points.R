library(Morpho)
library(geomorph)
library(rgl)


ID<-"Chicken-01-2019"

TMperimeter<-read.mpp(file.choose())#read landmarks from meshlab
TMperimeter<-read.fcsv(file.choose())
TMcurve<-as.data.frame(digit.curves(start = TMperimeter[1,], curve = TMperimeter, nPoints = 15, closed = TRUE))#make equidistant points
TMcurve

#ECpoints<-read.mpp(file.choose())#read landmarks from meshlab
ECpoints<-read.fcsv(file.choose())
ECpoints<-as.data.frame(ECpoints)

#TMcurve to EC tip line plot
#insert colummela tip every other line for line plot:
# double all rows 
TMcurvedoubled <- TMcurve[rep(1:nrow(TMcurve),1,each=2),]
TMcurvedoubled<-as.data.frame(TMcurvedoubled)
row.names(TMcurvedoubled)<-seq(1:34)

# replace all duplicates with columella tip point
TMcurvedoubled[seq(2, dim(TMcurvedoubled)[1], by=2), ] <- ECpoints[1,]
TMcurvedoubled
EStapTipeveryother<-as.data.frame(TMcurvedoubled)


#calculate 3D distance for perimeter
shiftedone<-rbind(TMcurve[2:dim(TMcurve)[1],],TMcurve[1,])# vector shifted by one to measure distance
curveDist<-(TMcurve-shiftedone)^2
totaldistTMcurve<-sqrt(curveDist[,1]+curveDist[,2]+curveDist[,3])
totaldistTMcurve<-as.data.frame(totaldistTMcurve)#final variable
remove(curveDist)
remove(shiftedone)

#make TMtip object
TMtipsingle<-ECpoints[1,]
Coltip<-ECpoints[4,]
TMtip<-ECpoints[1,]

#repeat centroid n x length of curve for euclidean distance measurements
TMtip<-TMtip[rep(seq_len(nrow(TMtip)), each=dim(TMcurve)[1]),]
row.names(TMtip)<-seq(1:dim(TMcurve)[1])# make row names integers

#calculate distance from each perimeter point to TMtip
DisttoTMtip<-(TMcurve-TMtip)^2
totaldisttoTMtip<-sqrt(DisttoTMtip[,1]+DisttoTMtip[,2]+DisttoTMtip[,3])
totaldisttoTMtip<-as.data.frame(totaldisttoTMtip) #final variable
remove(DisttoTMtip)

#Shift "distance to TMtip"by one element the to get other side of triangle
shiftdisttoTMtip<-rbind(totaldisttoTMtip[2:length(totaldisttoTMtip),],totaldisttoTMtip[1,])
shiftdisttoTMtip<-as.data.frame(shiftdisttoTMtip)

#bind all together into one
lengths<-cbind(totaldistTMcurve,totaldisttoTMtip,totaldisttoTMtip)

#Heron's triangle formula:
#s<-(a+b+c)/2
#area<-sqrt(s*(s-a)*(s-b)*(s-c))
s<-(lengths[,1]+lengths[,2]+lengths[,3])/2
areaeachtriangle<-sqrt(s*(s-lengths[,1])*(s-lengths[,2])*(s-lengths[,3]))
areaeachtriangle<-as.data.frame(areaeachtriangle)
TMtotalarea<-sum(areaeachtriangle)
TMtotalarea


#############################################################plotting
#insert colummela tip every other line for line plot:
# double all rows 
ECdoubled <- ECpoints[rep(1:nrow(ECpoints),1,each=2),]
ECdoubled<-as.data.frame(ECdoubled)
row.names(ECdoubled)<-seq(1:8)

# replace all duplicates with columella tip point
ECdoubled[seq(2, dim(ECdoubled)[1], by=2), ] <- ECpoints[4,]
ECdoubled
ColTipeveryother<-as.data.frame(ECdoubled)

#FINAL EC LINE PLOT:
#rgl.points(ECpoints[,1],ECpoints[,2],ECpoints[,3], color = "blue", size = 5)
#lines3d(ColTipeveryother[,1],ColTipeveryother[,2],ColTipeveryother[,3])


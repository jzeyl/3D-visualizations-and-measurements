library(rgl)

angle<-seq(from =0, to = 360,10)
x<-cos(angle)
y<-sin(angle)
z<-rep(0,length(angle))
circle3d<-data.frame(cbind(x,y,z))
lines3d(circle3d$x,circle3d$y,circle3d$z)

lines3d(umboeveryother$x,umboeveryother$y,umboeveryother$z)

# create umbo -------------------------------------------------------------
x<-0
y<-0
z<-1
umbo<-as.data.frame(cbind(x,y,z))

#TMcurve to EC tip line plot
#insert colummela tip every other line for line plot:
# double all rows 
circle3ddoubled <- circle3d[rep(1:nrow(circle3d),1,each=2),]
circle3ddoubled<-as.data.frame(circle3ddoubled)
row.names(circle3ddoubled)<-seq(1:74)

# replace all duplicates with columella tip point
circle3ddoubled[seq(2, dim(circle3ddoubled)[1], by=2), ] <- umbo[1,]
circle3ddoubled
umboeveryother<-as.data.frame(circle3ddoubled)


#calculate 3D distance for perimeter
shiftedone<-rbind(circle3d[2:dim(circle3d)[1],],circle3d[1,])# vector shifted by one to measure distance
curveDist<-(circle3d-shiftedone)^2
totaldistcircle3d<-sqrt(curveDist[,1]+curveDist[,2]+curveDist[,3])
totaldistcircle3d<-as.data.frame(totaldistcircle3d)#final variable
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



# double all rows 
circle <- RWcurve[rep(1:nrow(RWcurve),1,each=2),]
centroiddoubled

row.names(centroiddoubled)<- seq(1:38)
centroiddoubled[seq(2, nrow(centroiddoubled), by=2), 1:3]<- c(0,4,8)
str(centroiddoubled)




# plot --------------------------------------------------------------------
library("scatterplot3d") # load. #3d
plot3d <- scatterplot3d(circle3d, angle = 70, pch = 16)
plot3dwith_umbo <- scatterplot3d(withumbo, angle = 70, pch = 16)
library(Morpho)
library(geomorph)
library(rgl)

RWperimeter<-read.mpp(file.choose())#read landmarks from meshlab
RWcurve<-as.data.frame(digit.curves(start = RWperimeter[1,], curve = RWperimeter, nPoints = 16, closed = TRUE))#make equidistant points
remove(RWperimeter)
axes3d()
#3d scatterplot in rgl
rgl.points(RWperimeter[,1],RWperimeter[,2],RWperimeter[,3])
rgl.points(RWcurve[,1],RWcurve[,2],RWcurve[,3])
axes3d()

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
totalarea<-sum(areaeachtriangle)
totalarea



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
lines3d(centroideveryother[,1],centroideveryother[,2],centroideveryother[,3])

#addto original to 'every other' for correct plotting lineplot
full<-rbind(centroideveryother,RWcurve,RWcurve[1,])
lines3d(full[,1],full[,2],full[,3])

fullCA<-rbind(centroideveryother,RWcurve,RWcurve[1,])
lines3d(fullCA[,1],fullCA[,2],fullCA[,3])

axes3d()

plot3d(full)
rgl.points(RWcurve[,1],RWcurve[,2],RWcurve[,3])

#3d scatterplot in rgl
rgl.points(RWperimeter[,1],RWperimeter[,2],RWperimeter[,3])
rgl.points(RWcurve[,1],RWcurve[,2],RWcurve[,3])

#now plot
lines3d(centroideveryother[,1],centroideveryother[,2],centroideveryother[,3])
points3d(centroideveryother[,1],centroideveryother[,2],centroideveryother[,3])
triangles3d(addcentroid[,1],addcentroid[,2],addcentroid[,3])
#############################################################plotting


RWply<-read.ply(file.choose())# read in 3D model

read.fcsv()# read landmarks (fiducials from 3D slicer)
readLandmarks.csv() #import data from csv foles
read.csv.folder()#batch sample multiple csv files from a folder


# Compute the linear regression (y = ax + bz + d)
fit <- lm(y ~ x + z)
# predict values on regular xz grid
grid.lines = 26
x.pred <- seq(min(x), max(x), length.out = grid.lines)
z.pred <- seq(min(z), max(z), length.out = grid.lines)
xz <- expand.grid( x = x.pred, z = z.pred)
y.pred <- matrix(predict(fit, newdata = xz), 
                 nrow = grid.lines, ncol = grid.lines)
# Add regression surface
rgl.surface(x.pred, z.pred, y.pred, color = "steelblue", 
            alpha = 0.5, lit = FALSE)  
# Add grid lines
rgl.surface(x.pred, z.pred, y.pred, color = "black",
            alpha = 0.5, lit = FALSE, front = "lines", back = "lines")
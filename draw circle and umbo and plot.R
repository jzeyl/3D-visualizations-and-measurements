# draw circle -------------------------------------------------------------
angle<-seq(from =0, to = 360,10)
x<-cos(angle)
y<-sin(angle)
z<-rep(0,length(angle))
circle3d<-data.frame(cbind(x,y,z))


# create umbo -------------------------------------------------------------
x<-0
y<-0
z<-1
umbo<-as.data.frame(cbind(x,y,z))
withumbo<-data.frame(rbind(circle3d,umbo))

# plot --------------------------------------------------------------------
library("scatterplot3d") # load. #3d
plot3d <- scatterplot3d(circle3d, angle = 70, pch = 16)
plot3dwith_umbo <- scatterplot3d(withumbo, angle = 70, pch = 16)

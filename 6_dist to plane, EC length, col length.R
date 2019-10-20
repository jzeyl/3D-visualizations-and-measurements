# dist from point to line
#plane = Ax+By+Cz+D = 0
#d = abs(ax+by+cz+d)/sqrt((a^2)+(b^2)+(c^2))

#distance from point to line of best fit
distancetoplane<-abs((a*TMtipsingle[,1])+(b*TMtipsingle[,2])+(c*TMtipsingle[,3])+d)/sqrt(((a^2)+(b^2)+(c^2)))
distancetoplane

#EC length
EClength<-(TMtipsingle-Coltip)^2
totalEClength<-sqrt(EClength[,1]+EClength[,2]+EClength[,3])
totalEClength

#collength
FPcentroidsingle<-as.data.frame(cbind(mean(FPcurve[,1]),mean(FPcurve[,2]),mean(FPcurve[,3])))#calculate centroid
collength<-(Coltip-FPcentroidsingle)^2
totalcollength<-sqrt(collength[,1]+collength[,2]+collength[,3])
totalcollength

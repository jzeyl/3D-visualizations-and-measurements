open3d()
x <- rnorm(100)
y <- rnorm(100)
z <- 0.2*x - 0.3*y + rnorm(100, sd = 0.3)
fit <- lm(z ~ x + y)
plot3d(x, y, z, type = "s", col = "red", size = 1)

coefs <- coef(fit)
a <- coefs["x"]
b <- coefs["y"]
c <- -1
d <- coefs["(Intercept)"]
planes3d(a, b, c, d, alpha = 0.5)

fitTM<- lm(circle3d[,3]~circle3d[,1]+circle3d[,2])
fitTM

coefsTM<- coef(fitTM)
a <- coefsTM["circle3d[, 1]"]
b <- coefsTM["circle3d[, 2]"]
c <- -1
d <- coefsTM["(Intercept)"]
planes3d(a, b, c, d, alpha = 0.5, color = "blue")

fitFP<- lm(FPcurve[,3]~FPcurve[,1]+FPcurve[,2])
fitFP

coefsFP<- coef(fitFP)
a <- coefsFP["FPcurve[, 1]"]
b <- coefsFP["FPcurve[, 2]"]
c <- -1
d <- coefsFP["(Intercept)"]
planes3d(a, b, c, d, alpha = 0.5, color = "blue")

colmodel<-readSTL(file.choose())
str(colmodel)

# dist from point to line
#plane = Ax+By+Cz+D = 0
#d = abs(ax+by+cz+d)/sqrt((a^2)+(b^2)+(c^2))

a<-as.numeric(a)
b<-as.numeric(b)
c<-as.numeric(c)
d<-as.numeric(d)

#distance from point to line of best fit
str(TMtipsingle)
distancetoplane<-abs((a*TMtipsingle[,1])+(b*TMtipsingle[,2])+(c*TMtipsingle[,3])+d)/sqrt(((a^2)+(b^2)+(c^2)))
distancetoplane
str(distancetoplain)
str(a)

#EC length
EClength<-(TMtipsingle-Coltip)^2
totalEClength<-sqrt(EClength[,1]+EClength[,2]+EClength[,3])
totalEClength

#collength
FPcentroidsingle<-as.data.frame(cbind(mean(FPcurve[,1]),mean(FPcurve[,2]),mean(FPcurve[,3])))#calculate centroid
collength<-(Coltip-FPcentroid)^2
totalcollength<-sqrt(collength[,1]+collength[,2]+collength[,3])

allvars<-as.data.frame(rbind(RWtotalarea,CAtotalarea,TMtotalarea,FPtotalarea,totalEClength,distancetoplane))
write.csv(allvars,"GF-02-2019.csv")
getwd()
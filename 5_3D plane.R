#open3d()
#x <- rnorm(100)
#y <- rnorm(100)
#z <- 0.2*x - 0.3*y + rnorm(100, sd = 0.3)
#fit <- lm(z ~ x + y)
#plot3d(x, y, z, type = "s", col = "red", size = 1)

#coefs <- coef(fit)
#a <- coefs["x"]
#b <- coefs["y"]
#c <- -1
#d <- coefs["(Intercept)"]
#planes3d(a, b, c, d, alpha = 0.5)

fitTM<- lm(TMcurve[,3]~TMcurve[,1]+TMcurve[,2])
fitTM

coefsTM<- coef(fitTM)
a <- coefsTM["TMcurve[, 1]"]
b <- coefsTM["TMcurve[, 2]"]
c <- -1
d <- coefsTM["(Intercept)"]
planes3d(a, b, c, d, alpha = 0.5, color = "blue")

rgl.points(TMcurve[,1],TMcurve[,2],predict(fitTM), color = "black", size = 5)
rgl.points(TMcurve[,1],TMcurve[,2],TMcurve[3,], color = "black", size = 5)



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





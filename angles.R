linedirections<-TMcurve-TMtip
colnames(linedirections)<-c("u1","u2","u3")
planecoefficents<-as.data.frame(cbind(a,b,c))
colnames(planecoefficents)<- c("A","B","C")
planecoefficientrepeated<-planecoefficents[rep(1:nrow(planecoefficents),1,each=nrow(linedirections)),]
planecoefficientrepeated
linesandplanes<-cbind(linedirections,planecoefficientrepeated)
rownames(linesandplanes)<-seq(1:nrow(linedirections))
linesandplanes

angles<- asin(abs((linesandplanes$A*linesandplanes$u1)+(linesandplanes$B*linesandplanes$u2)+(linesandplanes$C+linesandplanes$u3))/
                 (sqrt((linesandplanes$A^2)+(linesandplanes$B^2)+(linesandplanes$C^2))*sqrt((linesandplanes$u1^2)+(linesandplanes$u2^2)+(linesandplanes$u3^2)))

top<-abs((linesandplanes$A*linesandplanes$u1)+(linesandplanes$B*linesandplanes$u2)+(linesandplanes$C+linesandplanes$u3))
bottom<-sqrt((linesandplanes$A^2)+(linesandplanes$B^2)+(linesandplanes$C^2))*sqrt((linesandplanes$u1^2)+(linesandplanes$u2^2)+(linesandplanes$u3^2))
angles<-as.data.frame(asin(top/bottom)*180/pi)
summary(angles)
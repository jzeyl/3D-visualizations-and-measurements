linedirectionvector<-TMcurve-TMtip
colnames(linedirectionvector)<-c("u1","u2","u3")
planecoefficents<-as.data.frame(cbind(a,b,c))
colnames(planecoefficents)<- c("A","B","C")
planecoefficientrepeated<-planecoefficents[rep(1:nrow(planecoefficents),1,each=nrow(linedirectionvector)),]
planecoefficientrepeated
all<-cbind(linedirectionvector,planecoefficientrepeated)
rownames(all)<-seq(1:nrow(linedirectionvector))

top<-abs((all$A*all$u1)+(all$B*all$u2)+(all$C*all$u3))
bottom<-sqrt((all$A^2)+(all$B^2)+(all$C^2))*sqrt((all$u1^2)+(all$u2^2)+(all$u3^2))
angles<-as.data.frame(asin(top/bottom))*180/pi#convert from degrees to radians
summary(angles)
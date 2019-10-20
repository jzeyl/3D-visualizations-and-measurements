#plotting
fullperimeter<-rbind(TMcurve,TMcurve[1,])
lines3d(fullperimeter[,1],fullperimeter[,2],fullperimeter[,3], color = "red", lwd = 3)
lines3d(EStapTipeveryother[,1],EStapTipeveryother[,2],EStapTipeveryother[,3], color = "red", lwd = 3)
rgl.points(ECpoints[,1],ECpoints[,2],ECpoints[,3], color = "blue", size = 5)
#rgl.points(TMcurve[,1],TMcurve[,2],TMcurve[,3], color = "red", size = 5)
lines3d(ColTipeveryother[,1],ColTipeveryother[,2],ColTipeveryother[,3], color = "blue", lwd = 3)

colmodel<-readSTL(file.choose())
rgl.texts(TMtip[1,1], TMtip[1,2],TMtip[1,3],ID, col = "black", size = 10)
axes3d()
lines3d(fullCA[,1],fullCA[,2],fullCA[,3], col = "green", lwd = 3)
lines3d(fullFP[,1],fullFP[,2],fullFP[,3], col = "black", lwd = 3)
lines3d(fullRW[,1],fullRW[,2],fullRW[,3], col = "green", lwd = 3)

rgl.snapshot(paste(ID,".png",sep = ""),  top = TRUE )
rgl.snapshot(paste(ID,"_2.png",sep = ""),  top = TRUE )
rgl.snapshot(paste(ID,"_3.png",sep = ""),  top = TRUE )



col<-rbind(centroid[1,],ECpoints[4,])
lines3d(col[,1],col[,2],col[,3], col = "green", lwd = 3)

rgl.points(TMtip[,1],TMtip[,2],TMtip[,3], color = "blue", size = 5)

#3d sFPtterplot in rgl
rgl.points(FPperimeter[,1],FPperimeter[,2],FPperimeter[,3])
rgl.points(FPcurve[,1],FPcurve[,2],FPcurve[,3])
axes3d()
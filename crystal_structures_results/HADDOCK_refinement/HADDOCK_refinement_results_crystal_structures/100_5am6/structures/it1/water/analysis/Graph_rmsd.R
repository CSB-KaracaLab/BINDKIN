######################
### Load libraries ###
######################

library(gplots)

########################
### Command checking ###
########################

### Color definition
nb_clust=strtoi(commandArgs()[5])
if ( nb_clust > 10 ){
  colors=c('red','blue','magenta','orange','green3','darkblue','darkgreen','cyan2','darkcyan','purple',rep('black',nb_clust-10))
} else {
  colors=c('red','blue','magenta','orange','green3','darkblue','darkgreen','cyan2','darkcyan','purple')
}
Haddock_data=read.table(commandArgs()[3])

### Outliers removing
mean_HS=mean(Haddock_data[,2])
sd_HS=sd(Haddock_data[,2])
edit=0
for( i in 1:length(Haddock_data[,2] )){
  if ((Haddock_data[i,2]>(mean_HS)+(5*sd_HS)) || (Haddock_data[i,2]<(mean_HS-(5*sd_HS)))){
    Haddock_data_tmp=Haddock_data[-i,]
    edit=1
  }
}
if (edit==1){
  Haddock_data=Haddock_data_tmp
}

### Legend definition
leg=vector()
for (i in 1:nb_clust){
  leg=append(paste("Cluster",i), leg)
}
leg=rev(leg)

name=commandArgs()[4]
type=commandArgs()[2]

tmpmax=max(Haddock_data[,2])
tmpmin=min(Haddock_data[,2])
Ymin=tmpmin-0.05*(tmpmax-tmpmin)
Ymax=tmpmax+0.05*(tmpmax-tmpmin)

### Initializing of the postscript image + definition of parameters
postscript(name,width=40,height=24,pointsize=12)
par(tcl=-0.3, cex.axis=2, cex.lab=2, cex.main=3, xaxs="i", yaxs="i",font.axis=1,font.lab=1, xpd=TRUE,lwd=1.5, mar=c(6,6,4,9),bg="transparent")

### Plotting of structures according to the type of graphic

# Create a colored vector based on cluster number
colored = vector()
for( j in 1:length(Haddock_data[,10])){
    if(Haddock_data[j,10]>0){
        colored = c(colored, colors[Haddock_data[j,10]])
    }
    else{
        colored = c(colored, "white")
    }
}

### i-l-RMSD vs HS ###
if ( type == "ilrmsd" ) {
tmpmax=max(Haddock_data[,9])
Xmin=0-0.05*(tmpmax)
Xmax=tmpmax+0.05*(tmpmax)

plot(Haddock_data[,9],Haddock_data[,2],axes=F,main="HADDOCK score vs i-l-RMSD",xlab=NA,ylab=NA,xlim=range(Xmin,Xmax),ylim=range(Ymin,Ymax),pch=21,cex=1,bg=colored)
if ( nb_clust != 0 ) {
coor_center_irmsd=as.matrix(read.table("plotCI_ilrmsd.file"))
}
title(xlab=expression(paste("i-l-RMSD [",paste(ring(A),"]"),sep="")),line=4.5)
title(ylab="HADDOCK score [a.u.]",line=4)
}


### iRMSD vs HS ###
if ( type == "irmsd" ) {
tmpmax=max(Haddock_data[,3])
Xmin=0-0.05*(tmpmax)
Xmax=tmpmax+0.05*(tmpmax)

plot(Haddock_data[,3],Haddock_data[,2],axes=F,main="HADDOCK score vs i-RMSD",xlab=NA,ylab=NA,xlim=range(Xmin,Xmax),ylim=range(Ymin,Ymax),pch=21,cex=1,bg=colored)
if ( nb_clust != 0 ) {
coor_center_irmsd=as.matrix(read.table("plotCI_irmsd.file"))
}
title(xlab=expression(paste("i-RMSD [",paste(ring(A),"]"),sep="")),line=4.5)
title(ylab="HADDOCK score [a.u.]",line=4)
}

### lRMSD vs HS ###
if ( type == "lrmsd" ) {
tmpmax=max(Haddock_data[,4])
Xmin=0-0.05*(tmpmax)
Xmax=tmpmax+0.05*(tmpmax)

plot(Haddock_data[,4],Haddock_data[,2],axes=F,main="HADDOCK score vs l-RMSD",xlab=NA,ylab=NA,xlim=range(Xmin,Xmax),ylim=range(Ymin,Ymax),pch=21,cex=1,bg=colored)
if ( nb_clust != 0 ) {
coor_center_irmsd=as.matrix(read.table("plotCI_lrmsd.file"))
}
title(xlab=expression(paste("l-RMSD [",paste(ring(A),"]"),sep="")),line=4.5)
title(ylab="HADDOCK score [a.u.]",line=4)
}

### FNAT vs HS ###
if ( type == "fnat" ) {
tmpmax=max(Haddock_data[,5])
Xmin=0-0.05*(tmpmax)
Xmax=tmpmax+0.05*(tmpmax)

plot(Haddock_data[,5],Haddock_data[,2],axes=F,main="HADDOCK score vs FCC",xlab=NA,ylab=NA,xlim=range(Xmin,Xmax),ylim=range(Ymin,Ymax),pch=21,cex=1,bg=colored)
if ( nb_clust != 0 ) {
coor_center_irmsd=as.matrix(read.table("plotCI_fnat.file"))
}
title(xlab="FCC [a.u.]",line=4.5)
title(ylab="HADDOCK score [a.u.]",line=4)
}

### iRMSD vs van der Waals ###
if ( type == "vdw" ) {
tmpmax=max(Haddock_data[,6])
tmpmin=min(Haddock_data[,6])
Ymin=tmpmin-0.05*(tmpmax-tmpmin)
Ymax=tmpmax+0.05*(tmpmax-tmpmin)
tmpmax=max(Haddock_data[,3])
Xmin=0-0.05*(tmpmax)
Xmax=tmpmax+0.05*(tmpmax)

plot(Haddock_data[,3],Haddock_data[,6],axes=F,main="van der Waals vs i-RMSD",xlab=NA,ylab=NA,xlim=range(Xmin,Xmax),ylim=range(Ymin,Ymax),pch=21,cex=1,bg=colored)
if ( nb_clust != 0 ) {
coor_center_irmsd=as.matrix(read.table("plotCI_vdw.file"))
}
title(xlab=expression(paste("i-RMSD [",paste(ring(A),"]"),sep="")),line=4.5)
title(ylab="van der Waals [kcal/mol]",line=4)
}

### iRMSD vs Electrostatic ###
if ( type == "elec" ) {
tmpmax=max(Haddock_data[,7])
tmpmin=min(Haddock_data[,7])
Ymin=tmpmin-0.05*(tmpmax-tmpmin)
Ymax=tmpmax+0.05*(tmpmax-tmpmin)
tmpmax=max(Haddock_data[,3])
Xmin=0-0.05*(tmpmax)
Xmax=tmpmax+0.05*(tmpmax)

plot(Haddock_data[,3],Haddock_data[,7],axes=F,main="Electrostatics vs i-RMSD",xlab=NA,ylab=NA,xlim=range(Xmin,Xmax),ylim=range(Ymin,Ymax),pch=21,cex=1,bg=colored)
if ( nb_clust != 0 ) {
coor_center_irmsd=as.matrix(read.table("plotCI_elec.file"))
}
title(xlab=expression(paste("i-RMSD [",paste(ring(A),"]"),sep="")),line=4.5)
title(ylab="Electrostatic [kcal/mol]",line=4)
}

### iRMSD vs AIRs ###
if ( type == "air" ) {
tmpmax=max(Haddock_data[,8])
tmpmin=min(Haddock_data[,8])
Ymin=tmpmin-0.05*(tmpmax-tmpmin)
Ymax=tmpmax+0.05*(tmpmax-tmpmin)
tmpmax=max(Haddock_data[,3])
Xmin=0-0.05*(tmpmax)
Xmax=tmpmax+0.05*(tmpmax)

plot(Haddock_data[,3],Haddock_data[,8],axes=F,main="AIRs vs i-RMSD",xlab=NA,ylab=NA,xlim=range(Xmin,Xmax),ylim=range(Ymin,Ymax),pch=21,cex=1,bg=colored)
if ( nb_clust != 0 ) {
coor_center_irmsd=as.matrix(read.table("plotCI_air.file"))
}
title(xlab=expression(paste("i-RMSD [",paste(ring(A),"]"),sep="")),line=4.5)
title(ylab="AIRs [kcal/mol]",line=4)
}

### Legend definition
legend("topright", inset=c(-0.23,0), legend=leg, col=colors, pch=17, cex=1.5)

### Plotting centers of clusters (best 4)
if ( nb_clust != 0 ) {
plotCI(coor_center_irmsd[,1],coor_center_irmsd[,2],coor_center_irmsd[,3]/2,coor_center_irmsd[,3]/2, barcol=colors, pch=17,lwd=2,col=colors, add=TRUE, cex=1, gap=0.5, sfrac=0.007)
plotCI(coor_center_irmsd[,1],coor_center_irmsd[,2],coor_center_irmsd[,4]/2,coor_center_irmsd[,4]/2, barcol=colors, pch=17,lwd=2,col=colors, add=TRUE, err="x", cex=2, gap=0.5, sfrac=0.007)
}

box(lwd=2)
axis(1)
axis(2)

dev.off()

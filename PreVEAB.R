DEMO=read.table("DEMO", header=TRUE, sep="\t")
#DEMO[which(DEMO$CODON==138),2]
OR=read.table("OddsRatio_egg_strains", header=TRUE, sep="\t")
#OR[which (DAT$Codon==1 & DAT$AA=='H'),3]

GISAID=read.table("GISAID_32278_H3N2_HA1_Jul2016_OddsRatio", header=TRUE, sep="\t")
str(GISAID)
GISAID[,c(1,3)] <- sapply(GISAID[,c(1,3)],as.character) 
GISAID[nrow(GISAID) + 1,1:3] = c("TEST","NA","TEST")

OR[,c(2)] <- sapply(OR[,c(2)],as.character) 
CODON=c(138,145,156,158,159,160,183,186,190,193,194,219,226,246)
j=3
for(i in 1:14)
{
  j=j+1
  if (DEMO[which(DEMO$CODON==CODON[i]),2]!="NA")
  {
    if (OR[which (OR$Codon==CODON[i] & OR$AA==DEMO[which(DEMO$CODON==CODON[i]),2]),3]!="NA")
    {GISAID[nrow(GISAID),j] = OR[which(OR$Codon==CODON[i] & OR$AA==DEMO[which(DEMO$CODON==CODON[i]),2]),3]
    } else {stop(cat('The input of amino acid state over codon "',CODON[i],'" is not available in the list!\n', sep=''))}
  } else {stop(cat('The amino acid state over codon "',CODON[i],'" is missing in the input list!\n', sep=''))}
}
#cat('<set name="',CODON[1], '" value="',CODON[2],'">\n', sep='')
  
PCA <- princomp(GISAID[,4:17])
SCORE=PCA$scores
SCORE1=cbind(SCORE,GISAID$Passage)
SCORE=cbind(SCORE1,GISAID$Year)
colnames(SCORE)=c("PC1","PC2","PC3","PC4","PC5","PC6","PC7","PC8","PC9","PC10","PC11","PC12","PC13","PC14","PASSAGE","YEAR")

DIS = data.frame(Year=integer(),SpatialDistance=double())
#is.atomic(SCORE)
for (i in 2010:2016)
{
  PC1vacc=PC2vacc=0
  PC1bg=PC2bg=0
  dis=0
  VACCINE=SCORE[which(SCORE[,"YEAR"]==i & SCORE[,"PASSAGE"]=="EGG_VACCINE"),]
  BACKGROUND=SCORE[which(SCORE[,"YEAR"]==i & SCORE[,"PASSAGE"]!="EGG_VACCINE"),]
  for (j in 1:nrow(BACKGROUND))
    PC1bg=PC1bg+as.numeric(BACKGROUND[j,1])
    PC2bg=PC2bg+as.numeric(BACKGROUND[j,2])
  PC1bg=PC1bg/nrow(BACKGROUND)
  PC2bg=PC2bg/nrow(BACKGROUND)
  for (j in 1:nrow(VACCINE))
  {
    PC1vacc=as.numeric(VACCINE[j,1])
    PC2vacc=as.numeric(VACCINE[j,2])
    dis=dis+((PC1vacc - PC1bg)**2+(PC2vacc - PC2bg)**2)**0.5
  }
  dis=dis/nrow(VACCINE)
  DIS[nrow(DIS) + 1,1:2] = c(i,dis)
}

PC1test=PC2test=0
PC1bg=PC2bg=distT=0
#VACCINE=SCORE[which(SCORE[,"PASSAGE"]=="EGG_VACCINE"),]
TEST=SCORE[which(SCORE[,"PASSAGE"]=="TEST"),]
PC1test=as.numeric(TEST[1])
PC2test=as.numeric(TEST[2])
BACKGROUND=SCORE[which(SCORE[,"PASSAGE"]!="EGG_VACCINE" & SCORE[,"PASSAGE"]!="TEST"),]
for (j in 1:nrow(BACKGROUND))
  PC1bg=PC1bg+as.numeric(BACKGROUND[j,1])
  PC2bg=PC2bg+as.numeric(BACKGROUND[j,2])
PC1bg=PC1bg/nrow(BACKGROUND)
PC2bg=PC2bg/nrow(BACKGROUND)
disT=((PC1test - PC1bg)**2+(PC2test - PC2bg)**2)**0.5

pdf("efficacy_prediction.pdf")
par(mar=c(6, 5, 5, 4))
## Plot first set of data and draw its axis
plot(DIS$Year, DIS$SpatialDistance, pch=19, axes=FALSE,  xlab="", ylab="",type="b",col="black",cex.main=1.2, main="Vaccine_Efficancy vs. Distance",ylim=c(0,30))
abline(h=disT,col='blue',lwd=2)
axis(2, col="black",las=1,cex.axis=0.8)  ## las=1 makes horizontal labels
mtext("Distance",side=2,line=2.5,cex.axis=1.2)
box()
## Allow a second plot on the same graph
par(new=TRUE)
VE=c(0.46,0.32,0.40,0.10,0.07,NA,NA)
YR=c("2010-2011","2011-2012","2012-2013","2013-2014","2014-2015","2015-2016","2016-2017")
## Plot the second plot and put axis scale on right
plot(DIS$Year, VE, pch=15,  xlab="", ylab="", ylim=c(0,0.5), axes=FALSE, type="b", col="red")
## a little farther out (line=4) to make room for labels
mtext("Vaccine efficacy",side=4,col="black",line=4) 
axis(4, ylim=c(0,0.5), cex.axis=0.8, col="black",col.axis="black",las=1)
## Draw the time axis
axis(1, 2010:2016,YR[1:7],cex.axis=0.8,las=3)
#axis(1,YR)
mtext("Year windows",side=1,col="black",line=2.5,cex.axis=1.2)  
## Add Legend
legend("topright",legend=c("Adaptive Distance","Vaccine_Efficacy","Prediction"),pch=c(19,15),col=c("black","red","blue"),cex=0.8)
dev.off()

#png(file="SmoothLHB.png", height=550, width=450)
pdf("scatterplot.pdf")
num=array(0,dim=c(30,35))
for (i in 1:nrow(BACKGROUND))
  num[as.integer((as.numeric(BACKGROUND[i,1])-(-5))/1),as.integer((as.numeric(BACKGROUND[i,2])-(-31))/1)]=num[as.integer((as.numeric(BACKGROUND[i,1])-(-5))/1),as.integer((as.numeric(BACKGROUND[i,2])-(-31))/1)]+1

COUNT = data.frame(X=double(),Y=double(),Number=integer())
for (i in 1:30)
  for (j in 1:35)
    for (n in 1:num[i,j])
      COUNT[nrow(COUNT) + 1,1:3] = c(i*1-5,j*1-31,num[i,j])

smoothScatter(COUNT$X,COUNT$Y,colramp = colorRampPalette(c("cornflowerblue","slategray1","mistyrose", "pink","red")),pch="",xlab="PC1 (22%)",ylab="PC2 (21%)",main="Distribution of H3N2 HA1 sequences")
points(x=PC1test,y=PC2test,pch=19,cex=1)
text(x=PC1test,y=PC2test-1,labels="test strain", cex= .8, offset = 10)
dev.off()
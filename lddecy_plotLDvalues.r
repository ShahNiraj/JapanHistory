setwd("/Users/nshah/Desktop/Niraj/PopGenetics/LinkageDisequilibrium")
chr1.ld <- read.table(file="r2.few.txt",header=T)
plot(chr1.ld$MarkerDist,chr1.ld$R^2,type="p",cex=0.2,col="grey")
loe <- loess.smooth(chr1.ld$MarkerDist,chr1.ld$R^2,family="gaussian",degree=1,span=0.4)
lines(loe$x,loe$y,col="red",lwd=2)

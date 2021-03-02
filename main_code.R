# Setting base work directory
setwd("path/for/example/")
library(pvclust)
## Selecting 

file_list <- list.files(path="path/for/example/file.csv")
dataset <- data.frame()

for(i in 1:length(file_list)){
  ##each file will be read in
  temp_data <- read.csv(file_list[i], header=TRUE, row.names = 1)
  
  ##removing Xarea columns (those with no variance)
  dataset_hca <- temp_data[colnames(temp_data) %in% c("Rmin", "Rmax", "Rmean", "RstdDev", 
                                                      "Gmin", "Gmax", "GRmean", "GstdDev", 
                                                      "Bmin", "Bmax", "Bmean", "BstdDev")]
  ##if you are interested in clustering Rmin", "Rmax", (...) groups comment
  ## next line and change "dataset_hca_tranposed" by "dataset_hca" in  pvclust function
  dataset_hca_transposed <- t(dataset_hca)
  
  ##clustering - use your own parameters
  hca <- pvclust(dataset_hca_transposed, method.hclust="average",
          method.dist="correlation", use.cor="pairwise.complete.obs",
          nboot=1000, parallel=FALSE, r=seq(.5,1.4,by=.1),
          store=FALSE, weight=FALSE, iseed=NULL, quiet=FALSE)
  
  ##ploting - make it beautiful
  plot(hca, print.pv=TRUE, print.num=TRUE, float=0.01,
       col.pv=c(si=4, au=2, bp=3, edge=8), cex.pv=0.8, font.pv=NULL,
       col=NULL, cex=NULL, font=NULL, lty=NULL, lwd=NULL, main=NULL,
       sub=NULL, xlab=NULL)
}

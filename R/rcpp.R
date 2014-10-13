
##' @title Charge distribution
##' @description Read the charge information from mgf file
##' @param mgf A file of mgf.
##' @return A vector object
##' @export
##' @author Bo Wen \email{wenbo@@genomics.cn}
##' @examples
##' mgf.zip <- system.file("extdata/mgf.zip", package = "proteoQC")
##' unzip(mgf.zip)
##' charge <- chargeStat("test.mgf")
chargeStat=function(mgf=NULL){
  result <- .Call('ChargeCount_Cpp', PACKAGE = 'proteoQC', mgf)
  charge <- unlist(result)
  names(charge) <- gsub(pattern = "\\+.*$",replacement = "",x=names(charge))
  return(charge);
}

##' @title Calculate the labeling efficiency of isobaric labeling data 
##' @description Calculate the labeling efficiency of isobaric labeling data
##' @param ms MS/MS file.
##' @param iClass Isobaric tag class, 1=iTRAQ-8plex.
##' @param delta The mass error for reporter matching.
##' @return A vector object
##' @export
##' @author Bo Wen \email{wenbo@@genomics.cn}
##' @examples
##' mgf.zip <- system.file("extdata/mgf.zip", package = "proteoQC")
##' unzip(mgf.zip)
##' a <- labelRatio("test.mgf")
labelRatio=function(ms=NULL,iClass=1,delta=0.05){
  result <- .Call('LableRatio_Cpp', PACKAGE = 'proteoQC', ms,iClass,delta)
  result <- unlist(result)
  return(result);
}


##' @title Charge distribution
##' @description Read the charge information from mgf file
##' @param mgf A file of mgf.
##' @return A List object
##' @export
##' @author Bo Wen \email{wenbo@@genomics.cn}
##' @examples
##' mgf.zip <- system.file("extdata/mgf.zip", package = "proteoQC")
##' unzip(mgf.zip)
##' charge <- chargeStat("test.mgf")
chargeStat=function(mgf=NULL){
    result <- .Call('ChargeCount_Cpp', PACKAGE = 'proteoQC', mgf)
    charge <- unlist(result)
    return(charge);
}


##' @title Protein inference
##' @description Protein inference
##' @param file A file containing the information of peptides to proteins.
##' @param db A protein database of fasta format.
##' @param pepColName The column name of peptide sequence.
##' @param proColName The column name of protein ID.
##' @param spectrumColName The column name of spectrum index.
##' @param proSep The separator of protein ID, default is "".
##' @param outfile The output file name of protein group result.
##' @param xmx JAVA -Xmx, default is 1.
##' @return NULL
##' @export
##' @author Bo Wen \email{wenbo@@genomics.cn}
##' @examples
##' pep.zip <- system.file("extdata/pep.zip", package = "proteoQC")
##' unzip(pep.zip)
##' proteinGroup(file = "pep.txt", outfile = "pg.txt")
proteinGroup=function(file=NULL,db="",pepColName="peptide",
                      proColName="protein",spectrumColName="index",
                      proSep=";",outfile=NULL,xmx=1){
  ## get the java tool
  pgbin <- paste("java ",paste("-Xmx",xmx,"G",sep="")," -cp ",
                     paste('"',system.file("tool/tandemparser.jar", 
                                           package="proteoQC"),'"',
                           sep="",collapse=""), " cn.bgi.ProteinGroup ",
                     file, outfile ,paste('"',db,'"',sep="",collapse = ""),
                     pepColName, spectrumColName, proColName,
                     paste('"',proSep,'"',sep="",collapse = ""),
                     collapse=" ",sep=" ")
  ## run
  outfile=system(command=pgbin,intern=TRUE)
  cat(outfile,"\n")    
}
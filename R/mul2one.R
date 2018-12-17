#' align
#' @description alignment multiple fasta files to one template
#' @param fas path to fasta files
#' @param template path to template
#' @param ... parameters for \link[Biostrings:pairwiseAlignment]{pairwiseAlignment}.
#' @import Biostrings
#' @export
#' @return Returns a list of \link[Biostrings:PairwiseAlignments-class]{PairwiseAlignments} object.
#' @examples
#' path <- system.file("extdata", package="multi2one")
#' fas <- dir(path, "^Seq", full.names = TRUE)
#' template <- file.path(path, "p5E_MCS_UbiP.fa")
#' mul2one(fas, template)
mul2one <- function(fas, template, ...){
  q <- sapply(fas, readDNAStringSet)
  q <- Reduce(c, q)
  p <- readDNAStringSet(template)[[1]]
  
  x <- lapply(q, function(.q){
    pairwiseAlignment(p, .q, ...)
  })
  
  x
}

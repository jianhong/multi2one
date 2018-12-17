args <- commandArgs(trailingOnly = TRUE)
if(length(args)>0){
  for(i in seq_along(args)){
    print(args[[i]])
    eval(parse(text=args[[i]]))
  }
}else{
  stop("template and fasta files needed.",
       "eg. R CMD BATCH '--args template=\"plasmid.fa\" seqFold=\"seqs\" out=\"align.txt\"' multi2one.R multi2one.log.txt")
}
if(missing(seqFold)){
  stop("seqFold is required.")
}
if(missing(template)){
  stop("template is required.")
}
if(missing(out)){
  stop("out is required.")
}
fas=dir(seqFold, "*.fa", full.names = TRUE)
if(length(fas)<1){
  stop("No fasta file can be detected.")
}
library(multi2one)
x <- mul2one(fas, template)
write2txt(x, filename=out)

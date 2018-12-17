# multi2one
alignment multiple fasta files to one template

# Installation
```
library(devtools)
install_github("jianhong/multi2one")
```

# Howto

```
# 1. collect all the files need to be aligned 
fas <- dir("path/to/fa", "*.fa")
# 2. get the path for template
tmp <- "path/to/template.fa"
# 3. alignment
x <- mul2one(fas, template)
# 4. write to file
write2txt(x, filename="out.txt")
```

Batch
```
path=`R -e 'system.file("extdata", package="multi2one")' | grep "\[1\]" | cut -d'"' -f 2`
R CMD BATCH '--args template="plasmid.fa" seqFold="seqs" out="align.txt"' $path/multi2one.R multi2one.log.txt
```
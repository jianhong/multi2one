#' save mul2one result
#' @description save mul2one result to a text file
#' @param mo output of mul2one
#' @param filename output file name
#' @param num number of base per line
#' @export 
#' @import Biostrings
#' @importFrom utils write.table
#' @return NULL
#' @examples
#' path <- system.file("extdata", package="multi2one")
#' fas <- dir(path, "^Seq", full.names = TRUE)
#' template <- file.path(path, "p5E_MCS_UbiP.fa")
#' write2txt(mul2one(fas, template))

write2txt <- function(mo, filename="align.txt", num=50){
  s <- lapply(mo, function(x){
    x_type <- type(x)
    global.pattern <- x_type %in% c("global", "global-local")
    global.subject <- x_type %in% c("global", "local-global")
    x1 <- x[1L]
    p1start <- ifelse(global.pattern, 1, start(x1@pattern@range))
    s1start <- ifelse(global.subject, 1, start(x1@subject@range))
    p1 <- toString(alignedPattern(x1)[[1L]])
    s1 <- toString(alignedSubject(x1)[[1L]])
    n <- (seq.int(ceiling(nchar(p1)/num))-1)*num + 1
    n2 <- c(n[-1]-1, nchar(p1))
    p1 <- substring(p1, n, n2)
    s1 <- substring(s1, n, n2)
    p1start <- p1start + n - 1
    s1start <- s1start + n - 1
    width <- max(nchar(c(p1start, s1start)))+1
    p1start <- formatC(p1start, width = width, flag = " ")
    s1start <- formatC(s1start, width = width, flag = " ")
    p1 <- paste0("template: [", p1start, "] ", p1)
    s1 <- paste0("subject : [", s1start, "] ", s1)
    as.character(rbind(p1, s1))
  })
  for(i in seq_along(s)){
    write.table(paste(">", names(s)[i]), file=filename, append = TRUE, quote = FALSE, 
                row.names = FALSE, col.names = FALSE)
    write.table(s[[i]], file=filename, append = TRUE, quote=FALSE, 
                row.names=FALSE, col.names = FALSE)
  }
}
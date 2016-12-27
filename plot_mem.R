require(ggplot2)
require(reshape)

read_max_mem <- function(fname){
  df           <- read.csv(fname)
  mem_max      <- aggregate(vmem ~ version , data = df, max)
  mem_max$pmem <- aggregate(pmem ~ version , data = df, max)$pmem
  mem_max$benchmark <- fname
  return(mem_max)
}

plot_mem <- function(files, plot=FALSE){
  df <- do.call("rbind", lapply(files, read_max_mem))
  df <- melt(df, id=c("version","benchmark"))
  df$value_MB <- df$value / 1000 
  df$variable <- factor(df$variable, levels = c("pmem", "vmem"))
  p <- ggplot(data=df, aes(x=version, y=value_MB, fill=benchmark)) + 
    geom_bar(stat="identity", position="dodge") +
    facet_wrap(~ variable, , scales = "free_y", ncol = 1)
  return(p)
}

save_mem <- function(files, output="mem.png"){
  p <- plot_mem(files, plot=F)
  png(filename=output)
  print(p) 
  dev.off()
}


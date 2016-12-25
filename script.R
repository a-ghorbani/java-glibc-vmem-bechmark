
args   <- commandArgs(trailingOnly = TRUE)
files  <- strsplit(args[1], ",")[[1]]
output <- args[2]

print(args[1])
print(args[2])
print(files)
source("plot_mem.R")
save_mem(files, output)

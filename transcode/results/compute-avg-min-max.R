args <- commandArgs(trailingOnly=TRUE)
source_file <- args[1]

# Read table from input file and group by executable name.

d <- read.table(source_file, header=T, sep=",")

cm = d$cachemisses
rt = d$runningtime

# Print cache misses values and time to run values for each group.
cat("executable", "type", "mean", "min", "max", "sd", "rsd", sep=","); cat("\n")

cat("transcode", "cache-misses", mean(cm), min(cm), max(cm), sd(cm), 100*sd(cm)/mean(cm), sep=","); cat("\n")
cat("transcode", "running-time", mean(rt), min(rt), max(rt), sd(rt), 100*sd(rt)/mean(rt), sep=","); cat("\n")

q()

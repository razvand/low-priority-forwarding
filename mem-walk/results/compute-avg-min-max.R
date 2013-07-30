args <- commandArgs(trailingOnly=TRUE)
source_file <- args[1]

# Read table from input file and group by executable name.

d <- read.table(source_file, header=T, sep=",")

d1 <- d[d$executable == "./mem-walk-no-thread-no-thrash", ]
cm1 = d1$cachemisses
rt1 = d1$runningtime

d2 <- d[d$executable == "./mem-walk-no-thread", ]
cm2 = d2$cachemisses
rt2 = d2$runningtime

d3 <- d[d$executable == "./mem-walk-no-thrash", ]
cm3 = d3$cachemisses
rt3 = d3$runningtime

d4 <- d[d$executable == "./mem-walk", ]
cm4 = d4$cachemisses
rt4 = d4$runningtime

# Print cache misses values and time to run values for each group.
cat("executable", "type", "mean", "min", "max", "sd", "rsd", sep=","); cat("\n")

cat("mem-walk-no-thread-no-thrash", "cache-misses", mean(cm1), min(cm1), max(cm1), sd(cm1), 100*sd(cm1)/mean(cm1), sep=","); cat("\n")
cat("mem-walk-no-thread-no-thrash", "running-time", mean(rt1), min(rt1), max(rt1), sd(rt1), 100*sd(rt1)/mean(rt1), sep=","); cat("\n")

cat("mem-walk-no-thread", "cache-misses", mean(cm2), min(cm2), max(cm2), sd(cm2), 100*sd(cm2)/mean(cm2), sep=","); cat("\n")
cat("mem-walk-no-thread", "running-time", mean(rt2), min(rt2), max(rt2), sd(rt2), 100*sd(rt2)/mean(rt2), sep=","); cat("\n")

cat("mem-walk-no-thrash", "cache-misses", mean(cm3), min(cm3), max(cm3), sd(cm3), 100*sd(cm3)/mean(cm3), sep=","); cat("\n")
cat("mem-walk-no-thrash", "running-time", mean(rt3), min(rt3), max(rt3), sd(rt3), 100*sd(rt3)/mean(rt3), sep=","); cat("\n")

cat("mem-walk", "cache-misses", mean(cm4), min(cm4), max(cm4), sd(cm4), 100*sd(cm4)/mean(cm4), sep=","); cat("\n")
cat("mem-walk", "running-time", mean(rt4), min(rt4), max(rt4), sd(rt4), 100*sd(rt4)/mean(rt4), sep=","); cat("\n")

q()

args <- commandArgs(trailingOnly=TRUE)
source_file <- args[1]
source_file2 <- args[2]

# Read table from input file and group by executable name.

d <- read.table(source_file, header=T, sep=",")

bw <- d$bandwidth
rt <- d$runningtime

d <- read.table(source_file2, header=T, sep=",")
rt2 <- d$runningtime

plot(bw, rt, type = "b", xlab = "Bandwidth", ylab = "Running Time", col = "red") # , ylim=c(0,120))

lines(bw, rt2, type = "b", col = "blue") # , ylim=c(0,120))

title("transcode Running Time")

legend("topleft", c("forward", "no-forward"), fill=c('red', 'blue'))

plot(bw, rt, type = "b", xlab = "Bandwidth", ylab = "Running Time", col = "red", ylim=c(0,120))

lines(bw, rt2, type = "b", col = "blue", ylim=c(0,120))

title("transcode Running Time")

legend("topleft", c("forward", "no-forward"), fill=c('red', 'blue'))

q()

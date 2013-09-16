args <- commandArgs(trailingOnly=TRUE)
source_file <- args[1]
source_file2 <- args[2]

# Read table from input file and group by executable name.

d <- read.table(source_file, header=T, sep=",")

pps <- d$pps
rt <- d$runningtime

d <- read.table(source_file2, header=T, sep=",")
rt2 <- d$runningtime

mn <- min(rt,rt2)
mx <- max(rt,rt2)

plot(pps, rt, type = "b", xlab = "Kilopackets per second (Kpps)", ylab = "Running Time (seconds)", col = "red", xaxt="n", ylim=c(mn-5,mx+5))
axis(1, at=pps, labels=sprintf("%d", pps/1000))

lines(pps, rt2, type = "b", col = "blue") #, ylim=c(45,))

title("mem-walk Running Time")

legend("topleft", c("forward", "no-forward"), fill=c('red', 'blue'))

plot(pps, rt, type = "b", xlab = "Kilopackets per second (Kpps)", ylab = "Running Time (seconds)", col = "red", xaxt="n", ylim=c(0,220))
axis(1, at=pps, labels=sprintf("%d", pps/1000))

lines(pps, rt2, type = "b", col = "blue", ylim=c(0,220))

title("mem-walk Running Time")

legend("topleft", c("forward", "no-forward"), fill=c('red', 'blue'))

q()

args <- commandArgs(trailingOnly=TRUE)
evolution_file <- args[1]
no_fw_speed <- args[2]
exp_name <- args[3]
exp_subname <- args[4]

# Read table from input file and group by executable name.

d <- read.table(evolution_file, header=T, sep=",")

pps <- d$pps
rt <- d$runningtime

rt2 <- rep(as.integer(no_fw_speed), length(rt))

mn <- min(rt,rt2)
mx <- max(rt,rt2)

plot(pps, rt, type = "b", xlab = "Kilopackets per second (Kpps)", ylab = "Running Time (seconds)", col = "red", xaxt="n", ylim=c(mn-5,mx+5))
axis(1, at=pps, labels=sprintf("%d", pps/1000))

lines(pps, rt2, type = "b", col = "blue") #, ylim=c(45,))

title(main=paste(exp_name, "Running Time"), sub=exp_subname)

legend("topleft", c("forward", "no-forward"), fill=c('red', 'blue'))

plot(pps, rt, type = "b", xlab = "Kilopackets per second (Kpps)", ylab = "Running Time (seconds)", col = "red", xaxt="n", ylim=c(0,220))
axis(1, at=pps, labels=sprintf("%d", pps/1000))

lines(pps, rt2, type = "b", col = "blue", ylim=c(0,220))

title(main=paste(exp_name, "Running Time"), sub=exp_subname)

legend("topleft", c("forward", "no-forward"), fill=c('red', 'blue'))

q()

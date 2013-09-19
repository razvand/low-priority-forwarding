#
# Arguments are
#   exp_name: experiment name (mem-walk-pps)
#   exp_subname: experiment subname (ipt-block-unlimited)
#   no_fw_time: running time when not getting any traffic to forward
#

args <- commandArgs(trailingOnly=TRUE)
exp_name <- args[1]
exp_subname <- args[2]
no_fw_time <- args[3]

# Get file names and read data.

basename <- paste(exp_name, "-", exp_subname, "-fw-rt", sep="")
file_gen <- paste(basename, ".csv", sep="")
file_start <- paste(basename, "-start.csv", sep="")
file_end <- paste(basename, "-end.csv", sep="")
file_fw_in <- paste(basename, "-fw-in.csv", sep="")
file_fw_out <- paste(basename, "-fw-out.csv", sep="")

d_gen <- read.table(file_gen, header=T, sep=",")
d_start <- read.table(file_start, header=T, sep=",")
d_end <- read.table(file_end, header=T, sep=",")
d_fw_in <- read.table(file_fw_in, header=T, sep=",")
d_fw_out <- read.table(file_fw_out, header=T, sep=",")

pktsize <- d_gen$pktsize

time_gen <- d_gen$runningtime
time_nofw <- rep(as.integer(no_fw_time), length(time_gen))

pps_gen <- d_gen$pps
pps_start <- d_start$pps
pps_end <- d_end$pps
pps_fw_in <- d_fw_in$pps
pps_fw_out <- d_fw_out$pps

pdf(paste(exp_name, "-", exp_subname, ".pdf", sep=""))

mn <- min(time_gen, time_nofw)
mx <- max(time_gen, time_nofw)

# Plot running time when forwarding versus when not forwarding.
# Horizontal axis is number of generated packets.

plot(pktsize, time_gen, type = "b", xlab = "Packet size (bytes)", ylab = "Running Time (seconds)", col = "red", ylim=c(mn-5,mx+5), pch=1)
title(main=paste(exp_name, "Running Time"), sub=paste(exp_subname))
legend("topleft", c("forward", "no-forward"), fill=c('red', 'yellow'))
lines(pktsize, time_nofw, type = "b", col = "yellow", pch=6) #, ylim=c(45,))

plot(pktsize, time_gen, type = "b", xlab = "Packet size (bytes)", ylab = "Running Time (seconds)", col = "red", ylim=c(0,220), pch=1)
title(main=paste(exp_name, "Running Time"), sub=paste(exp_subname))
legend("topleft", c("forward", "no-forward"), fill=c('red', 'yellow'))
lines(pktsize, time_nofw, type = "b", col = "yellow", pch=6, ylim=c(0,220))

# Packets per second vs. packet size
plot(pktsize, pps_gen, type="b", xlab="Packet size (bytes)", ylab="Kilopackets per second (Kpps)", col = "red", pch=1, yaxt="n")
axis(2, at=pps_gen, labels=sprintf("%.0f", pps_gen/1000))
title(main=paste(exp_name, "Number of packets"), sub=paste(exp_subname))
legend("topleft", c("generated", "sender", "fw-in", "fw-out", "receiver"), fill=c('red', 'green', 'blue', 'orange', 'blueviolet'))
lines(pktsize, pps_start, type = "b", col = "green", pch=2)
lines(pktsize, pps_fw_in, type = "b", col = "blue", pch=3)
lines(pktsize, pps_fw_out, type = "b", col = "orange", pch=4)
lines(pktsize, pps_end, type = "b", col = "blueviolet", pch=5)

# Bps vs. packet size
plot(pktsize, pps_gen * pktsize * 8, type="b", xlab="Packet size (bytes)", ylab="Megabits per second (Mbit)", col = "red", pch=1, yaxt="n", ylim=c(0,1000000000))
axis(2, at=c(0,2e8,4e8,6e8,8e8,1e9), labels=sprintf("%.0f", c(0,2e8,4e8,6e8,8e8,1e9) / 1000000))
title(main=paste(exp_name, "Bandwidth"), sub=paste(exp_subname))
legend("topleft", c("generated", "sender", "fw-in", "fw-out", "receiver"), fill=c('red', 'green', 'blue', 'orange', 'blueviolet'))
lines(pktsize, pps_start * pktsize * 8, type = "b", col = "green", pch=2)
lines(pktsize, pps_fw_in * pktsize * 8, type = "b", col = "blue", pch=3)
lines(pktsize, pps_fw_out * pktsize * 8, type = "b", col = "orange", pch=4)
lines(pktsize, pps_end * pktsize * 8, type = "b", col = "blueviolet", pch=5)

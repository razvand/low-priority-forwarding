#
# Arguments are
#   exp_name: experiment name (mem-walk-pps)
#   exp_subname: experiment subname (ipt-block-pktsize60)
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

pps <- d_gen$pps

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

plot(pps_gen, time_gen, type = "b", xlab = "Kilopackets per second (Kpps)", ylab = "Running Time (seconds)", col = "red", xaxt="n", ylim=c(mn-5,mx+5), pch=1)
axis(1, at=pps, labels=sprintf("%.0f", pps/1000))
title(main=paste(exp_name, "Running Time"), sub=paste(exp_subname, "generated"))
legend("topleft", c("forward", "no-forward"), fill=c('red', 'yellow'))
lines(pps_gen, time_nofw, type = "b", col = "yellow", pch=6) #, ylim=c(45,))

plot(pps_gen, time_gen, type = "b", xlab = "Kilopackets per second (Kpps)", ylab = "Running Time (seconds)", col = "red", xaxt="n", ylim=c(0,220), pch=1)
axis(1, at=pps, labels=sprintf("%.0f", pps/1000))
title(main=paste(exp_name, "Running Time"), sub=paste(exp_subname, "generated"))
legend("topleft", c("forward", "no-forward"), fill=c('red', 'yellow'))
lines(pps_gen, time_nofw, type = "b", col = "yellow", pch=6, ylim=c(0,220))

# Plot running time when forwarding versus when not forwarding.
# Horizontal axis is number of packets on sender interface.

plot(pps_start, time_gen, type = "b", xlab = "Kilopackets per second (Kpps)", ylab = "Running Time (seconds)", col = "green", xaxt="n", pch=2, ylim=c(mn-5,mx+5))
axis(1, at=pps_start, labels=sprintf("%.0f", pps_start/1000))
title(main=paste(exp_name, "Running Time"), sub=paste(exp_subname, "sender"))
legend("topleft", c("forward", "no-forward"), fill=c('green', 'yellow'))
lines(pps_gen, time_nofw, type = "b", col = "yellow", pch=6) #, ylim=c(45,))

plot(pps_start, time_gen, type = "b", xlab = "Kilopackets per second (Kpps)", ylab = "Running Time (seconds)", col = "green", xaxt="n", pch=2, ylim=c(0,220))
axis(1, at=pps_start, labels=sprintf("%.0f", pps_start/1000))
title(main=paste(exp_name, "Running Time"), sub=paste(exp_subname, "sender"))
legend("topleft", c("forward", "no-forward"), fill=c('green', 'yellow'))
lines(pps_start, time_nofw, type = "b", col = "yellow", pch=6, ylim=c(0,220))

# Plot running time when forwarding versus when not forwarding.
# Horizontal axis is number of packets on forwarder in interface.

plot(pps_fw_in, time_gen, type = "b", xlab = "Kilopackets per second (Kpps)", ylab = "Running Time (seconds)", col = "blue", xaxt="n", pch=3, ylim=c(mn-5,mx+5))
axis(1, at=pps_fw_in, labels=sprintf("%.0f", pps_fw_in/1000))
title(main=paste(exp_name, "Running Time"), sub=paste(exp_subname, "forwarder in"))
legend("topleft", c("forward", "no-forward"), fill=c('blue', 'yellow'))
lines(pps_fw_in, time_nofw, type = "b", col = "yellow", pch=6) #, ylim=c(45,))

plot(pps_fw_in, time_gen, type = "b", xlab = "Kilopackets per second (Kpps)", ylab = "Running Time (seconds)", col = "blue", xaxt="n", pch=3, ylim=c(0,220))
axis(1, at=pps_fw_in, labels=sprintf("%.0f", pps_fw_in/1000))
title(main=paste(exp_name, "Running Time"), sub=paste(exp_subname, "forwarder in"))
legend("topleft", c("forward", "no-forward"), fill=c('blue', 'yellow'))
lines(pps_fw_in, time_nofw, type = "b", col = "yellow", pch=6, ylim=c(0,220))

# Plot running time when forwarding versus when not forwarding.
# Horizontal axis is number of packets on forwarder out interface.

plot(pps_fw_out, time_gen, type = "b", xlab = "Kilopackets per second (Kpps)", ylab = "Running Time (seconds)", col = "orange", xaxt="n", pch=4, ylim=c(mn-5,mx+5))
axis(1, at=pps_fw_out, labels=sprintf("%.0f", pps_fw_out/1000))
title(main=paste(exp_name, "Running Time"), sub=paste(exp_subname, "forwarder out"))
legend("topleft", c("forward", "no-forward"), fill=c('orange', 'yellow'))
lines(pps_fw_out, time_nofw, type = "b", col = "yellow", pch=6) #, ylim=c(45,))

plot(pps_fw_out, time_gen, type = "b", xlab = "Kilopackets per second (Kpps)", ylab = "Running Time (seconds)", col = "orange", xaxt="n", pch=4, ylim=c(0,220))
axis(1, at=pps_fw_out, labels=sprintf("%.0f", pps_fw_out/1000))
title(main=paste(exp_name, "Running Time"), sub=paste(exp_subname, "forwarder out"))
legend("topleft", c("forward", "no-forward"), fill=c('orange', 'yellow'))
lines(pps_fw_out, time_nofw, type = "b", col = "yellow", pch=6, ylim=c(0,220))

# Plot running time when forwarding versus when not forwarding.
# Horizontal axis is number of packets on receiver interface.

plot(pps_end, time_gen, type = "b", xlab = "Kilopackets per second (Kpps)", ylab = "Running Time (seconds)", col = "blueviolet", xaxt="n", pch=5, ylim=c(mn-5,mx+5))
axis(1, at=pps_end, labels=sprintf("%.0f", pps_end/1000))
title(main=paste(exp_name, "Running Time"), sub=paste(exp_subname, "receiver"))
legend("topleft", c("forward", "no-forward"), fill=c('blueviolet', 'yellow'))
lines(pps_end, time_nofw, type = "b", col = "yellow", pch=6) #, ylim=c(45,))

plot(pps_end, time_gen, type = "b", xlab = "Kilopackets per second (Kpps)", ylab = "Running Time (seconds)", col = "blueviolet", xaxt="n", pch=5, ylim=c(0,220))
axis(1, at=pps_end, labels=sprintf("%.0f", pps_end/1000))
title(main=paste(exp_name, "Running Time"), sub=paste(exp_subname, "receiver"))
legend("topleft", c("forward", "no-forward"), fill=c('blueviolet', 'yellow'))
lines(pps_end, time_nofw, type = "b", col = "yellow", pch=6, ylim=c(0,220))

# Plot packets per second on different cases versus generated packets.

plot(pps_gen, pps_gen, type = "b", xlab = "Kilopackets per second (Kpps)", ylab = "Kilopackets per second (Kpps)", col = "red", pch=1, xaxt = "n", yaxt = "n")
axis(1, at=pps_gen, labels=sprintf("%.0f", pps_gen/1000))
axis(2, at=pps_gen, labels=sprintf("%.0f", pps_gen/1000))
title(main=paste(exp_name, "Kpps vs. Kpps", sub=exp_subname))
legend("topleft", c("generated", "sender", "fw-in", "fw-out", "receiver"), fill=c('red', 'green', 'blue', 'orange', 'blueviolet'))
lines(pps_start, pps_gen, type = "b", col = "green", pch=2)
lines(pps_fw_in, pps_gen, type = "b", col = "blue", pch=3)
lines(pps_fw_out, pps_gen, type = "b", col = "orange", pch=4)
lines(pps_end, pps_gen, type = "b", col = "blueviolet", pch=5)

invisible(dev.off())

q()

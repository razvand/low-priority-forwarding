#
# Arguments are
#   exp_name: experiment name (mem-walk-pps)
#   no_fw_time: running time when not getting any traffic to forward
#

args <- commandArgs(trailingOnly=TRUE)
exp_name <- args[1]
no_fw_time <- args[2]


# Get file names and read data.

basename <- paste(exp_name, "-normal-unlimited-fw-rt", sep="")
file_gen_normal <- paste(basename, ".csv", sep="")
file_start_normal <- paste(basename, "-start.csv", sep="")
file_end_normal <- paste(basename, "-end.csv", sep="")
file_fw_in_normal <- paste(basename, "-fw-in.csv", sep="")
file_fw_out_normal <- paste(basename, "-fw-out.csv", sep="")

d_gen_normal <- read.table(file_gen_normal, header=T, sep=",")
d_start_normal <- read.table(file_start_normal, header=T, sep=",")
d_end_normal <- read.table(file_end_normal, header=T, sep=",")
d_fw_in_normal <- read.table(file_fw_in_normal, header=T, sep=",")
d_fw_out_normal <- read.table(file_fw_out_normal, header=T, sep=",")

time_gen_normal <- d_gen_normal$runningtime
pktsize <- d_gen_normal$pktsize


pps_gen_normal <- d_gen_normal$pps
pps_start_normal <- d_start_normal$pps
pps_end_normal <- d_end_normal$pps
pps_fw_in_normal <- d_fw_in_normal$pps
pps_fw_out_normal <- d_fw_out_normal$pps


basename <- paste(exp_name, "-ipt-block-unlimited-fw-rt", sep="")
file_gen_ipt <- paste(basename, ".csv", sep="")
file_start_ipt <- paste(basename, "-start.csv", sep="")
file_end_ipt <- paste(basename, "-end.csv", sep="")
file_fw_in_ipt <- paste(basename, "-fw-in.csv", sep="")
file_fw_out_ipt <- paste(basename, "-fw-out.csv", sep="")

d_gen_ipt <- read.table(file_gen_ipt, header=T, sep=",")
d_start_ipt <- read.table(file_start_ipt, header=T, sep=",")
d_end_ipt <- read.table(file_end_ipt, header=T, sep=",")
d_fw_in_ipt <- read.table(file_fw_in_ipt, header=T, sep=",")
d_fw_out_ipt <- read.table(file_fw_out_ipt, header=T, sep=",")

time_gen_ipt <- d_gen_ipt$runningtime

pps_gen_ipt <- d_gen_ipt$pps
pps_start_ipt <- d_start_ipt$pps
pps_end_ipt <- d_end_ipt$pps
pps_fw_in_ipt <- d_fw_in_ipt$pps
pps_fw_out_ipt <- d_fw_out_ipt$pps


basename <- paste(exp_name, "-fw-disable-unlimited-fw-rt", sep="")
file_gen_fwdis <- paste(basename, ".csv", sep="")
file_start_fwdis <- paste(basename, "-start.csv", sep="")
file_end_fwdis <- paste(basename, "-end.csv", sep="")
file_fw_in_fwdis <- paste(basename, "-fw-in.csv", sep="")
file_fw_out_fwdis <- paste(basename, "-fw-out.csv", sep="")

d_gen_fwdis <- read.table(file_gen_fwdis, header=T, sep=",")
d_start_fwdis <- read.table(file_start_fwdis, header=T, sep=",")
d_end_fwdis <- read.table(file_end_fwdis, header=T, sep=",")
d_fw_in_fwdis <- read.table(file_fw_in_fwdis, header=T, sep=",")
d_fw_out_fwdis <- read.table(file_fw_out_fwdis, header=T, sep=",")

time_gen_fwdis <- d_gen_fwdis$runningtime

pps_gen_fwdis <- d_gen_fwdis$pps
pps_start_fwdis <- d_start_fwdis$pps
pps_end_fwdis <- d_end_fwdis$pps
pps_fw_in_fwdis <- d_fw_in_fwdis$pps
pps_fw_out_fwdis <- d_fw_out_fwdis$pps


basename <- paste(exp_name, "-50perc-block-unlimited-fw-rt", sep="")
file_gen_50perc <- paste(basename, ".csv", sep="")
file_start_50perc <- paste(basename, "-start.csv", sep="")
file_end_50perc <- paste(basename, "-end.csv", sep="")
file_fw_in_50perc <- paste(basename, "-fw-in.csv", sep="")
file_fw_out_50perc <- paste(basename, "-fw-out.csv", sep="")

d_gen_50perc <- read.table(file_gen_50perc, header=T, sep=",")
d_start_50perc <- read.table(file_start_50perc, header=T, sep=",")
d_end_50perc <- read.table(file_end_50perc, header=T, sep=",")
d_fw_in_50perc <- read.table(file_fw_in_50perc, header=T, sep=",")
d_fw_out_50perc <- read.table(file_fw_out_50perc, header=T, sep=",")

time_gen_50perc <- d_gen_50perc$runningtime

pps_gen_50perc <- d_gen_50perc$pps
pps_start_50perc <- d_start_50perc$pps
pps_end_50perc <- d_end_50perc$pps
pps_fw_in_50perc <- d_fw_in_50perc$pps
pps_fw_out_50perc <- d_fw_out_50perc$pps


pps <- d_gen_normal$pps
time_nofw <- rep(as.integer(no_fw_time), length(time_gen_normal))

mn <- min(time_gen_normal, time_gen_50perc, time_gen_ipt, time_gen_fwdis, time_nofw)
mx <- max(time_gen_normal, time_gen_50perc, time_gen_ipt, time_gen_fwdis, time_nofw)


pdf(paste(exp_name, "-unlimited-cumulative.pdf", sep=""))

# Plot running time when forwarding versus when not forwarding.
# Horizontal axis is number of generated packets.

plot(pktsize, time_gen_normal, type = "b", xlab = "Packet size (bytes)", ylab = "Running Time (seconds)", col = "red", ylim=c(mn-5,mx+5), pch=1)
title(main=paste(exp_name, "Running Time"), sub="cumulative")
legend("topleft", c("normal", "ipt-block", "fw-disable", "50perc-block", "no-forward"), fill=c('red', 'green', 'blue', 'orange', 'yellow'))
lines(pktsize, time_gen_ipt, type = "b", col = "green", pch=2) #, ylim=c(45,))
lines(pktsize, time_gen_fwdis, type = "b", col = "blue", pch=3) #, ylim=c(45,))
lines(pktsize, time_gen_50perc, type = "b", col = "orange", pch=4) #, ylim=c(45,))
lines(pktsize, time_nofw, type = "b", col = "yellow", pch=6) #, ylim=c(45,))

invisible(dev.off())

q()

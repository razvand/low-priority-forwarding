args <- commandArgs(trailingOnly=TRUE)
source_file <- args[1]

d <- read.table(source_file, header=T, sep=",")

iface_list_initial <- d$iface

cat("iface", "rx_pkts", "tx_pkts", "rx_bytes", "tx_bytes\n", sep = ",")

for (i in unique(iface_list_initial))
{
	d2 <- d[d$iface == i, ]

	date_list <- d2$date
	iface <- i
	rx_pkts_list <- d2$rx_pkts
	tx_pkts_list <- d2$tx_pkts
	rx_bytes_list <- d2$rx_bytes
	tx_bytes_list <- d2$tx_bytes

	cat(cat("avg", iface, sep = "-"), mean(rx_pkts_list), mean(tx_pkts_list), mean(rx_bytes_list), mean(tx_bytes_list), sep = ","); cat("\n")
}

/*
 * Drop every nth packet.
 */

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <asm/uaccess.h>
#include <linux/fs.h>
#include <linux/cdev.h>
#include <asm/atomic.h>
#include <linux/netfilter.h>
#include <linux/netfilter_ipv4.h>
#include <linux/net.h>
#include <linux/in.h>
#include <linux/skbuff.h>
#include <linux/ip.h>
#include <linux/tcp.h>

MODULE_DESCRIPTION("Drop every nth packet");
MODULE_AUTHOR("Razvan Deaconescu <razvan.deaconescu@cs.pub.ro>");
MODULE_LICENSE("GPL");

#define LOG_LEVEL		KERN_ALERT

static unsigned int my_nf_hookfn(unsigned int hooknum,
					struct sk_buff *skb,
					const struct net_device *in,
					const struct net_device *out,
					int (*okfn)(struct sk_buff *))
{
	/* get IP header */
	struct iphdr *iph = ip_hdr(skb);

	if (iph->protocol == IPPROTO_TCP) {
		/* get TCP header */
		struct tcphdr *tcph = tcp_hdr(skb);
		/* test for connection initiating packet */
		if (tcph->syn && !tcph->ack)
			printk(LOG_LEVEL "TCP connection initiated from "
				"%pI4:%u\n",
				&iph->saddr, ntohs(tcph->source));
	}

	/* let the package pass */
	return NF_ACCEPT;
}

static struct nf_hook_ops my_nfho = {
	.owner       = THIS_MODULE,
	.hook        = my_nf_hookfn,
	.hooknum     = NF_INET_LOCAL_OUT,
	.pf          = PF_INET,
	.priority    = NF_IP_PRI_FIRST
};

int __init my_hook_init(void)
{
	int err;

	/* register netfilter hook */
	err = nf_register_hook(&my_nfho);
	if (err)
		goto out;

	return 0;

out:
	return err;
}

void __exit my_hook_exit(void)
{
	/* unregister hook */
	nf_unregister_hook(&my_nfho);
}

module_init(my_hook_init);
module_exit(my_hook_exit);

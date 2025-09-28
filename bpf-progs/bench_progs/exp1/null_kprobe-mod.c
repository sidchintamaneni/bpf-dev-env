#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/kprobes.h>

MODULE_LICENSE("GPL");

static struct kprobe kp = {
    .symbol_name = "__do_sys_bpfprof",
};

static int null_handler(struct kprobe *p, struct pt_regs *regs)
{
    return 0;
}

static int __init kprobe_init(void)
{
    kp.pre_handler = null_handler;
    return register_kprobe(&kp);
}

static void __exit kprobe_cleanup(void)
{
    unregister_kprobe(&kp);
}

module_init(kprobe_init);
module_exit(kprobe_cleanup);

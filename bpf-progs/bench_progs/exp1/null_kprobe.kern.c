#include <linux/bpf.h>
#include <linux/types.h>
#include <bpf/bpf_helpers.h>

SEC("kprobe/__do_sys_bpfprof")
int trigger_syscall_prog(struct pt_regs *regs) {
    return 0;
}

char LISENSE[] SEC("license") = "Dual BSD/GPL";

## IMPORTANT!

If you use config file from linux-config/ and the kprobe that you attach will
use int3 (unoptimized). 

Enable `FUNCTION_TRACER` and `DYNAMIC_FTRACE`, to enable optimized kprobe and
fentry/ fexit.

Before running experiments attach gdb and please confirm to makesure.

SOURCES := $(wildcard *.kern.c)
FILES := $(SOURCES:.c=.o)
MAP_FINE_SRC := $(wildcard map-fine/*.kern.c)
MAP_FINE_OBJ := $(MAP_FINE_SRC:.c=.o)
MAP_FINE_USER_SRC := $(wildcard map-fine/*.user.c)
MAP_FINE_USER_OBJ := $(MAP_FINE_USER_SRC:.c=)
USER_SRC := $(wildcard *.user.c)
USER_SKEL := $(SOURCES:.c=.skel.h)
USER_LSKEL := $(SOURCES:.c=.lskel.h)
USER := $(USER_SRC:.c=)
BPF-CLANG := clang
BPF_CLANG_CFLAGS := -target bpf -g -Wall -O2 -c
INCLUDE := -I../linux/usr/include/ -I../linux/tools/lib/
USER-CFLAGS := -g -I../linux/usr/include -I../linux/tools/lib/ -L../linux/tools/lib/bpf/


all: $(FILES) $(USER_SKEL) $(USER_LSKEL) $(USER)
	
$(FILES) : %.o : %.c
	$(BPF-CLANG) $(INCLUDE) $(BPF_CLANG_CFLAGS) -o $@ $<

$(USER) : % : %.c
	gcc $(USER-CFLAGS) $< -lbpf -o $@


$(USER_SKEL) : %.skel.h : %.o
	bpftool gen skeleton $<  > $@

$(USER_LSKEL) : %.lskel.h : %.o
	bpftool gen skeleton -L $<  > $@

.PHONY : clean

clean :
	rm $(FILES) $(USER)

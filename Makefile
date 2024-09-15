# create toolchain path to link .pico-sdk with necessary compilers
PICO_TOOLCHAIN_PATH ?= ~/.pico-sdk/toolchain/13_2_Rel1
CPP = $(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-cpp
CC=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-gcc
AS=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-as
LD=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-ld

# create src variable for shortcut to .c files
SRC=main.c second.c

# link object files by finding path to src files
OBJS=$(patsubst %.c,%.o,$(SRC))

# first reecipe shortcut for firmware
all: firmware.elf

# rules modified to have implicit rule suusing % pattern
%.i: %.c
	$(CPP) $< > $@

%.s: %.i
	$(CC) -S $<

%.o: %.s
	$(AS) $< -o $@

# link all object files with .elf file
firmware.elf: $(OBJS)
	$(LD) -o $@ $^

# use initial rule and target before cleaning
hello.txt:
	echo "hello world!" > hello.txt

# run clean to remove all unecessary files
clean:
	rm -f .i.s .o.elf *.img hello.txt

# run clean when invoking a make clean
.PHONY: clean all
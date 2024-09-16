# create toolchain path to link .pico-sdk with necessary compilers
CPP=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-cpp
CC=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-gcc
AS=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-as
LD=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-ld
OBJCOPY=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-objcopy

# create src variable for shortcut to .c files
SRC=main.c second.c

# link object files by finding path to src files
OBJS=$(patsubst %.c,%.o,$(SRC))

# first reecipe shortcut for firmware
all: firmware.elf

# use initial rule and target before cleaning
hello.txt:
	echo "hello world!" > hello.txt

# run clean to remove all unecessary files
clean:
	rm -f *.i *.s *.o *.elf *.txt 

# rules modified to have implicit rule suusing % pattern
%.i: %.c
	$(CPP) $< > $@


%.s: %.i
	$(CC) -S $<

%.o: %.s
	$(AS) $< -o $@

OBJS=main.o

# link all object files with .elf file
firmware.elf: $(OBJS)
	$(LD) -o $@ $^

# run clean when invoking a make clean
.PHONY: all clean
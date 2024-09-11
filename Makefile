CPP=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-cpp
CC=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-gcc
AS=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-as
LD=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-ld
OBJCOPY=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-objcopy

SRC=main.c second.c
OBJS=$(patsubst %.c,%.o,$(SRC))

all: firmware.elf

hello.txt:
	echo "hello world!" > hello.txt

clean:
	rm -f *.i *.s *.o *.elf

%.i: %.c
	$(CPP) $< > $@


%.s: %.i
	$(CC) -S $<

%.o: %.s
	$(AS) $< -o $@

OBJS=main.o

firmware.elf: $(OBJS)
	$(LD) -o $@ $^

.PHONY: all clean

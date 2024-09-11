CPP=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-cpp
CC=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-gcc
AS=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-as

hello.txt:
	echo "hello world!" > hello.txt

clean:
	rm -f *.i *.s *.o

%.i: %.c
	$(CPP) $< > $@


%.s: %.i
	$(CC) -S $<

%.o: %.s
	$(AS) $< -o $@


.PHONY: all clean

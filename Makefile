CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
BIN = arm-none-eabi-objcopy
STL = st-flash
CFLAGS = -mthumb -mcpu=cortex-m3 -g
BUILD_DIR = ./build

all: app.bin

crt.o: crt.s
	$(AS) -o $(BUILD_DIR)/crt.o crt.s

main.o: main.c
	$(CC) $(CFLAGS) -c -o $(BUILD_DIR)/main.o main.c

app.elf: linker.ld crt.o main.o
	$(LD) -T linker.ld -o $(BUILD_DIR)/app.elf $(BUILD_DIR)/crt.o $(BUILD_DIR)/main.o

app.bin: app.elf
	$(BIN) -O binary $(BUILD_DIR)/app.elf $(BUILD_DIR)/app.bin

clean:
	rm -f 	$(BUILD_DIR)/*.o $(BUILD_DIR)/*.elf	$(BUILD_DIR)/*.bin

flash: app.bin
	$(STL) write $(BUILD_DIR)/app.bin 0x8000000

erase:
	$(STL) erase

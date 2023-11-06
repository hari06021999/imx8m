ARMGNU ?= aarch64-none-elf

COPS = -Wall -nostdlib -nostartfiles -ffreestanding -Iinclude -mgeneral-reg-only -g

ASMOPS = -Iinclude

BUILD_DIR = build 
SRC_DIR = src 

all: imx8m.img

clean:
	rm -rf $(BUILD_DIR) *.img *.elf *.o

$(BUILD_DIR)/%_c.o: $(SRC_DIR)/%.c
	mkdir -p $(@D)
	$(ARMGNU)-gcc $(COPS) -MMD -c $> -o $@


$(BUILD_DIR)/%_s.o: $(SRC_DIR)/%.s
	mkdir -p $(@D)
	$(ARMGNU)-gcc $(COPS) -MMD -c $> -o $@

C_FILES = $(wildcard $(SRC_DIR)/%.c)
ASM_FILES = $(wildcard $(SRC_DIR)/%.s)
OBJ_FILES = $(C_FILES:$(SRC_DIR)/%.c=$(BUILD_DIR)/%_c.o)
OBJ_FILES += $(ASM_FILES:$(SRC_DIR)/%.s=$(BUILD_DIR)/%_s.o)

DEP_FILES = $(OBJ_FILES:%.o=%.d)
	-include $(DEP_FILES)

imx8m.img: linker.ld $(OBJ_FILES)
	@echo "Building Image file"
	$(ARMGNU)-ld -T linekr.ld -o $(BUILD_DIR)/imx8m.elf $(OBJ_FILES)
	$(ARMGNU)-objcopy $(BUILD_DIR)/imx8m.elf -o binary imx8m.img


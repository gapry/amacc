CROSS_COMPILER_PREFIX =
CFLAGS = -Os -Wall -fsigned-char -g
LIBS = -ldl
QEMU_PLATFORM_ARM = qemu-arm
BIN = amacc

ifeq ($(PREFIX), arm-linux-gnueabihf-)
	CROSS_COMPILER_PREFIX = arm-linux-gnueabihf
else
	CROSS_COMPILER_PREFIX = arm-linux-gnueabi
endif

all: $(BIN)

amacc: amacc.c
	$(CROSS_COMPILER_PREFIX)-gcc $(CFLAGS) -o amacc amacc.c $(LIBS)

check: $(BIN)
	@echo "[ compiled ]"
	@$(QEMU_PLATFORM_ARM) -L /usr/$(CROSS_COMPILER_PREFIX) ./$(BIN) hello.c
	@echo "[ nested ]"
	@$(QEMU_PLATFORM_ARM) -L /usr/$(CROSS_COMPILER_PREFIX) ./$(BIN) amacc.c hello.c
	@cloc --quiet amacc.c 2>/dev/null

clean:
	$(RM) $(BIN)

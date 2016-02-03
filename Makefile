CROSS_COMPILER_PREFIX =
CFLAGS = -Os -Wall
LIBS = -ldl

BIN = amacc

ifeq ($(PREFIX), arm-linux-gnueabihf-)
	CROSS_COMPILER_PREFIX = arm-linux-gnueabihf
else
	CROSS_COMPILER_PREFIX = arm-linux-gnueabi
endif

all: $(BIN)

amacc: amacc.c
	$(CROSS_COMPILER_PREFIX)-gcc $(CFLAGS) -fsigned-char -o amacc amacc.c -g $(LIBS)

check: $(BIN)
	@echo "[ compiled ]"
	@qemu-arm -L /usr/arm-linux-gnueabihf ./amacc hello.c
	@echo "[ nested ]"
	@qemu-arm -L /usr/arm-linux-gnueabihf ./amacc amacc.c hello.c
	@cloc --quiet amacc.c 2>/dev/null

clean:
	$(RM) $(BIN)

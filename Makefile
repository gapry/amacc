CROSS_COMPILE =
CFLAGS = -Os -Wall -fsigned-char -g
LIBS = -ldl
QEMU_PLATFORM_ARM = qemu-arm
BIN = amacc
SRC = amacc.c

ifeq ($(PREFIX), arm-linux-gnueabihf-)
	CROSS_COMPILE = arm-linux-gnueabihf
else
	CROSS_COMPILE = arm-linux-gnueabi
endif

all: $(BIN)

amacc: amacc.c
	$(CROSS_COMPILE)-gcc $(CFLAGS) -o $(BIN) $(SRC) $(LIBS)

check: $(BIN)
	@echo "[ compiled ]"
	@$(QEMU_PLATFORM_ARM) -L /usr/$(CROSS_COMPILE) ./$(BIN) hello.c
	@echo "[ nested ]"
	@$(QEMU_PLATFORM_ARM) -L /usr/$(CROSS_COMPILE) ./$(BIN) $(SRC) hello.c
	@cloc --quiet $(SRC) 2>/dev/null

clean:
	$(RM) $(BIN)

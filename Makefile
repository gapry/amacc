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

CROSS_EXEC = $(QEMU_PLATFORM_ARM) -L /usr/$(CROSS_COMPILE)

all: $(BIN)

amacc: amacc.c
	$(CROSS_COMPILE)-gcc $(CFLAGS) -o $(BIN) $(SRC) $(LIBS)

check: $(BIN)
	@echo "[ compiled ]"
	@$(CROSS_EXEC) ./$(BIN) hello.c
	@echo "[ nested ]"
	@$(CROSS_EXEC) ./$(BIN) $(SRC) hello.c
	@cloc --quiet $(SRC) 2>/dev/null

clean:
	$(RM) $(BIN)

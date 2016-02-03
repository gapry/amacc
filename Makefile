CROSS_COMPILE =
CFLAGS = -Os -Wall -fsigned-char -g
LIBS = -ldl
QEMU = qemu-arm
BIN = amacc
SRC = $(BIN).c
TEST_CASE = tests
TEST_HELLO = hello.c

ifeq ($(PREFIX), arm-linux-gnueabihf-)
	CROSS_COMPILE = arm-linux-gnueabihf
else
	CROSS_COMPILE = arm-linux-gnueabi
endif

CROSS_EXEC = $(QEMU) -L /usr/$(CROSS_COMPILE)

all: $(BIN)

amacc: amacc.c
	$(CROSS_COMPILE)-gcc $(CFLAGS) -o $(BIN) $(SRC) $(LIBS)

check: $(BIN)
	@echo "[ compiled ]"
	@$(CROSS_EXEC) ./$(BIN) $(TEST_CASE)/$(TEST_HELLO)
	@echo "[ nested ]"
	@$(CROSS_EXEC) ./$(BIN) $(SRC) $(TEST_CASE)/$(TEST_HELLO)
	@cloc --quiet $(SRC) 2>/dev/null

clean:
	$(RM) $(BIN)

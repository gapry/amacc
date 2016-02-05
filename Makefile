CROSS_COMPILE ?= arm-linux-gnueabihf-
CFLAGS = -Os -Wall -fsigned-char -g
TEST_DIR = ./tests
TEST_SRC = $(wildcard $(TEST_DIR)/*.c)
TEST_OBJ = $(TEST_SRC:.c=.o)
PASS_COLOR = \x1b[32;01m
NO_COLOR = \x1b[0m

BIN = amacc

ARM_EXEC = qemu-arm -L /usr/$(shell echo $(CROSS_COMPILE) | sed s'/.$$//')

all: $(BIN)

amacc: amacc.c
	$(CROSS_COMPILE)gcc $(CFLAGS) -o amacc amacc.c -ldl

check:
	@$(ARM_EXEC) ./amacc tests/jit.c
	@/bin/echo -e "[=== test JIT ===] $(PASS_COLOR)$<PASS$(NO_COLOR)"

clean:
	$(RM) $(BIN)

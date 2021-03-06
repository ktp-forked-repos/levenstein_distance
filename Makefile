CC=gcc
CFLAGS=-c -Wall --std=c11 -Iinclude/
LDFLAGS=-lm
SOURCES=main.c levenstein_distance.c helper.c file_input.c cfg.c statistics.c
OBJECTS=$(SOURCES:.c=.o)
EXECUTABLE_DIR=bin
EXECUTABLE_NAME=levenstein-distance
EXECUTABLE=$(EXECUTABLE_DIR)/$(EXECUTABLE_NAME)
PYTHON_EXECUTABLE=python3
TESTS_ROOT=tests
TEST_RESULTS=results
INSTALL_PATH=/usr/bin

vpath %.c src
vpath %.h include


all: $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	mkdir -p $(EXECUTABLE_DIR)
	$(CC) $(OBJECTS) -o $@ $(LDFLAGS)

.c.o:
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm --force $(OBJECTS)

install:
	cp $(EXECUTABLE) $(INSTALL_PATH)

uninstall: $(INSTALL_PATH)/$(EXECUTABLE_NAME)
	rm --force $<

test:
	[ -f $(EXECUTABLE) ]
	"$(PYTHON_EXECUTABLE)" -mrobot --variable APP_EXECUTABLE_NAME:"$(realpath $(EXECUTABLE))" --pythonpath "$(TESTS_ROOT)/resources" -d "$(TESTS_ROOT)/$(TEST_RESULTS)" "$(TESTS_ROOT)/testcases/*.robot"

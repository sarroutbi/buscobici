CC=g++
CCFLAGS=-ggdb
TEST_POST=test_post
LIBS=$(shell curl-config --libs)

all: $(TEST_POST)

$(TEST_POST): test_post.cpp
	$(CC) $(CCFLAGS) -o $@ $< $(LIBS)

clean:
	rm -f $(TEST_POST) *.*~

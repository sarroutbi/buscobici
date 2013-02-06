CC=g++
CCFLAGS=-ggdb
TEST_POST=test_post
LIBS=$(shell curl-config --libs)

$(TEST_POST): test_post.cpp
	$(CC) $(CCFLAGS) -o $@ $< $(LIBS)

clean:
	rm $(TEST_POST)

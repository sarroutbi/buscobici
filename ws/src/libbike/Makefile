CC=g++
CCFLAGS=-ggdb
OUTPUT_DIR=o
SRC_DIR=src
TEST_DIR=test
LIB_BIKE=$(OUTPUT_DIR)/libbike.so
TEST_LIB_BIKE=$(OUTPUT_DIR)/test_libbike
LIB_BIKE_SRC=$(wildcard $(SRC_DIR)/*.cpp)
TEST_LIB_BIKE_SRC=$(wildcard $(TEST_DIR)/*.cpp)
LIB_BIKE_INC=-I. -Isrc
CURL_LIBS=$(shell curl-config --libs)

all: $(OUTPUT_DIR) $(LIB_BIKE) $(TEST_LIB_BIKE)

$(LIB_BIKE): $(LIB_BIKE_SRC)
	$(CC) $(CCFLAGS) $(LIB_BIKE_INC) -o $@ $^ -shared

$(OUTPUT_DIR): 
	@mkdir -p $(OUTPUT_DIR)

$(TEST_LIB_BIKE): $(TEST_LIB_BIKE_SRC)
	$(CC) $(CCFLAGS) $(LIB_BIKE_INC) -o $@ $^ -L$(OUTPUT_DIR) -lbike $(CURL_LIBS)

clean:
	rm -rf $(LIB_BIKE) *~ $(TEST_DIR)/*.*~ $(SRC_DIR)/*.*~ $(OUTPUT_DIR)

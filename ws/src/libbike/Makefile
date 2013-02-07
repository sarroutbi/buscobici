CC=g++
CCFLAGS=-ggdb
LIB_BIKE=libbike.so
LIB_BIKE_SRC=Bike.cpp
LIB_BIKE_INC=-I.

all: $(LIB_BIKE)

$(LIB_BIKE): $(LIB_BIKE_SRC)
	$(CC) $(CCFLAGS) $(LIB_BIKE_INC) -o $@ $< -shared

clean:
	rm -f $(LIB_BIKE) *.*~

WS_DIR=webservice
LIB_DIR=libbike
TEST_DIR=test

all:
	make -C $(LIB_DIR)
	make -C $(TEST_DIR)
	make -C $(WS_DIR)
clean:
	make -C $(LIB_DIR) clean
	make -C $(TEST_DIR) clean
	make -C $(WS_DIR) clean

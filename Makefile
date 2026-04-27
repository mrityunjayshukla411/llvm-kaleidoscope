SRC_DIR := src
INC_DIR := include
BIN_DIR := bin
OBJ_DIR := obj
EXE     := $(BIN_DIR)/kal

CXX      := clang++
CXXFLAGS := $(shell llvm-config --cxxflags) -I$(INC_DIR)
LDFLAGS  := $(shell llvm-config --ldflags --system-libs --libs all)

SRCS := $(wildcard $(SRC_DIR)/*.cpp)
OBJS := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRCS))

.PHONY: all clean

all: $(EXE)

$(EXE): $(OBJS)
	@mkdir -p $(BIN_DIR)
	$(CXX) $^ $(LDFLAGS) -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)


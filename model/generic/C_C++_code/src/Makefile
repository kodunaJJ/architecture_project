##############################
## THIS IS A BASIC MAKEFILE ##
##############################

## Commands and compile settings ##

#FMT = clang-format -i -style=file
CXX = g++
CXXFLAGS = -std=c++11 -Wall -Werror
# Uncomment the following to compile in debug mode with no optimizations
# (for instance, this is useful to better track memory leaks):
# DFLAGS = -g -O0
IDIR=../inc

IPATHS = -I$(IDIR).
LPATHS = -L.
# LDFLAGS =


## Files and resources ##

HPP_FILES := $(shell find ../inc -type f -name "*.hpp")
CPP_FILES := $(shell find . -type f -name "*.cpp")
OBJ_FILES := $(CPP_FILES:%.cpp=%.o)


## Phony targets ##

.PHONY: all format compile run check clean


## Entry point ##

all: run


## Targets ##

format:
	@echo "$@ ..."
	$(foreach f,$(HPP_FILES),$(FMT) $(f) ;)
	$(foreach f,$(CPP_FILES),$(FMT) $(f) ;)

compile: cnn_cifar10_main

$(OBJ_FILES): %.o: %.cpp
	$(CXX) $(CXXFLAGS) $(DFLAGS) $(IPATHS) -o $@ -c $<

cnn_cifar10_main: $(OBJ_FILES)
	$(CXX) $(CXXFLAGS) $(DFLAGS) $(IPATHS) $(LPATHS) $(OBJ_FILES) -o $@ $(LDFLAGS)

run: compile
	@echo "$@ ..."
	@echo ""
	@./cnn_cifar10_main
	@echo ""

clean:
	@echo "$@ ..."
	$(shell find . -type f -name "*.exe" -delete)
	$(shell find . -type f -name "*.o" -delete)
	$(shell find . -type f -name "*.a" -delete)
	$(shell find . -type f -name "*.so" -delete)

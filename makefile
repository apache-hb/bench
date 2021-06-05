GXX = g++
CXX = clang++

CXXFLAGS = -O3 -march=native

DUMP = objdump -D -Mintel
BENCH = hyperfine

gcc:
	mkdir -p gcc-build
	$(GXX) $(CXXFLAGS) effect.cpp -c -o gcc-build/effect.o
	$(GXX) $(CXXFLAGS) main.cpp gcc-build/effect.o -o gcc-build/exec
	$(DUMP) gcc-build/exec > gcc-build/dump.txt

llvm:
	mkdir -p llvm-build
	$(CXX) $(CXXFLAGS) effect.cpp -c -o llvm-build/effect.o
	$(CXX) $(CXXFLAGS) main.cpp llvm-build/effect.o -o llvm-build/exec
	$(DUMP) llvm-build/exec > llvm-build/dump.txt

bench: llvm gcc
	$(BENCH) llvm-build/exec gcc-build/exec
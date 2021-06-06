GXX = g++
CXX = clang++

CXXFLAGS = -march=native

DUMP = objdump -D -Mintel
BENCH = hyperfine --min-runs 200 --warmup 100

SRC = effect.cpp main.cpp

gcc: $(SRC)
	mkdir -p gcc-build
	$(GXX) $(CXXFLAGS) effect.cpp -c -o gcc-build/effect.o -O3
	$(GXX) $(CXXFLAGS) main.cpp gcc-build/effect.o -o gcc-build/exec -O3
	$(DUMP) gcc-build/exec > gcc-build/dump.txt

llvm-o3: $(SRC)
	mkdir -p llvm-build-o3
	$(CXX) $(CXXFLAGS) effect.cpp -c -o llvm-build-o3/effect.o -O3
	$(CXX) $(CXXFLAGS) main.cpp llvm-build-o3/effect.o -o llvm-build-o3/exec -O3
	$(DUMP) llvm-build-o3/exec > llvm-build-o3/dump.txt

llvm-o0: $(SRC)
	mkdir -p llvm-build-o0
	$(CXX) $(CXXFLAGS) effect.cpp -c -o llvm-build-o0/effect.o -O0
	$(CXX) $(CXXFLAGS) main.cpp llvm-build-o0/effect.o -o llvm-build-o0/exec -O0
	$(DUMP) llvm-build-o0/exec > llvm-build-o0/dump.txt


bench: llvm-o3 llvm-o0 gcc
	$(BENCH) llvm-build-o3/exec gcc-build/exec llvm-build-o0/exec
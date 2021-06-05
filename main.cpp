extern "C" long effect(long, long, long, long, long, long, long, long, long, long, long, long);

int main() {
    for (long i = 0; i < 10000; i++) {
        effect(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
    }
}

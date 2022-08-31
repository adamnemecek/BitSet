//
//  main.cpp
//  BitSet
//
//  Created by Adam Nemecek on 8/30/22.
//

#include <iostream>

#define bitsizeof(v) (sizeof(v) * 8)
#define bitset(byte, nbit)   ((byte) |=  (1<<(nbit)))
#define bitclear(byte, nbit) ((byte) &= ~(1<<(nbit)))
#define bitflip(byte, nbit)  ((byte) ^=  (1<<(nbit)))
#define bitcheck(byte, nbit) ((byte) &   (1<<(nbit)))

struct BitSet128 {
private:
    uint64_t hi;
    uint64_t lo;

public:
    BitSet128(uint64_t _hi, uint64_t _lo): hi(_hi), lo(_lo) { }

    BitSet128(): BitSet128(0, 0) { }

    const uint64_t count() const {
        const int a = __builtin_popcountll(hi);
        const int b = __builtin_popcountll(lo);
        return a + b;
    }

    int leadingZeroBitCount() {
        if (hi == 0) {
            return __builtin_clzll(lo) + bitsizeof(uint64_t);
        }
        return __builtin_clzll(hi);
    }

    int trailingZeroBitCount() const {
        if (lo == 0) {
            return __builtin_clzll(hi) + bitsizeof(uint64_t);
        }
        return __builtin_clzll(lo);
    }

    void insert(uint8_t v) {
        const auto bs = bitsizeof(uint64_t);

        if (v > bs) {
            bitset(hi, v - bs);
        } else {
            bitset(lo, v);
        }
    }

    void remove(uint8_t v) {

    }

    uint8_t removeFirst() {
        auto l = leadingZeroBitCount();
        remove(l);
        return l;
    }

    uint8_t removeLast() {
        auto l = trailingZeroBitCount();
        remove(l);
        return l;
    }

    bool contains(uint8_t v) const {
        const auto bs = bitsizeof(uint64_t);

        if (v > bs) {
            return bitcheck(hi, v - bs);
        } else {
            return bitcheck(lo, v);
        }
    }
};

int main(int argc, const char * argv[]) {
    // insert code here...
//    std::cout << "Hello, World!\n";
    auto v = BitSet128();
    v.insert(10);

    printf("%d\n", v.contains(10));
    printf("%d\n", v.contains(11));


    return 0;
}

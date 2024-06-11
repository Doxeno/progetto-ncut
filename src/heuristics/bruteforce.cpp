#include "utils.hpp"
#include <cstddef>
#include <iostream>
#include <vector>

using std::vector;

int main(int argc, char** argv){

    if(argc < 2){
        std::cerr << "Usage:  greedy adj_matrix.m" << std::endl;
        std::cerr << "\t Where  adj_matrix.m is a matlab-style matrix" << std::endl;
        return 0;
    }

    std::string filename(argv[1]);
    auto matrix = read_matrix(filename);
    std::cerr << "Read matrix of size " << matrix.size() << " from " << filename << std::endl;
    size_t n = matrix.size();

    if(matrix.size() > 32){
        std::cerr << "Matrix too large, max size for bruteforce is 32" << std::endl;
        return 0;
    }

    double maxCut = 0;
    for(size_t bitmask = 0; bitmask < (1ULL << n); ++bitmask){
        vector<bool> partition(n, 0);
        for(size_t i = 0; i < n; ++i)partition[i] = (bitmask>>i)&1;
        maxCut = std::max(maxCut, normalizedCut(matrix, partition));
    }

    std::cout << maxCut << std::endl;
}

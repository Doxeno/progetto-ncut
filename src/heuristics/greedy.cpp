#include "utils.hpp"
#include <algorithm>
#include <cstddef>
#include <iostream>
#include <vector>

using std::vector;

int main(int argc, char** argv){

    if(argc < 2){
        std::cerr << "Usage:  greedy testname" << std::endl;
        std::cerr << "Where testname.mat is a matlab-style matrix" << std::endl;
        return 0;
    }

    std::string filename(argv[1]);
    auto matrix = read_matrix(filename + ".mat");
    std::cerr << "GREEDY: \tRead matrix of size " << matrix.size() << " from " << filename << std::endl;

    size_t n = matrix.size();
    vector<bool> partition(n,0);
    partition[0] = 1;
    double minCut = 2;
    vector<double> weights = matrix[0];

// A is initially set to {0}
// at each step, the node which minimises the sum of the weights
// of the edges that connect it to A is added to it.
//TODO: improve to O(n^2)

    for(size_t _ = 0; _ < n; ++_){
        size_t best_index = std::max_element(weights.begin(), weights.end()) - weights.begin();
        weights[best_index] = 0;
        partition[best_index] = 1;
        for(size_t i = 0; i < n; ++i)if(!partition[i])weights[i] += matrix[best_index][i];
        minCut = std::min(minCut, normalizedCut(matrix, partition));
    }

    std::cout << minCut << std::endl;
}

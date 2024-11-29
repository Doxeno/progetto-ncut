#include <algorithm>
#include <cstddef>
#include <iomanip>
#include <iostream>
#include <numeric>
#include <vector>

#include "utils.hpp"

using std::vector;

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "Usage:  greedy testname" << std::endl;
        std::cerr << "Where testname.mat is a matlab-style matrix" << std::endl;
        return 0;
    }

    std::string filename(argv[1]);
    auto matrix = read_matrix(filename + ".mat");
    std::cerr << "GREEDY: \tRead matrix of size " << matrix.size() << " from " << filename
              << std::endl;

    size_t n = matrix.size();
    vector<bool> partition(n, 0);
    partition[0] = 1;
    vector<double> weights = matrix[0];
    double assocA = std::accumulate(weights.begin(), weights.end(), double(0));
    double cut = assocA - matrix[0][0];
    double assocB = 0;
    for (size_t i = 1; i < n; ++i)
        assocB += std::accumulate(matrix[i].begin(), matrix[i].end(), double(0));
    double nCut = cut / assocA + cut / assocB;
    double minCut = nCut;

    // A is initially set to {0}
    // at each step, the node which minimises the sum of the weights
    // of the edges that connect it to A is added to it.

    for (size_t _ = 2; _ < n; ++_) {
        size_t best_index = std::max_element(weights.begin(), weights.end()) - weights.begin();
        weights[best_index] = 0;
        for (size_t i = 0; i < n; ++i) {
            assocB -= matrix[best_index][i];
            assocA += matrix[best_index][i];
            if (!partition[i]) {
                weights[i] += matrix[best_index][i];
                cut += matrix[best_index][i];
            } else {
                cut -= matrix[best_index][i];
            }
        }
        cut -= matrix[best_index][best_index];
        nCut = cut / assocA + cut / assocB;
        partition[best_index] = 1;
        minCut = std::min(nCut, minCut);
    }

    std::cout << std::fixed << std::setprecision(3);
    std::cout << minCut << std::endl;
}

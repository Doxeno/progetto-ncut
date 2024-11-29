#include "utils.hpp"
#include <cstddef>
#include <fstream>
#include <iomanip>
#include <ios>
#include <iostream>
#include <vector>

using std::vector;

int main(int argc, char** argv){

    if(argc < 2){
        std::cerr << "Usage:  greedy testname" << std::endl;
        std::cerr << "Where  testname.mat is a matlab-style matrix" << std::endl;
        std::cerr << "Outputs the mininum normalized cut and writes a partition that produces it to testname_opt.txt";
        return 0;
    }

    std::string filename(argv[1]);
    auto matrix = read_matrix(filename + ".mat");
    std::cerr << "BRUTEFORCE: \tRead matrix of size " << matrix.size() << " from " << filename << std::endl;
    std::ofstream part_file(filename + "_opt.txt");
    size_t n = matrix.size();

    if(matrix.size() > 24){
        std::cerr << "Matrix too large, max size for bruteforce is 24" << std::endl;
        return 0;
    }

    double minCut = 2;
    vector<bool> best;
    for(size_t bitmask = 0; bitmask < (1ULL << n); ++bitmask){
        vector<bool> partition(n, 0);
        for(size_t i = 0; i < n; ++i)partition[i] = (bitmask>>i)&1;
        double nCut = normalizedCut(matrix, partition);
        if(nCut < minCut){
            minCut = nCut;
            best = partition;
        }
    }

    vector<size_t> best_p;
    for(size_t i = 0; i < n; ++i){
        if(best[i])best_p.push_back(i+1);
        // matlab indices are wrong
    }
    for(size_t i = 1; i < best_p.size(); ++i){
        part_file << best_p[i-1] << ',';
    }
    if(!best_p.empty())part_file << best_p.back();
    part_file << std::endl;
    part_file.close();


    std::cout << std::fixed << std::setprecision(3);
    std::cout << minCut << std::endl;
}

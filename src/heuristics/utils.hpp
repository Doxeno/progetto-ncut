#include <fstream>
#include <cassert>
#include <string>
#include <vector>
#include <algorithm>

using std::vector;

vector<vector<double>> read_matrix(std::string filename){
    std::ifstream in(filename);
    vector<vector<double>> ret;

    for(std::string line; std::getline(in, line);){
        ret.push_back({});
        for(auto first_c = line.begin(); first_c < line.end(); ++first_c){
            auto next_comma = std::find(first_c, line.end(), ',');
            ret.back().emplace_back(std::stod(std::string(first_c, next_comma)));
            first_c = next_comma;
        }
    }

    for(auto x: ret)
        assert(x.size() == ret.size());

    return ret;
}

double normalizedCut (const vector<vector<double>> &matrix, const vector<bool> &partition){
    const size_t n = matrix.size();
    double cut = 0;
    double assocA = 0;
    double assocB = 0;
    for(size_t i = 0; i < n; ++i)for(size_t j = 0; j < n; ++j){
        if(partition[i]){
            assocA += matrix[i][j];
            if(!partition[j])cut += matrix[i][j];
        }
        if(!partition[i])assocB += matrix[i][j];
    }
    if(assocA == 0 || assocB == 0)return 2;
    return cut/assocA + cut/assocB;
}

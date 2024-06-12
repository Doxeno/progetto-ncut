#! /bin/bash
usage="Usage: ./benchmark.sh testname.
The script will use the matrix in benchmarks/testname.mat
Note: run this script in the repo's root"

testname="benchmarks/"$1
cluster_file=$1"._cluster.txt"

if [[ -e $testname".mat" && -z $2 ]]; then
    src/heuristics/greedy $testname
    src/heuristics/bruteforce $testname
    src/main.m $testname
elif [ -z $1 ]; then
    echo -e "$usage"
elif [ -z $2 ]; then
    echo $testname".mat" does not exist.
else
    echo -e "$usage"
fi


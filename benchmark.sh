#! /bin/bash
usage="Usage: ./benchmark.sh testname.
The script will use the matrix in benchmarks/testname.mat
Note: run this script in the repo's root"

testname="benchmarks/"$1
cluster_file=$1"._cluster.txt"

if [[ -e $testname".mat" && -z $2 ]]; then
    if [ -e $testname"_cluster.txt" ]; then
        echo -e "Ad-hoc matrix, estimated best nCut:"
        cat $testname"_adhoc_res.txt"
        echo -e "Diff: "
        diff --color $testname"_cluster.txt" $testname"_res.mat"
    fi
    src/heuristics/bruteforce $testname
    echo
    src/main.m $testname
    echo
    src/heuristics/greedy $testname
    echo
    src/heuristics/shuffle $testname
elif [ -z $1 ]; then
    echo -e "$usage"
elif [ -z $2 ]; then
    echo $testname".mat" does not exist.
else
    echo -e "$usage"
fi


#! /bin/bash
usage="Usage: ./benchmark.sh testname.
The script will use the matrix in testname.mat
Note: run this script in the repo's root"

filename=$1".mat"
cluster_file=$1"._cluster.txt"

if [[ -d $filename && -z $2 ]]; then
# TODO: actual script
elif [ -z $1 ]; then
    echo -e "$usage"
elif [ -z $2 ]; then
    echo $filename does not exist.
else
    echo -e "$usage"
fi


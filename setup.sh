#! /bin/sh

cd benchmarks
wget https://snap.stanford.edu/data/facebook_combined.txt.gz
gzip -d facebook_combined.txt.gz
../data/create_matrix.py facebook_combined.txt 4039 > facebook.mat
rm facebook_combined.txt

# default settings
../data/adhoc.py 200 adhoc_200
../data/adhoc.py 300 adhoc_300
../data/adhoc.py 400 adhoc_400
../data/adhoc.py 500 adhoc_500

# high noise
../data/adhoc.py 200 noise_200 0 1 2 10
../data/adhoc.py 300 noise_300 0 1 2 10
../data/adhoc.py 400 noise_400 0 1 2 10
../data/adhoc.py 500 noise_500 0 1 2 10

cd ..

make -C src/heuristics

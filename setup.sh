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

# medium noise
../data/adhoc.py 200 med_noise_200 0 1 2 2
../data/adhoc.py 300 med_noise_300 0 1 2 2
../data/adhoc.py 400 med_noise_400 0 1 2 2
../data/adhoc.py 500 med_noise_500 0 1 2 2


# small random matrices
../data/random_matrix.py random_10 10
../data/random_matrix.py random_11 11
../data/random_matrix.py random_12 12
../data/random_matrix.py random_14 14
../data/random_matrix.py random_16 16
../data/random_matrix.py random_18 18
../data/random_matrix.py random_20 20

cd ..

make -C src/heuristics

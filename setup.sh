#! /bin/sh

#TODO: everything in here is outdated

cd data/facebook

wget https://snap.stanford.edu/data/facebook_combined.txt.gz
gzip -d facebook_combined.txt.gz

./create_matrix.py facebook_combined.txt 4039 > facebook.mat
rm facebook_combined.txt

cd ../adhoc

./adhoc.py 200 adhoc_200
./adhoc.py 300 adhoc_300
./adhoc.py 400 adhoc_400
./adhoc.py 500 adhoc_500

cd ../..

#! /bin/sh

cd benchmarks
if [ ! -f facebook.mat ]; then
wget https://snap.stanford.edu/data/facebook_combined.txt.gz
gzip -d facebook_combined.txt.gz
../data/create_matrix.py facebook_combined.txt 4039 > facebook.mat
rm facebook_combined.txt
fi

if [ ! -f email.mat ]; then
wget https://snap.stanford.edu/data/email-Eu-core-temporal.txt.gz
gzip -d email-Eu-core-temporal.txt.gz
../data/email_graph.py email-Eu-core-temporal.txt 1005 > email.mat
rm email-Eu-core-temporal.txt
fi

# default settings
# low = 0.05, hi = 0.1, noise = 0.1
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
../data/adhoc.py 400 med_noise_400 0 2 3 2
../data/adhoc.py 500 med_noise_500 0 2 3 2


# small random matrices
../data/random_matrix.py random_10 10
../data/random_matrix.py random_11 11
../data/random_matrix.py random_12 12
../data/random_matrix.py random_14 14
../data/random_matrix.py random_15 15
../data/random_matrix.py random_16 16
../data/random_matrix.py random_17 17
../data/random_matrix.py random_18 18
../data/random_matrix.py random_19 19
../data/random_matrix.py random_20 20

../data/random_matrix.py random_200 200
../data/random_matrix.py random_300 300
../data/random_matrix.py random_400 400
../data/random_matrix.py random_500 500
../data/random_matrix.py random_600 600
../data/random_matrix.py random_700 700
../data/random_matrix.py random_1000 1000
../data/random_matrix.py random_2000 2000
../data/random_matrix.py random_3000 3000
../data/random_matrix.py random_4000 4000
../data/random_matrix.py random_5000 5000
../data/random_matrix.py random_6000 6000
../data/random_matrix.py random_7000 7000
../data/random_matrix.py random_8000 8000
../data/random_matrix.py random_9000 9000
../data/random_matrix.py random_10000 10000
../data/random_graph.py graph_1 200 1000
../data/random_graph.py graph_2 300 1000
../data/random_graph.py graph_3 400 9000
../data/random_graph.py graph_4 500 5000
../data/random_graph.py graph_5 500 8000
../data/random_graph.py graph_6 500 9000
../data/random_graph.py graph_7 500 10000
../data/random_graph.py graph_8 500 20000
../data/random_graph.py graph_9 500 30000
../data/random_graph.py graph_10 500 50000

cd ..

make -C src/heuristics
./complexity_plot.py
pdflatex relazione.tex
rm relazione.out
rm relazione.log
rm relazione.aux

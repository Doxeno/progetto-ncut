#!/bin/python3

from sys import argv, stderr
from random import randint, sample, uniform, seed

usage = """Parameters:
* N: number of nodes
* Name: this script will produce Name.mat and Name_cluster.txt
* s (optional, default 0): rng seed
* low (optional, default 0.05): edges between nodes in different cliques will have a random weight in [0, low]
* hi (optional, defualt 0.1): edges between nodes in the same clique will have a random weight in [0, hi]
* noise (optionale, default 0.1): every edge's weight will be increased by a random value in [0, noise]"""

if __name__ == "__main__":
    if len(argv) < 3:
        print(usage, file=stderr)
        exit(1)

    N = int(argv[1])
    filename = str(argv[2])

    low = 0.05
    hi = 0.1
    noise = 0.1
    sd = 0

    if len(argv) > 3:
        sd = int(argv[3])
    if len(argv) > 4:
        low = float(argv[4])
    if len(argv) > 5:
        hi = float(argv[5])
    if len(argv) > 6:
        noise = float(argv[6])

    seed(sd)

    mat = [[uniform(0,noise) for _ in range(N)] for _ in range(N)]

    cluster = sample(range(0,N), randint(1, N))
    compl = [i for i in range(N) if not i in cluster]

    if 0 not in cluster:
        cluster, compl = compl, cluster

    for i in cluster:
        for j in cluster:
            if i <= j:
                mat[i][j] += uniform(0, hi)
    for i in compl:
        for j in compl:
            if i <= j:
                mat[i][j] += uniform(0, low)

    for i in range(N):
        mat[i][i] = 0

    for i in range(N):
        for j in range(i):
            mat[j][i] = mat[i][j]


    cluster_file = open(filename + "_cluster.txt", "w")
    print(*sorted(list(map(lambda x: x+1, cluster))), file = cluster_file)

    matrix_file = open(filename + ".mat", "w")
    for row in mat:
        print(','.join(['{0:04f}'.format(x) for x in row]), file = matrix_file)

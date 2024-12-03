#!/bin/python3

from sys import argv, stderr
from random import uniform, seed, randint

usage = """Parameters:
* Name: this script will produce Name.mat and Name_cluster.txt
* N: number of nodes
* maxval (optional, default 1): values in the matrix will be in (0, maxval)
* s (optional, default 0): rng seed"""

if __name__ == "__main__":
    if len(argv) < 4:
        print(usage, file=stderr)
        exit(1)

    filename = str(argv[1])
    N = int(argv[2])
    M = int(argv[3])
    sd = 0
    maxval =1

    if len(argv) > 4:
        sd = int(argv[4])
    seed(sd)

    mat = [[0. for _ in range(N)] for _ in range(N)]

    for _ in range(M):
        i = randint(0,N-1)
        j = (i + randint(1, N-1)) % N
        if i < j:
            i,j = j,i
        mat[i][j] = uniform(0, maxval)

    for i in range(N):
        for j in range(i):
            mat[j][i] = mat[i][j]

    matrix_file = open(filename + ".mat", "w")
    for row in mat:
        print(','.join(['{0:04f}'.format(x) for x in row]), file = matrix_file)

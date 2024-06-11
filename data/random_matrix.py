#!/bin/python3

from sys import argv, stderr
from random import uniform, seed

usage = """Parameters:
* Name: this script will produce Name.mat and Name_cluster.txt
* N: number of nodes
* maxval (optional, default 1): values in the matrix will be in (0, maxval)
* s (optional, default 0): rng seed"""

if __name__ == "__main__":
    if len(argv) < 3:
        print(usage, file=stderr)
        exit(1)

    filename = str(argv[1])
    N = int(argv[2])
    sd = 0
    maxval =1

    if len(argv) > 3:
        maxval = float(argv[3])
    if len(argv) > 4:
        sd = int(argv[4])

    seed(sd)




    mat = [[uniform(0,maxval) for _ in range(N)] for _ in range(N)]
    for i in range(N):
        for j in range(i):
            mat[j][i] = mat[i][j]

    matrix_file = open(filename + ".mat", "w")
    for row in mat:
        print(','.join(['{0:04f}'.format(x) for x in row]), file = matrix_file)

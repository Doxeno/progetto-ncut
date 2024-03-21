#!/bin/python3

from sys import argv, stderr
from random import randint, sample, uniform, seed


if __name__ == "__main__":
    if len(argv) < 3:
        print("Usage: %s N seed" % argv[0], file=stderr)
        exit(1)

    N = int(argv[1])
    seed(int(argv[2]))
    
    mat = [[uniform(0,0.1) for i in range(N)] for j in range(N)]

    cluster = sample(range(0,N), randint(1, N))
    compl = [i for i in range(N) if not i in cluster]
    
    for i in cluster:
        for j in cluster:
            mat[i][j] += uniform(0, 0.1)
    for i in compl:
        for j in compl:
            mat[i][j] += uniform(0, 0.05)

    for i in range(N):
        mat[i][i] = 0

    for i in range(N):
        for j in range(i):
            mat[i][j] += mat[j][i]
            mat[j][i] = mat[i][j]


    print("Clusters: ", file = stderr)
    print(*sorted(list(map(lambda x: x+1, cluster))), file = stderr)
    print(*sorted(list(map(lambda x: x+1, compl))), file = stderr)

    for row in mat:
        print(','.join(['{0:04f}'.format(x) for x in row]))

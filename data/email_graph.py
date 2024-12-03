#!/bin/python3

from sys import argv, stderr


if __name__ == "__main__":
    if len(argv) < 3:
        print("Usage: %s edge_list.txt num_nodes" % argv[0], file=stderr)
        exit(1)

    f = open(argv[1])
    num_nodes = int(argv[2])

    mat = [[0 for i in range(num_nodes)] for j in range(num_nodes)]

    for line in f.readlines():
        a,b,_ = map(int, line.split())
        mat[a][b] += 1
        mat[b][a] += 1

    for row in mat:
        print(','.join(map(str,row)))

#!/bin/octave

warning('off', 'all');
source("src/partition.m");
args = argv();
matrix_file = [args{1} ".mat"];

graph = dlmread(matrix_file);

[cut, part] = partition(graph)

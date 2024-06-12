#!/bin/octave

warning('off', 'all');
source("src/partition.m");
args = argv();
matrix_file = [args{1} ".mat"];
output_file = [args{1} "_res.mat"];

graph = dlmread(matrix_file);

[cut, part] = partition(graph);
cut
dlmwrite(output_file, part');

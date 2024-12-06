#!/bin/octave

warning('off', 'all');
source("src/partition.m");
args = argv();
matrix_file = [args{1} ".mat"];
output_file = [args{1} "_res.mat"];

graph = dlmread(matrix_file);

tic
[cut, part] = partition(graph);
time = toc;
fprintf('NCut:\n%1.3f\n',cut)
fprintf('TIME:\n%1.4f seconds\n',time)
dlmwrite(output_file, part');

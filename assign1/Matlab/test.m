clear all; clc;

A = [1.2 0.9 -4; 1.6 1.2 3];
[U1, S1, V1] = svd(A);
[V, D] = eig(A * A');



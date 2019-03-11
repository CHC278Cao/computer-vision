function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
m = size(x1, 1);
A = zeros(2*m, 9);
for i = 1: m
    A(2*i-1, 1) = -x2(i, 1);
    A(2*i-1, 2) = -x2(i, 2);
    A(2*i-1, 3) = -1;
    A(2*i-1, 7) = x2(i,1)*x1(i, 1);
    A(2*i-1, 8) = x2(i,2)*x1(i, 1);
    A(2*i-1, 9) = x1(i, 1);
    A(2*i, 4) = -x2(i, 1);
    A(2*i, 5) = -x2(i, 2);
    A(2*i, 6)= -1;
    A(2*i, 7) = x2(i,1)*x1(i, 2);
    A(2*i, 8) = x2(i,2)*x1(i, 2);
    A(2*i, 9) = x1(i, 2);
end

[~, ~, V] = svd(A);
H = V(:, 9);
H2to1 = reshape(H, 3, 3)';
% temp1 = zeros(3, m);
% temp1(1:2, :) = x1';
% temp1(3, :) = ones(1, m);
% temp2 = zeros(3, m);
% temp2(1:2, :) = x2';
% temp2(3, :) = ones(1, m);
% temp = H2to1 * temp2;
% res = temp1 ./ temp;
end

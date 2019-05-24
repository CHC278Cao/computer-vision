function [M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = ...
                        rectify_pair(K1, K2, R1, R2, t1, t2)
% RECTIFY_PAIR takes left and right camera paramters (K, R, T) and returns left
%   and right rectification matrices (M1, M2) and updated camera parameters. You
%   can test your function using the provided script q4rectify.m

c1 = -(K1 * R1) \ (K1 * t1);
c2 = -(K2 * R2) \ (K2 * t2);

rotN1 = zeros(3, 3);
rotN1(:, 1) = (c1 - c2) ./ sum(sum((c1-c2) .^ 2));
rotN1(:, 2) = cross(R1(3,:)', rotN1(:, 1)) / sum(cross(R1(3,:)', rotN1(:, 1)));
rotN1(:, 3) = cross(rotN1(:, 1), rotN1(:, 2)) / sum(cross(rotN1(:, 1), rotN1(:, 2)));
rotN1 = rotN1';
kN1 = K2;
kN2 = K2;
tN1 = -rotN1 * c1;
tN2 = -rotN1 * c2;

M1 = (kN1 * rotN1) / (K1 * R1);
M2 = (kN2 * rotN1) / (K2 * R2);
K1n = kN1;
K2n = kN2;
R1n = rotN1;
R2n = rotN1;
t1n = tN1;
t2n = tN2;
end


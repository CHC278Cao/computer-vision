function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

%% scale data
num = size(pts1, 1);
% norm1 = zeros(size(pts1));
norm1 = pts1 ./ M;

% norm2 = zeros(size(pts2));
norm2 = pts2 ./ M;

%% construct the function matrix
matrix = zeros(num, 9);
for i = 1: num
    matrix(i, 1) = norm1(i, 1) * norm2(i, 1);
    matrix(i, 2) = norm1(i, 1) * norm2(i, 2);
    matrix(i, 3) = norm1(i, 1);
    matrix(i, 4) = norm1(i, 2) * norm2(i, 1);
    matrix(i, 5) = norm1(i, 2) * norm2(i, 2);
    matrix(i, 6) = norm1(i, 2);
    matrix(i, 7) = norm2(i, 1);
    matrix(i, 8) = norm2(i, 2);
    matrix(i, 9) = 1;
end

[~, ~, V] = svd(matrix);
H = V(:, 9);
temp = reshape(H, 3, 3)';

% fr = refineF(temp, norm1, norm2);

%% rank 2 constrain
% [U, s, V] = svd(fr);
[U, s, V] = svd(temp);
sn = s;
sn(3, 3) = 0;
fn = U * sn * V';

fn = refineF(fn, norm1, norm2);

K = [1/M 0 0; 0 1/M 0; 0 0 1];
F = K'*fn*K;


end
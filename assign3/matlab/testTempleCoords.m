% A test script using templeCoords.mat
clear all; clc;
%% load images and points
imgPath1 = '../data/im1.png';
imgPath2 = '../data/im2.png';
pointfile = '../data/someCorresp.mat';
img1 = imread(imgPath1);
img2 = imread(imgPath2);
data = load(pointfile);
pts1 = data.pts1;
pts2 = data.pts2;

[h, w, c] = size(img1);
M = max(h, w);
%% calculate the essential matrix
F = eightpoint(pts1, pts2, M);
% displayEpipolarF(img1, img2, F);

%% calculate the epipolar points in images2
ps2 = epipolarCorrespondence(img1, img2, F, pts1);
% [coordsIM1, coordsIM2] = epipolarMatchGUI(img1, img2, F);

%% compute the essential materix
intxmatrixpath = '../data/intrinsics.mat';
intxmatrix = load(intxmatrixpath);
k1 = intxmatrix.K1;
k2 = intxmatrix.K2;
E = essentialMatrix(F, k1, k2);

%% triangulation
ext1 = [1 0 0 0; 0 1 0 0; 0 0 1 0];
ext2 = camera2(E);
p1 = k1 * ext1;
nt = size(ext2, 3);

nums = size(pts1, 1);
extind = 0;
pts3d = zeros(nums, 3);
temp = zeros(nums, 3);
maxcn = 0;
% find the exstinct matrix 
for i = 1: nt
    p2 = k2 * ext2(:,:, i);
    temp = triangulate(p1, pts1, p2, pts2);
    sumPos = sum(temp(:, 3) > 0);
    if sumPos > maxcn
        maxcn = sumPos;
        pts3d = temp;
        extind = i;
    end
end

ext = ext2(:, :, extind);

pts3 = [pts3d(:, :) ones(nums, 1)];
pts1M = p1 * pts3';
pts2M = k2 * ext * pts3';
pts1M = pts1M';
pts2M = pts2M';
dataRej1 = zeros(size(pts1M));
dataRej2 = zeros(size(pts2M));
for ind = 1: nums
    dataRej1(ind, :) = pts1M(ind, :) / pts1M(ind, 3);
    dataRej2(ind, :) = pts2M(ind, :) / pts2M(ind, 3);
end

err = sum(sum(((pts1 - dataRej1(:, 1:2)) .^ 2))) + sum(sum(((pts2 - dataRej2(:, 1:2)) .^ 2)));
    

%% plot the 3D points with plot3 function 
x = pts3d(:, 1);
y = pts3d(:, 2);
z = pts3d(:, 3);
figure;
plot3(x, y, z, '*');

% save extrinsic parameters for dense reconstruction
R1 = ext1(:, 1:3);
t1 = ext1(:, 4);
R2 = ext(:, 1:3);
t2 = ext(:, 4);
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');

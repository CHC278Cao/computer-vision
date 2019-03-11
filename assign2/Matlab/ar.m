% Q3.3.1
clear all; clc;

%% read movie and images
target = '../data/book.mov';
source = '../data/ar_source.mov';
source_mov = loadVid(source);
m = size(source_mov, 2);
target_mov = loadVid(target);
n = size(target_mov, 2);
cv_img = imread('../data/cv_cover.jpg');


%% match feature
[h, w] = size(cv_img);
[ht, wt, ch] = size(target_mov(1).cdata);
output = zeros(ht, wt, ch, n);

for i = 1: n-m
    output(:, :, :, i) = target_mov(i).cdata; 
end

for i = n-m+1: n
    temp_t = target_mov(i).cdata;
    [locs1, locs2] = matchPics(cv_img, temp_t);
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
    
    temp_s = source_mov(i+m-n).cdata;
    temp_s_resize = imresize(temp_s, [h w]);
    im = compositeH(inv(bestH2to1), temp_s_resize, temp_t);
    output(:, :, :, i) = im;
end




    
function [img1] = myImageFilter(img0, h)
[height, width] = size(img0);

img = zeros(height, width);
[m, n] = size(h);
hm = floor(m / 2);
hn = floor(n / 2);
paddingImg = zeros(2*hm+height, 2*hn+width);

%% construct the padding image
% construct the middle area
paddingImg(hm+1:hm+height, hn+1:hn+width) = img0;
% construct the top padding
for i = 1: hm
    paddingImg(i, hn+1:hn+width) = img0(1, :);
end
% construct the down padding
for i = hm+height+1: height+2*hm
    paddingImg(i, hn+1:hn+width) = img0(height, :);
end
% construct the left padding
for j = 1: hn
    paddingImg(:, j) = paddingImg(:, hn+1);
end
% construct the right padding
for j = hn+width+1: 2*hn+width
    paddingImg(:, j) = paddingImg(:, hn+width);
end

%% calculate convolution
sigmaRotate = zeros(m, n);
for i = 1: m
    sigmaRotate(i, :) = h(m-i+1, end:-1:1);
end

for i = 1: height
    for j = 1: width
        temp = paddingImg(i:i+m-1, j:j+n-1) .* sigmaRotate(1:end, 1:end);
        img(i, j) = sum(temp(:));
    end
end

img1 = img;
end

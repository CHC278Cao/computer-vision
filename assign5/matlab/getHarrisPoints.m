function [points] = getHarrisPoints(I, alpha, k)
if size(I, 3) == 3
    I = rgb2gray(I);
end
I = double(I);
[height, width] = size(I);
dx = [-1 0 1; -1 0 1; -1 0 1];
dy = dx';
Ix = imfilter(I, dx);
Iy = imfilter(I, dy);
g = fspecial('gaussian', 5, 2);
Ixx = imfilter(Ix.^2, g);
Iyy = imfilter(Iy.^2, g);
IxIy = imfilter(Ix.*Iy, g);

detM = Ixx .* Iyy - IxIy.^2;
trace_M = Ixx + Iyy;
R = detM - k*(trace_M.^2);

res = zeros(alpha, 3);
cnt = 0;
for i = 2: height-1
    for j = 2: width-1
        if R(i, j) > R(i-1, j) && R(i, j) > R(i, j-1) && ...
                R(i, j) > R(i+1, j) && R(i, j) > R(i, j+1)
            cnt = cnt+1;
            res(cnt, 1) = j;
            res(cnt, 2) = i;
            res(cnt, 3) = R(i, j);
        end
    end
end
res = sortrows(res, 3, 'descend');
points = res(1: alpha, 1: 2);

end
 
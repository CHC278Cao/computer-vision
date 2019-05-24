function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
im1 = double(im1) / 255.0;
im2 = double(im2) / 255.0;
[m, n] = size(pts1);
[h, w, c] = size(im2);
ptsn3 = zeros(m, n+1);
ptsn3(:, 1:n) = pts1;
ptsn3(:, end) = 1;

sizet = 7;
wi = floor(sizet/2);
des = zeros(m, n);

for i = 1: m
    x = ptsn3(i, :);
    epiline = F * x'; % get the epipolar line in second image
    temp = [];
    
    % calculate points locating on epipolar line
    for height = 1: h
        for width = 1: w
            ps = [width height 1];
            if abs(ps * epiline) * max(h, w) < 1
                temp = [temp; ps];
            end
        end
    end
    
    % get the most matched points in epipolar line
    sub1 = im1(x(2)-wi:x(2)+wi, x(1)-wi:x(1)+wi,:);
    minind = 1;
    minmum = 100;
    num = size(temp, 1);
    temp = temp(:, 1:2);
    for ind = 1: num
        data = temp(ind, :);
        if (data(1) <= wi) || (data(2) <= wi) || (data(1) >= w - wi-1) || (data(2) >= h - wi-1)
            continue;
        else
            patch = im2(data(2)-wi:data(2)+wi, data(1)-wi:data(1)+wi, :);
            diff = sum(sum(sum((sub1 - patch) .^ 2)));
            if diff < minmum
                minind = ind;
                minmum = diff;
            end
        end
    end
    des(i,:) = temp(minind, :);
                    
                
end
pts2 = des;
end
    
    


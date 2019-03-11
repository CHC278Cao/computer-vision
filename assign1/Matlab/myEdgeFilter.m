function [img1] = myEdgeFilter(img0, sigma)
%Your implemention
img = img0;
% construct the gaussian filter
hsize = 2 * ceil(3 * sigma) + 1;
h = fspecial('gaussian', hsize, sigma);

imgBur = myImageFilter(img, h);
% subplot(311);
% imshow(imgBur);
sobel = [-0.5 0 0.5];
% sobery = fspecial('sobel');
% soberx = sobery';

imgx = myImageFilter(imgBur, sobel);
imgy = myImageFilter(imgBur, sobel');
Mimg = sqrt((imgx .^2) + (imgy .^ 2));
% subplot(211);
% imshow(Mimg);


%% non_maximum suppression
[height, width] = size(Mimg);
output = zeros(height, width);
gradientDect = atan(imgy ./ imgx) * 180/pi;
output(1, :) = Mimg(1, :);
output(height, :) = Mimg(height, :);
output(:, 1) = Mimg(:, 1);
output(:, width) = Mimg(:, width);
for i = 2: height-1
    for j = 2: width-1
        center = Mimg(i, j);
        if ((gradientDect(i, j) >= -22.5 && gradientDect(i, j) <= 22.5))
            leftSide = Mimg(i-1, j);
            rightSide = Mimg(i+1, j);
            if ((center - leftSide) > 0 &&  (center - rightSide) > 0)
                output(i, j) = center;
            else
                output(i, j) = 0;
            end
        elseif (gradientDect(i, j) >= 22.5 && gradientDect(i, j) <= 67.5)        
            leftSide = Mimg(i+1, j-1);
            rightSide = Mimg(i-1, j+1);
            if ((center - leftSide) > 0 &&  (center - rightSide) > 0)
                output(i, j) = center;
            else
                output(i, j) = 0;
            end
        elseif (gradientDect(i, j) >= -67.5 && gradientDect(i, j) <= -22.5)
            leftSide = Mimg(i-1, j-1);
            rightSide = Mimg(i+1, j+1);
            if ((center - leftSide) > 0 &&  (center - rightSide) > 0)
                output(i, j) = center;
            else
                output(i, j) = 0;
            end
        else
            leftSide = Mimg(i-1, j);
            rightSide = Mimg(i+1, j);
            if ((center - leftSide) > 0 &&  (center - rightSide) > 0)
                output(i, j) = center;
            else
                output(i, j) = 0;
            end
        end
    end
end

img1 = output;
% subplot(212);
% imshow(img1);
end
    
                
        
        

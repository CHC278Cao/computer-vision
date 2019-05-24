function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
res = zeros(size(im1));
paddingSize = (windowSize - 1)/2;
im1pad = padarray(im1, [paddingSize, paddingSize], 0, 'both');
im2pad = padarray(im2, [paddingSize+maxDisp, paddingSize], 0, 'both');
for i = paddingSize+1: (size(im1pad, 1)-paddingSize)
    for j = paddingSize+maxDisp+1: (size(im1pad, 2)-paddingSize)
        min = inf;
        d = 0;
        im1patch = im1pad(i-paddingSize: i+paddingSize, j-paddingSize: j+paddingSize);
        for x = 0: maxDisp
            im2patch = im2pad(i-paddingSize: i+paddingSize, j-paddingSize-x: j+paddingSize-x);
            temp = sum(sum((im1patch-im2patch) .^ 2));
            if temp < min
                min = temp;
                d = x;
            end
        end
        res(i-paddingSize, j-paddingSize-maxDisp) = d;
    end
end
dispM= res;
end
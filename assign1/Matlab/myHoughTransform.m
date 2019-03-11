function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
% Im - grayscale image
% threshold - threshold value that determines if the point should be 
% voted as a line
% rhoRes - the resolution of hough transform accumulator for radius
% thetaRes - the resolution of hough transform accumulator for angular
% H - the accumulator for all possible lines
% rhoScale - interval for radius
% thetaScale - interval for angular
[h, w] = size(Im);
max_rho = sqrt(h.^2 + w.^2);
rholen = ceil(max_rho/rhoRes) + 1;
thetalen = ceil(2*pi/thetaRes) + 1;

H = zeros(rholen, thetalen);
rhoScale = 0: rhoRes: rholen*rhoRes;
thetaScale = 0: thetaRes: thetalen*thetaRes;

for x = 1: h
    for y = 1: w
        if Im(x, y) >= threshold
            for j = 1: thetalen
                theta = thetaScale(j);
                p = x * cos(theta) + y * sin(theta);
                if p >= 0
                    low = floor(p/rhoRes) + 1; % matrix starts at 1 in matlab
                    high = ceil(p/rhoRes) + 1;
                    if p - low*rhoRes >= high*rhoRes
                        i = high;
                    else
                        i = low;
                    end
                    H(i, j) = H(i, j) + 1;
                end
            end
        end
    end
end          


end
        
        
function [rhos, thetas] = myHoughLines(H, nLines)
%H - hough accumalator
%nLines - number of desired lines
%rhos - cooperate rhos for line
%thetsa - cooperate thetas for line

regmax = imregionalmax(H); % return binary matrix 
Hmax = H .* regmax;


[~, sortInd] = sort(Hmax(:), 'descend');
maxInd = sortInd(1: nLines);
[rhos, thetas] = ind2sub(size(Hmax), maxInd);


end
      
function [dist] = getImageDistance(hist1, histSet, method)

distance = dist2(histSet, hist1, 'euclidean');
if method == 'euclidean'
    dist = distance;
elseif method == 'chi2'
    dist = distance .^ 2;
else
    disp("wrong input for method options, using either 'euclidean' or 'chi2'");
    return;
end
end

function [dictionary] = getDictionary(imgPaths, alpha, K, method)
numImg = size(imgPaths, 2);
filterBank = createFilterBank();
numFilter = size(filterBank, 1);
k = 0.05;
res = zeros(numImg*alpha, 3*numFilter);
for i = 1: numImg
    im = imread(imgPaths{i});
    if (size(im, 3) == 1)
        im = cat(3, im, im, im);
    end
    imgBank = extractFilterResponses(im, filterBank);
    
    if method == 'random'
        points = getRandomPoints(im, alpha);
    elseif method == 'harris'
        points = getHarrisPoints(im, alpha, k);
    else
        disp("wrong input, method should be either 'random' or 'harris'"); 
        return;
    end
    numPoints = size(points, 1);
    numBank = size(imgBank, 3);
    for j = 1: numPoints
        for t = 1: numBank
            tempPixel = imgBank(points(j, 2), points(j, 1), t);
            res(numPoints*(i-1)+j, t) = tempPixel;
%             res(numPoints*(i-1)+j, t) = imgBank(points(j, 1), points(j, 2), t);
        end
    end
end

% opts = statset('Display','final','MaxIter',100); 
[~, dictionary] = kmeans(res, K, 'EmptyAction', 'drop');
end


            
            
    
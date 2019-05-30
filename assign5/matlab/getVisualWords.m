function [wordMap] = getVisualWords(I, filterBank, dictionary)
imgBank = extractFilterResponses(I, filterBank);
[m, n, ~] =size(imgBank);
res = zeros(m, n);
for i = 1: m
    for j = 1: n
        temp = imgBank(i, j, :);
        temp = reshape(temp, 1, []);
        [~, idx] = pdist2(dictionary, temp, 'euclidean', 'smallest', 1);
        res(i, j) = idx;
    end
end
wordMap = res;
% RGB = label2rgb(wordMap);
% figure;
% imshow(RGB);
end
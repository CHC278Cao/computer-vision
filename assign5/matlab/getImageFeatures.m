function [h] = getImageFeatures(wordMap, dictionarySize)
res = zeros(1, dictionarySize);
for i = 1: dictionarySize
    res(i) = sum(sum(wordMap == i));
end
h = res ./ sum(res);
end

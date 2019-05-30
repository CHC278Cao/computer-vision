%% extract filter response
function [imgBank] = extractFilterResponses(I, filterBank)
% im = double(I);
if size(I, 3) ==1
    I = cat(3, I, I, I);
end
L = RGB2Lab(I);
[m, n, c] = size(L);
num = size(filterBank, 1);
res = zeros(m, n, 3*num);

for i = 1: num
    for j = 1: c
%         filter = filterBank{i};
%         temp = conv2(L(:, :, j), filterBank{i}, 'same');
%         res(:, :, 3*(i-1)+j) = temp;
        res(:, :, 3*(i-1)+j) = conv2(L(:, :, j), filterBank{i}, 'same');
    end
end
imgBank = res;
end
    


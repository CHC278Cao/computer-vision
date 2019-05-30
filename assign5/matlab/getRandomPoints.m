function [points] = getRandomPoints(I, alpha)
[m, n, ~] = size(I);
x = randi(n, alpha, 1);
y = randi(m, alpha, 1);
points = [x y];
end
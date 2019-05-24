function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%
num = size(pts1, 1);
p11 = P1(1, :);
p12 = P1(2, :);
p13 = P1(3, :);

p21 = P2(1, :);
p22 = P2(2, :);
p23 = P2(3, :);

res = zeros(num, 3);
A = zeros(4, 4);
for i = 1: num
    A(1,:) = pts1(i, 2) * p13 - p12;
    A(2,:) = p11 - pts1(i, 1) * p13;
    A(3,:) = pts2(i, 2) * p23 - p22;
    A(4,:) = p21 - pts2(i, 1) * p23;
    
    [~, ~, V] = svd(A);
    ts = V(:, end);
    ps = ts';
    res(i, :) = ps(1:3)/ps(4);
end
pts3d = res;

end

 
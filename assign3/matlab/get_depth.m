function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).
res = zeros(size(dispM));
b = sqrt(sum((t1-t2) .^2));
f = K1(1, 1);
for i = 1: size(dispM, 1)
    for j = 1: size(dispM, 2)
        if dispM(i, j) == 0
            res(i, j) = 0;
        else
            res(i, j) = b * f / dispM(i, j);
        end
    end
end
depthM = res;
end
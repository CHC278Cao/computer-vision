function [H2to1] = computeH_norm(x1, x2)

%% Compute centroids of the points
centroid1 = mean(x1);
centroid2 = mean(x2);

%% Shift the origin of the points to the centroid
temp_x1 = x1 - centroid1;
temp_x2 = x2 - centroid2; 
%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
maxDis1 = max(temp_x1(:, 1) .* temp_x1(:, 1) + temp_x1(:, 2) .* temp_x1(:, 2), [], 1);
scale1 = 2 / maxDis1;
norm1 = sqrt(scale1) * temp_x1;
maxDis2 = max(temp_x2(:, 1) .* temp_x2(:, 1) + temp_x2(:, 2) .* temp_x2(:, 2), [], 1);
scale2 = 2 / maxDis2;
norm2 = sqrt(scale2) * temp_x2;
%% similarity transform 1
m = size(x1, 1);
homo_x1 = zeros(3, m);
homo_x1(1:2, :) = x1';
homo_x1(3, :) = ones(1, m);

homo_norm_x1 = zeros(3, m);
homo_norm_x1(1:2, :) = norm1';
homo_norm_x1(3, :) = ones(1, m);
T1 = (homo_norm_x1 * homo_x1') / (homo_x1 * homo_x1');


%% similarity transform 2
homo_x2 = zeros(3, m);
homo_x2(1:2, :) = x2';
homo_x2(3, :) = ones(1, m);

homo_norm_x2 = zeros(3, m);
homo_norm_x2(1:2, :) = norm2';
homo_norm_x2(3, :) = ones(1, m);
T2 = (homo_norm_x2 * homo_x2') / (homo_x2 * homo_x2');


%% Compute Homography
H = computeH(norm1, norm2);
% temp1 = H * homo_norm_x2;
% test = homo_norm_x1 ./ temp1;
%% Denormalization
H2to1 = T1 \ (H * T2);
% temp = zeros(3, m);
% temp = H2to1 * homo_x2;
% res = homo_x1 ./ temp;

end
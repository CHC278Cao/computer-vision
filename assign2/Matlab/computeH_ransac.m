function [ bestH2to1, inliers] = computeH_ransac(locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
 % number of points
 m = size(locs1, 1);
 max_count = 0;
 bestH2to1 = zeros(3, 3);
 inliers = zeros(1, m);
 
 % find the inliners and bestH2to1
 for i = 1: m
     index = randperm(m, 5);
     
     p1 = locs1(index, :);
     p2 = locs2(index, :);
     H = computeH_norm(p1, p2);
     temp_p2 = ones(3, 5);
     temp = zeros(3, 5);
     temp_p2(1:2, :) = p2';
     temp = H * temp_p2;
     res = zeros(3, 5);
     
     for k = 1: 5
         res(:, k) = temp(:, k) / temp(3, k);
     end
     
     count = 0;
     flag_inliers = zeros(1, m);
     for j = 1: m
         x1 = locs1(j, :);
         homo_x1 = zeros(3, 1);
         homo_x1(1:2, :) = x1';
         homo_x1(3, :) = 1;
         
         x2 = locs2(j, :);
         homo_x2 = zeros(3, 1);
         homo_x2(1:2, :) = x2';
         homo_x2(3, :) = 1;
         
         gauss_x1 = H * homo_x2;
         gauss_x1 = gauss_x1 / gauss_x1(3);
         x_tor = abs((gauss_x1(1) - homo_x1(1)) / homo_x1(1));
         y_tor = abs((gauss_x1(2) - homo_x1(2)) / homo_x1(2));
         if (x_tor <= 0.03) && (y_tor <= 0.03)
             count = count + 1;
             flag_inliers(j) = 1;
         end
     end
     
     if count > max_count
         max_count = count;
         bestH2to1 = H;
         inliers = flag_inliers;
     end
     if count == m
         break;
     end
 end
%Q2.2.3
end


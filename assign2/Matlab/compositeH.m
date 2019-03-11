function [ composite_img ] = compositeH( H2to1, template, img )
%COMPOSITE Create a composite image after warping the template image on top
%of the image using the homography

% Note that the homography we compute is from the image to the template;
% x_template = H2to1*x_photo
% For warping the template to the image, we need to invert it.
H_template_to_img = inv(H2to1);

%% Create mask of same size as template
temp = uint8(255 * ones(size(template)));

%% Warp mask by appropriate homography
mask = warpH(temp, H2to1, size(img));
    
%% Warp template by appropriate homography
templateWarp = warpH(template, H2to1, size(img));
% figure;
% subplot(211);
% imshow(templateWarp);
% subplot(212);
% imshow(img);
%% Use mask to combine the warped template and the image
for i = 1: size(mask, 3)
    mask(:, :, i) = img(:, :, i) - mask(:, :, i) + templateWarp(:, :, i);
end

composite_img = mask;
end
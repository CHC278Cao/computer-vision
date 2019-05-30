% load images
clear all; clc;
im = imread('../data/desert/sun_adpbjcrpyetqykvt.jpg');
filterBank = createFilterBank();
% filterBank2 = createFilterBank();
imgBank = extractFilterResponses(im, filterBank);
% imgBank = uint8(imgBank);
figure;
subplot(1, 2, 1);
imshow(im);
subplot(1, 2, 2);
% temp = imgBank(:, :, 2);
temp = cat(3, imgBank(:, :, 1),imgBank(:, :, 2),imgBank(:, :, 3));
imshow(temp);
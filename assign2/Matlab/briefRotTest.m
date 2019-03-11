% Your solution to Q2.1.5 goes here!
clear all; clc;
%% Read the image and convert to grayscale, if necessary
imgpath = '../data/cv_cover.jpg';
img = imread(imgpath);
if size(img, 3) == 3
    img = rgb2gray(img);
end

%% Compute the features and descriptors
features = detectFASTFeatures(img);
[desc, locs] = computeBrief(img, features.Location);

histogram = zeros(35, 1);
for i = 1:35
    %% Rotate image
    imgRotate = imrotate(img, i*10);
    %% Compute features and descriptors
    [locs1, locs2] = matchPics(img, imgRotate);
    %% Match features
    
    %% Update histogram
    histogram(i) = size(locs1, 1);
end

figure;
plot(histogram);
%% Display histogram
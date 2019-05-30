%% get the points 
% load images
clear all; clc;
% I = imread('../data/campus/sun_abslhphpiejdjmpz.jpg');
% alpha = 500;
% k = 0.06;
% figure;
% subplot(1, 2, 1);
% points1 = getRandomPoints(I, alpha);
% imshow(I);
% hold on;
% plot(points1(:, 1), points1(:, 2), 'b*');
% title('500 Random Points');
% subplot(1, 2, 2);
% points2 = getHarrisPoints(I, alpha, k);
% imshow(I);
% hold on;
% plot(points2(:, 1), points2(:, 2), 'b*');
% title('500 Harris Points');

%% get the dictionary of visual words
% imgpaths = load('../data/traintest.mat');
% img = imgpaths.train_imagenames;
% root = '../data/';
% k = size(img, 2);
% for i = 1: k
%     tp = img{i};
%     img{i} = strcat(root,tp);
% end
% alpha = 50;
% K = 100;
% method = 'random';
% dictionaryRandom = getDictionary(img, alpha, K, method);
% save('../data/dictionaryRandom.mat', 'dictionaryRandom');
% 
% method = 'harris';
% dictionaryHarris = getDictionary(img, alpha, K, method);
% save('../data/dictionaryHarris.mat', 'dictionaryHarris');

% 
I = imread('../data/airport/sun_aesovualhburmfhn.jpg');
filterBank = createFilterBank();
dictionary = load('../data/dictionaryHarris.mat');
dictionary = dictionary.dictionaryHarris;
dictionarySize = size(dictionary, 1);
wordMap = getVisualWords(I, filterBank, dictionary);
h = getImageFeatures(wordMap, dictionarySize);


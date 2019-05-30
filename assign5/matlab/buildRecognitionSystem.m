%% recongnition system
clear all; clc;

% load filterBank
filterBank = createFilterBank();

% load dictionary
randomDict = load('../data/dictionaryRandom.mat');
dictionaryRandom = randomDict.dictionaryRandom;
K1 = size(dictionaryRandom, 1);
harrisDict = load('../data/dictionaryHarris.mat');
dictionaryHarris = harrisDict.dictionaryHarris;
K2 = size(dictionaryHarris, 1);

% load image and trainFeatures
imgpaths = load('../data/traintest.mat');
img = imgpaths.train_imagenames;
trainLabels = imgpaths.train_labels;
root = '../data/';
T = size(img, 2);
trainFeaturesRandom = zeros(T, K1);
trainFeaturesHarris = zeros(T, K2);
for i = 1: T
    tp = img{i};
    img{i} = strcat(root,tp);
    im = imread(img{i});
    wordMapRandom = getVisualWords(im, filterBank, dictionaryRandom);
    hRandom = getImageFeatures(wordMapRandom, K1);
    trainFeaturesRandom(i, :) = hRandom;
    
    wordMapHarris = getVisualWords(im, filterBank, dictionaryHarris);
    hHarris = getImageFeatures(wordMapHarris, K2);
    trainFeaturesHarris(i, :) = hHarris;
end

save('../data/visionRandom.mat', 'dictionaryRandom', 'filterBank', ...
    'trainFeaturesRandom', 'trainLabels');
save('../data/visionHarris.mat', 'dictionaryHarris', 'filterBank', ...
    'trainFeaturesHarris', 'trainLabels');
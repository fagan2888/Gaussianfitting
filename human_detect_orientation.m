clear;  clc;
% close all

%Add Path to svm library
addpath './svm_mex601/matlab/';
addpath './svm_mex601/bin/';
pathPos = './rate_test/train/';       % positive example
pathNeg = 'C:/Users/Andy/Dropbox/ZZZ/human detect 0128/dataset/non-human/32_64/';   % negative example


% Learning part
if exist('64model.mat','file')
    load 64model;
else
    [fpos, fneg] = features(pathPos, pathNeg);  % extract features
    [ model ] = trainSVM( fpos,fneg );          % train SVM
    save 64model model;
end

% Detect
wSize = [64 128];

testImPath = './rate_test/test/';

imlist = dir([testImPath '*.jpg']);
for j = 1:length(imlist)
       RoIimg = imread([testImPath imlist(j).name]);
       HOGFeatures =  HOGFeature0403(double(RoIimg),wSize);
       if ~exist('featureVector')     % save information
           featureVector = HOGFeatures; 
%            initialpts_data = initial_pts;
        else
           featureVector = [ featureVector HOGFeatures];
%            initialpts_data =[initialpts_data initial_pts];
        end
end
'HOG complete'
lebel = ones(length(featureVector),1);
P = cell2mat(featureVector);
% toc
% each row of P' correspond to a window
[~, predictions] = svmclassify(P',lebel,model); % classifying each window
toc
predictions(predictions>0.04) = 1;
predictions(predictions~=1) = 0;
D_rate = sum(predictions)/length(predictions)



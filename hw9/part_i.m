% Emma Akbari (eea21) hw9: Part I

% 1: specific folder
imds = imageDatastore('C:\Users\akbar\Documents\Pitt\2020-2021\CS1674\hw9\scenes_lazebnik-1', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
numTrainingFiles = 100;
[imdsTrain,imdsTest] = splitEachLabel(imds,numTrainingFiles,'randomize');
% 2: create 3 layer network
layers = [ ...
    imageInputLayer([227 227 3])
    % A
    convolution2dLayer(11,50)
    reluLayer
    maxPooling2dLayer(3,'Stride',1)
    % B
    convolution2dLayer(5,60)
    reluLayer
    maxPooling2dLayer(3,'Stride',2)
    % C
    fullyConnectedLayer(8)
    softmaxLayer
    classificationLayer];

% 3: network training options
options = trainingOptions('sgdm', ...
    'MaxEpochs',1,...
    'InitialLearnRate',1e-3, ...
    'Plots','training-progress');

% 4: train network & output performance
net = trainNetwork(imdsTrain,layers,options);
pred = classify(net, imdsTest);
accuracy = sum(pred == imdsTest.Labels)/numel(imdsTest.Labels)
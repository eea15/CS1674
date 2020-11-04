% Emma Akbari (eea21) hw9: Part III
imds = imageDatastore('C:\Users\akbar\Documents\Pitt\2020-2021\CS1674\hw9\scenes_lazebnik-1', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
numTrainingFiles = 100;
[imdsTrain,imdsTest] = splitEachLabel(imds,numTrainingFiles,'randomize');

net = alexnet;
net.Layers
layersTransfer = net.Layers(1:22);
numClasses = numel(categories(imdsTrain.Labels));
layers = [
    layersTransfer
    fullyConnectedLayer(8)
    softmaxLayer
    classificationLayer];

net = trainNetwork(imdsTrain,layers,options);
pred = classify(net, imdsTest);
accuracy = sum(pred == imdsTest.Labels)/numel(imdsTest.Labels)
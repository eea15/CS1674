% Emma Akbari (eea21) hw7
function [predicted_labels_test] = findLabelsSVM(pyramids_train, labels_train, pyramids_test);
% part II: training and obtaining labels from two classifiers

% 2: predict test image labels via SVM
model = fitcecoc(pyramids_train, labels_train);
predicted_labels_test = predict(model, pyramids_test);


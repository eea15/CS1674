% Emma Akbari (eea21) hw7
function [predicted_labels_test] = findLabelsKNN(pyramids_train, labels_train, pyramids_test, k);
% part II: training and obtaining labels from two classifiers

% 1: predict labels of test images using KNN
predicted_labels_test = zeros(1,size(pyramids_test,1));
for i = 1:size(pyramids_test,1) % test images
    % calculate Euclidean of descriptors
    dist = pdist2(pyramids_test(i, :), pyramids_train, 'euclidean');
    % find closest k neighbors among training images
    [sortedVals, indices] = sort(dist);
    topIndices = indices(1:k);
    copyLabels = labels_train(topIndices); % is this line right??
    % find mode among labels
    m = mode(copyLabels);
    % assign test image to label
    predicted_labels_test(1,i) = m; 
end
        




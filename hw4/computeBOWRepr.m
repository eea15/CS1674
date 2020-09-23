% Emma Akbari (eea21) hw4
function [bow_repr] = computeBOWRepr(features, means)
% Part II: Image Description with SIFT Bag-of-Words

% 1: initialize
bow_repr = zeros(1,size(means,1));

% 2: map each feature (r) to closest cluster/mean
closestCluster = inf(length(features),2); % cluster row, dist
for i = 1:size(features,1) % loop thru features
    for j = 1:size(means,1) % loop thru clusters
        dist = pdist2(features(i,:),means(j,:));
        if(dist < closestCluster(i,2))
            closestCluster(i,1) = j;
            closestCluster(i,2) = dist;
        end
    end
end

% 3: count # features mapped to each cluster
for i = 1:size(closestCluster,1)
    cluster = closestCluster(i,1);
    bow_repr(cluster) = bow_repr(cluster) + 1;
end

% 4: normalize histogram
bow_repr(1,:) = bow_repr(1,:)/sum(bow_repr(1,:));


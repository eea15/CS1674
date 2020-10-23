% Emma Akbari (eea21) hw7

% 1a: compute spatial pyramid match representation
p_train = zeros(size(train_images,1),size(means,1)*5);
l0_train = zeros(size(train_images,1),size(means,1));
l1_train = zeros(size(train_images,1),size(means,1)*4);
for i = 1:train_id
    im_size = [train_images(i,1), train_images(i,2)];
    [p_train(i,:), l0_train(i,:), l1_train(i,:)] = computeSPMRepr(im_size, train_sift{i}, means); % all train images
end

p_test = zeros(size(test_images,1),size(means,1)*5);
l0_test = zeros(size(test_images,1),size(means,1));
l1_test = zeros(size(test_images,1),size(means,1)*4);
for i = 1:test_id
    im_size = [test_images(i,1), test_images(i,2)];
    [p_test(i,:), l0_test(i,:), l1_test(i,:)] = computeSPMRepr(im_size, test_sift{i}, means); % all test images
end

% 1b: use SVM classifier
plt = findLabelsSVM(p_train, train_labels, p_test);
plt0 = findLabelsSVM(l0_train, train_labels, l0_test);
plt1 = findLabelsSVM(l1_train, train_labels, l1_test);

plt_times = sum(plt == test_labels);
plt0_times = sum(plt0 == test_labels);
plt1_times = sum(plt1 == test_labels);

plt_times = plt_times/size(test_labels,1)
plt0_times = plt0_times/size(test_labels,1)
plt1_times = plt1_times/size(test_labels,1)


% Emma Akbari (eea21) hw7

% a: apply SVM and KNN
svm_train = findLabelsSVM(p_train, train_labels, p_train);
svm_train_acc = sum(svm_train == train_labels)/size(train_labels,1);
svm_test = findLabelsSVM(p_train, train_labels, p_test);
svm_test_acc = sum(svm_test == test_labels)/size(test_labels,1);

knn_train = zeros(train_id, 11);
knn_test = zeros(test_id, 11);

count = 1;
for k = 1:2:21
   knn_train(:,count) = findLabelsKNN(p_train, train_labels, p_train, k);
   knn_test(:,count) = findLabelsKNN(p_train, train_labels, p_test, k);
   count = count + 1;
end

knn_train_acc = sum(knn_train == train_labels)/size(train_labels,1);
knn_test_acc = sum(knn_test == test_labels)/size(test_labels,1);
vector = ones(11,1);

% plot the figure
figure;
hold on;
plot(1:2:21,vector * svm_train_acc);
plot(1:2:21,vector * svm_test_acc);
plot(1:2:21,knn_train_acc);
plot(1:2:21,knn_test_acc);

xlabel('k');
ylabel('accuracy');
legend('svm train','svm test','knn train','knn test');
hold off;

%saveas(gcf,'results.png')

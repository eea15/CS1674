% Emma Akbari (eea21) hw8
% Part II: Loss Functions: 3
load('weights_samples.mat');
W = {W1, W2, W3};
x = {x1, x2, x3, x4};

h = zeros(3,4); % hinges
c = zeros(3,4); % cross-entropy

for i = 1:3 % W
    for j = 1:4 % x
        s = W{i} * x{j};
        h(i,j) = hinge_loss(s,j);
        c(i,j) = cross_entropy_loss(s,j);
    end
end

h
c

% Emma Akbari (eea21) hw8
% Part I: Network Activations

% 1: encode inputs/weights
x = [10, 1, 2, 3]; % inputs
w1 = [0.5, 0.6, 0.4, 0.3; 0.02, 0.25, 0.4, 0.3; 0.82, 0.1, 0.35, 0.3]; 
w2 = [0.7, 0.45, 0.5; 0.17, 0.9, 0.8];
D = 4; M = 3; K = 2;

% 2: compute and print z2
z = zeros(1,M);
for j = 1:M % calculate 2nd layer
    for i = 1:D % each dimension
        z(1,j) = z(1,j) + w1(j,i) * x(1,i);
    end
end
z2 = tanh(z(2))

% 3: compute y1
z = max(0,z); % RELU
y = zeros(1,K);
for k = 1:K % calculate 3rd layer
    for j = 1:M % each dimension
        y(1,k) = y(1,k) + w2(k,j) * z(1,j);
    end
end
y = 1.0./(1.0 + exp(-y)); % Sigmoid
y1 = y(1)

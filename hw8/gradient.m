% Emma Akbari (eea21) hw8
% Part III: Gradients

W = W1(:);
x = {x1, x2, x3, x4};
h = 0.0001;
g_dW = zeros(size(W)); % gradient dW

% 1: compute derivative for eachW dimension & concat
for i = 1:size(W,1)
   W_loss = 0; % overall loss of W
   for j = 1:size(x,1)
       s = reshape(W, 4, 25) * x{j};
       W_loss = W_loss + hinge_loss(s,j);
   end
   
   Wh = W;
   Wh(j) = Wh(j) + h;
   Wh_loss = 0; % loss of W + h
   
   for j = 1:size(x,1) % overall loss of W
       s = reshape(Wh, 4, 25) * x{j};
       Wh_loss = Wh_loss + hinge_loss(s,j);    
   end
   
   g_dW(i) = (Wh_loss - W_loss)/h;
end    

% 2: compute weight update
W1_it = W - (0.001 * g_dW); % 1 iteration


% just testing stuff lol
A = [0 8 4;...
    9 3 5;...
    1 6 11];

[descend,i] = sort(A(:),1,'descend');
[y,x] = ind2sub(size(A), i(1:3));
centers = [x,y]

% col = 3 1 2
% row = 3 2 1
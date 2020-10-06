% Emma Akbari (eea21) hw6 part 1
function H = estimate_homography(PA, PB)

% set up A
numPts = size(PA,1);
A = zeros(numPts*2,9);
pt = 1; % track which point

for i=1:2:(numPts*2) % for each point
    A(i,:) = [PA(pt,1)*-1, PA(pt,2)*-1,-1,0,0,0,PA(pt,1)*PB(pt,1),PA(pt,2)*PB(pt,1),PB(pt,1)];
    A(i+1,:) = [0,0,0,PA(pt,1)*-1,PA(pt,2)*-1,-1,PA(pt,1)*PB(pt,2),PA(pt,2)*PB(pt,2),PB(pt,2)];
    pt = pt + 1; % next point
end

A
% solve for H
[~, ~, V] = svd(A);
h = V(:, end); 
H = reshape(h, 3, 3)';


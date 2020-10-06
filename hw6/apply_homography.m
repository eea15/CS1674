% Emma Akbari (eea21) hw6 part 2
function [p2] = apply_homography(p1, H)

p2 = H * p1;
w = p2(size(p2,1)); % last element of p2
p2 = [p2(1)/w;p2(2)/w];
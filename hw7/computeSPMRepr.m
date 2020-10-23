% Emma Akbari (eea21) hw7
function [pyramid, level_0, level_1] = computeSPMRepr(im_size, sift, means);
% part I: computing SPM 

% a: create bow histogram for level 0
level_0 = computeBOWRepr(double(sift.d'), means);

% b: compute four BOW histograms
h = im_size(1,1);
w = im_size(1,2);
q1 = []; q2 = []; q3 = []; q4 = [];
% sort each descriptor into respective bin
for i = 1:size(sift.d,2) % each col/descriptor
    x = sift.f(1,i);
    y = sift.f(2,i);
    if(x >= 1 && x <= h/2 && y >= w/2+1 && y <= w) 
        q1 = horzcat(q1,sift.d(:,i));
    elseif(x >= 1 && x <= h/2 && y <= w/2 && y >= 1)
        q2 = horzcat(q1,sift.d(:,i));
    elseif(x >= h/2+1 && h <= h && y >= 1 && y <= w/2)
        q3 = horzcat(q1,sift.d(:,i));
    elseif(x >= h/2+1 && h <= h && y >= w/2+1 && y <= w)
        q4 = horzcat(q1,sift.d(:,i));
    end
end

BOW_1 = computeBOWRepr(double(q1'), means);
BOW_2 = computeBOWRepr(double(q2'), means);
BOW_3 = computeBOWRepr(double(q3'), means);
BOW_4 = computeBOWRepr(double(q4'), means);

level_1 = [BOW_1, BOW_2, BOW_3, BOW_4];

pyramid = [level_0, level_1];
% Emma Akbari (eea21) hw4
function [features] = compute_features(x, y, scores, Ix, Iy)
% inputs: x = nx1 keypoint vector in horiz dir/columns
%         y = nx1 keypoint vector in vert dir/rows
%         scores = R scores
%         Ix = horizontal gradient
%         Iy = vertical gradient
% output: Nxd matrix (each row contains d-dim descriptor for nth keypoint

% Part I: Feature Description
% 1: remove pixels w/<5 neighbors on any side
for i = size(x,1):-1:1
    if(y(i) < 6 || y(i) > size(Ix, 1) - 5 || ...
            x(i) < 6 || x(i) > size(Ix, 2) - 5)
        y(i) = [];
        x(i) = [];
        scores(i) = [];
    end
end

% 2: compute gradient magnitude/angle for each feature/neighbors
m = zeros(size(Ix,1),size(Ix,2)); % magnitude
d = zeros(size(Ix,1),size(Ix,2)); % direction

for i = 1:size(x,1) % for all keypoints
    r = y(i); % row
    c = x(i); % col
    m((r-5:r+5),(c-5:c+5)) = sqrt((Ix(r-5:r+5,c-5:c+5)).^2 + (Iy(r-5:r+5,c-5:c+5).^2));
    % ignore angle if magnitude = 0
     if(m((r-5:r+5),(c-5:c+5)) ~= 0) 
         d((r-5:r+5),(c-5:c+5)) = atand((Iy(r-5:r+5,c-5:c+5))./(Ix(r-5:r+5,c-5:c+5)));
     end
end

% 3: quantize gradient orientations in 8 bins
o = zeros(size(Ix,1),size(Ix,2)); % matrix of orientations corresponding to image
for i = 1:size(x,1)
    r = y(i); % row
    c = x(i); % col
    
    % go thru 11x11 window
    for p = r-5:r+5
        for q = c-5:c+5
            angle = d(r,c);
            % label 1-8
            if(angle >= -90 && angle < -67.5)
                o(p,q) = 1;
            elseif(angle >= -67.5 && angle < -45)
                o(p,q) = 2;
            elseif(angle >= -45 && angle < -22.5)
                o(p,q) = 3;
            elseif(angle >= -22.5 && angle < 0)
                o(p,q) = 4;
            elseif(angle >= 0 && angle < 22.5)
                o(p,q) = 5;
            elseif(angle >= 22.5 && angle < 45)
                o(p,q) = 6;
            elseif(angle >= 45 && angle < 67.5)
                o(p,q) = 7;
            elseif(angle >= 67.5 && angle <= 90)
                o(p,q) = 8;
            else
                fprintf("error: invalid angle");
            end
        end
    end
end

% 4: populate the SIFT histogram
hist = zeros(size(x,1),8);
for i = 1:size(x,1)
    r = y(i); % row
    c = x(i); % col
    
    for p = r-5:r+5 % go thru feature windows
        for q = c-5:c+5
            bin = o(p,q);
            hist(i,bin) = hist(i,bin) + m(p,q);
        end
    end
end

% 5: normalize and clip
for i = 1:size(hist,1)
     hist(i,:) = hist(i,:)/sum(hist(i,:));
end
for i = 1:size(hist,1)
    for j = 1:8
        if(hist(i,j) > 0.2)
            hist(i,j) = 0.2;
        end
    end
end
for i = 1:size(hist,1)
     hist(i,:) = hist(i,:)/sum(hist(i,:));
end


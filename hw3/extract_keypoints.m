% Emma Akbari (eea21) hw3
function [x, y, scores, Ih, Iv] = extract_keypoints(image)

% a: preprocessings
k = 0.05;
w = 5; % window size 5
halfW = floor(5/2);

im = imread(image);
im = rgb2gray(im);
im = double(im); 

% horizontal gradient filter
h = [1 0 -1; 2 0 -2; 1 0 -1];
% vertical
v = transpose(h);

% compute horizontal & vertical image gradients
Ih = imfilter(im,h);
Iv = imfilter(im,v);

% initialize matrix R
R = inf(size(im,1), size(im,2)) * -1;

% b: compute R(i,j) scores

% loop thru all image pixels
for i = 3:(size(im,1) - 2) % rows
    start_r = i - halfW;
    end_r = i + halfW;
    
    for j = 3:(size(im,2) - 2) % cols
        M = zeros(2,2);
        % for each neighbor less than half_window_size
        start_c = j - halfW;
        end_c = j + halfW;

        % compute energy of each pixel using x,y gradients
        % loop version
        for x = start_r:end_r
            for y = start_c:end_c
                ih = Ih(x,y);
                iv = Iv(x,y);
                % compute M
                M = M + [ih ^ 2, ih * iv; ih * iv, iv ^ 2];
            end
        end
        
        
        % compute R(i,j)
        R(i,j) = det(M) - k*(trace(M) .^ 2);
    end
end

% c: threshold for R
thresh = mean2(R) * 5; % threshold
corners = R > thresh;
R(corners~=1) = 0; % is this right??

% store intermediate list of x,y corners
x = [];
y = [];
for i = 1:size(R,1)
    for j = 1:size(R,2)
        if(R(i,j) ~= 0)
            y = horzcat(y,i); % rows
            x = horzcat(x,j); % cols
        end
    end
end

% d: non-maximum suppression

% track keypoints whose R score <= 8 neighbors
removeR = []; % row indices to remove
removeC = []; % col indices to remove

% loop thru valid R(i,j)
%   compare to 8 neighbors
%   if <= any neighbor, add to removeR/C
for i = 2:size(im,1)-1 % rows
    start_r = i - 1;
    end_r = i + 1;
   
    for j = 2:size(im,2)-1 % cols
        start_c = j - 1;
        end_c = j + 1;
        
        % compare with 8 neighbors
        for x = start_r:end_r
            for y = start_c:end_c
                if(i == x && j == y)
                    continue
                else
                    if(R(i,j) <= R(x,y))
                        removeR = horzcat(removeR,i);
                        removeC = horzcat(removeC,j);
                    end
                end
            end
        end % end inner double for loop
        
    end
 end % end outer double for loop

% track keypoints w/o 8 neighbors
% left and right borders
tempR = [1:size(im,1),1:size(im,1)];
removeR = horzcat(removeR,tempR);
a = repmat([1],1,size(im,1));
b = repmat([size(im,2)],1,size(im,1));
tempC = horzcat(a,b);
removeC = horzcat(removeC,tempC);
assert(size(removeR,2) == size(removeC,2));

% top and bottom borders
a = repmat([1],1,size(im,2));
b = repmat([size(im,1)],1,size(im,2));
removeR = horzcat(removeR,a,b);
removeC = horzcat(removeC,[1:size(im,2),1:size(im,2)]);
assert(size(removeR,2) == size(removeC,2));

% remove suppressed keypoints
for i = 1:size(x) % loop thru x/y keypoints
    for j = 1:size(removeC) % loop thru keypoints to remove
        if(y(i) == removeR(i) && x(i) == removeC(i))
            y(i) = [];
            x(i) = [];
            removeR(i) = [];
            removeC(i) = [];
        end
    end
end










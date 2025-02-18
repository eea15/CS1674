% Emma Akbari (eea21) hw3
function [x, y, scores, Ih, Iv] = extract_keypoints(image)

% a: preprocessing
k = 0.05;
w = 5; % window size 5
halfW = floor(5/2);
% 
% %im = imread(image);
% if size(image,3) > 1
%     disp("color image");
% else
% end
im = rgb2gray(image);
im = im2double(im); 

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

% c: get top 1% for keypoints
pixels = size(R,1) * size(R,2) * 0.01; 
[A,I] = sort(R(:),1,'descend');
max_vals = A(1:pixels);
[y,x] = ind2sub(size(R),I(1:pixels)); 

scores = [];
for i = 1:size(x)
    scores = vertcat(scores,R(y(i),x(i)));
end

% d: non-maximum suppression

% track keypoints whose R score <= 8 neighbors
removeR = []; % row indices to remove
removeC = []; % col indices to remove

size(x)
size(y)

% loop thru valid R(i,j), compare to 8 neighbors
for i = 1:length(x)
    if(x(i) < halfW | x(i) > size(im,1) - halfW ...
            | y(i) < halfW | y(i) > size(im,1) - halfW | ...
            max(R(y(i)-1:y(i)+1,x(i)-1:x(i)+1)) ~= R(y(i),x(i)))
        removeR = vertcat(removeR,y(i));
        removeC = vertcat(removeC,x(i));
    end
end

% remove values
for i = 1:size(x,1)
    for j = 1:size(x,1)
        all([removeR(i) removeC(i)] == [y(j) x(j)]);
    end
end

y = removeR;
x = removeC;

% display
figure;
imagesc(im);
hold on;
for i = 1:length(x)
     plot(x(i), y(i), 'ro');
end
hold off; 

%saveas(gcf,'vis3.png');





% blobs: blob detection using Laplacian pyramid

im = imread('butterfly3.png');
orig_im = im;
if(size(im, 3) > 1)
    im = rgb2gray(im);
end
sigma = 2; %nthroot(2, 4); % using a large value for emphasis
figure; imagesc(im); title('original');

% consider t keypoints at each level
t = 100;
keypoints = [];

for i = 1:8
    
    % filter, compute difference between two Gaussian levels
    fil = fspecial('gaussian', ceil(3*sigma), sigma);
    im_fil = imfilter(im, fil);
    blobs_at_this_level = im - im_fil;
    
    % find largest t values and show them on the image
    [~, inds] = sort(blobs_at_this_level(:), 'descend');
    blobs_at_this_level(inds(t+1:end)) = 0; % hide all pixels except those with the top t responses
    figure; imagesc(blobs_at_this_level);
    title(strcat('sigma=', num2str(sigma^i)));
    
    % get x/y/scale for all keypoints at this level
    [rows, cols] = ind2sub(size(im), inds(1:t));
    keypoints = [keypoints; [rows cols repmat(sigma^i, t, 1)]];
    
    % overwrite image with blurred version
    im = im_fil;
    
    % subsample image at the end of this octave
    %if(i == 4)
    %    im = im(1:2:end, 1:2:end);
    %end
    
end

% skipped: non-max suppression!

% show all keypoints
figure; imagesc(orig_im); hold on
for j = 1:size(keypoints, 1)
    viscircles(keypoints(j, [2 1]), nthroot(keypoints(j, 3), 3));
end



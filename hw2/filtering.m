% filtering

im = imread('butterfly.jpg');
im = rgb2gray(im);

% noise
im_salt = imnoise(im, 'salt & pepper', 0.01);
im_gauss = imnoise(im, 'gaussian');

% smoothing
filt_box_small = ones(3) / 9;
filt_box_large = ones(9) / 81;
filt_average_small = fspecial('average', 3);
filt_average_large = fspecial('average', 9);
filt_pill = fspecial('disk', 1);
filt_gauss_small = fspecial('gaussian', 20, 1);
filt_gauss_large = fspecial('gaussian', 20, 3);
%filtered_image = imgaussfilt(image, sigma, 'FilterSize', hsize);

% detail-finding or edge-finding
filt_sobel = fspecial('sobel');
filt_prewitt = fspecial('prewitt');
filt_lap = fspecial('laplacian');

% apply filters to salt and pepper noise
figure; imshow(im_salt); title('salt&pepper noise'); 
figure; imshow(imfilter(im_salt, filt_box_small)); title('salt&pepper noise, small box'); 
figure; imshow(imfilter(im_salt, filt_box_large)); title('salt&pepper noise, large box'); 
figure; imshow(imfilter(im_salt, filt_gauss_small)); title('salt&pepper noise, small sigma'); 
figure; imshow(imfilter(im_salt, filt_gauss_large)); title('salt&pepper noise, large sigma'); 
figure; imshow(medfilt2(im_salt)); title('salt&pepper noise, median filter'); 
input('press any key to continue...');

% apply filters to gaussian noise
figure; imshow(im_gauss); title('gaussian noise'); 
figure; imshow(imfilter(im_gauss, filt_box_small)); title('gaussian noise, small box'); 
figure; imshow(imfilter(im_gauss, filt_box_large)); title('gaussian noise, large box'); 
figure; imshow(imfilter(im_gauss, filt_gauss_small)); title('gaussian noise, small sigma'); 
figure; imshow(imfilter(im_gauss, filt_gauss_large)); title('gaussian noise, large sigma'); 
figure; imshow(medfilt2(im_gauss)); title('gaussian noise, median filter'); 
input('press any key to continue...');

% add grid 
grid = zeros(size(im, 1), size(im, 2));
for i = 10:50:size(im, 2)
    grid(:, i) = 255 * ones(size(im, 1), 1);
end
im = im + uint8(grid);
figure; imshow(im); title('image with grid over it'); 
input('press any key to continue...');

% apply smoothing filter to grid
figure; imshow(imfilter(im, filt_box_small)); title('box over grid'); 
figure; imshow(imfilter(im, filt_gauss_small)); title('gaussian over grid'); 

% apply median filter over grid
med_filtered = medfilt2(im);
figure; imshow(med_filtered); title('median over grid'); 
input('press any key to continue...');

% find edges 
figure; imshow(imfilter(im, filt_sobel)); title('horizontal edges'); 
figure; imshow(imfilter(im, filt_sobel')); title('vertical edges'); 

  

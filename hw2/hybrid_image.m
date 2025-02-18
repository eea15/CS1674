% Emma Akbari (eea21) hw2

% Part II: Hybrid Images
% 2: read images, grayscale, resize
im1 = imread('baby_happy.jpg');
im1 = rgb2gray(im1);
im1 = imresize(im1, [512 512]);

im2 = imread('baby_weird.jpg');
im2 = rgb2gray(im2);
im2 = imresize(im2, [512 512]);

% 3: apply Gaussian filter and save
im1_blur = imgaussfilt(im1, 10, 'FilterSize', 31);
im2_blur = imgaussfilt(im2, 10, 'FilterSize', 31);

% 4: obtain detail image
im2_detail = im2 - im2_blur;

% 5: create hybrid, show, and save
figure;
hybrid = im1_blur + im2_detail;
imshow(hybrid);
saveas(gcf,'hybrid.png');


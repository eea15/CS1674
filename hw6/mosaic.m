% Emma Akbari (eea21) hw6 part 3
% load images, select matching points, compute a homography, 
% apply it to a new point from the first image, and stitch a mosaic

% a: load images and show in separate figures
% im1 = imread('img1.png');
% im2 = imread('img2.png');
im1 = imread('img3.jpg');
im2 = imread('img4.jpg');
figure;
imshow(im1);
impixelinfo;
figure;
imshow(im2);
impixelinfo;

% b: pick 4 pairs of points, store in matrices
% PA = [163 77;324 106;314 12;182 154];
% PB = [67 88;226 122;218 31;85 166];
PA = [297 461; 313 616; 111 590; 267 231; 500 399; 451 470];
PB = [748 494; 777 650; 580 627; 706 267; 959 423; 909 499];

% c: compute homography
H = estimate_homography(PA, PB);

% d: pick new point and display
% p1 = [218; 180; 1]; % top of small arch
% p2 = apply_homography(p1,H); % should be about [120; 193]
p1 = [443; 297; 1];
p2 = apply_homography(p1,H);
figure;
subplot(1,2,1);
imshow(im1);
hold on;
plot(p1(1),p1(2),'.g','MarkerSize',20);
hold off;

subplot(1,2,2);
imshow(im2);
hold on;
plot(p2(1),p2(2),'.y','MarkerSize',20);
hold off;

saveas(gcf,'uttower_onept.png')

% e: stitch the images
width = size(im2,2);
height = size(im2,1);
canvas = zeros(3*height,3*width,3);
canvas(height+1:2*height,width+1:2*width,1:3) = im2double(im2);
% imshow(canvas);
% apply estimated homography for all im1
for i = 1:size(im1,1) % rows
    for j = 1:size(im1,2) % cols
        p2 = apply_homography([j;i;1],H);
        % neighbors
        n1 = [width + floor(p2(1)),height + floor(p2(2))];
        n2 = [width + ceil(p2(1)),height + floor(p2(2))];
        n3 = [width + floor(p2(1)),height + ceil(p2(2))];
        n4 = [width + ceil(p2(1)),height + ceil(p2(2))];
        
        canvas(n1(2),n1(1),1:3) = im2double(im1(i,j,1:3));
        canvas(n2(2),n2(1),1:3) = im2double(im1(i,j,1:3));
        canvas(n3(2),n3(1),1:3) = im2double(im1(i,j,1:3));
        canvas(n4(2),n4(1),1:3) = im2double(im1(i,j,1:3));
        
    end
end
figure;
imshow(canvas);
saveas(gcf,'uttower_mosaic.png')
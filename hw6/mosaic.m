% Emma Akbari (eea21) hw6 part 3
% load images, select matching points, compute a homography, 
% apply it to a new point from the first image, and stitch a mosaic

% a: load images and show in separate figures
im1 = imread('img1.png');
im2 = imread('img2.png');
figure;
imshow(im1);
impixelinfo;
figure;
imshow(im2);
impixelinfo;

% b: pick 4 pairs of points, store in matrices
PA = [163 77;324 106;314 12;182 154];
PB = [67 88;226 122;218 31;85 166];

% c: compute homography
H = estimate_homography(PA, PB);

% d: pick new point and display
p1 = [218; 180; 1]; % top of small arch
p2 = apply_homography(p1,H); % should be about [120; 193]


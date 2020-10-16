% Emma Akbari (eea21) essay 1 q8
im = imread('flag.png');

intermediate = imresize(im,5);
intermediate = imrotate(intermediate,90);

figure;
imagesc(intermediate);

int2 = imrotate(im,90);
int2 = imresize(int2,5);

figure;
imagesc(int2);



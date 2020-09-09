% Emma Akbari (eea21) hw2
% Part III: Content-Aware Image Resizing - 1
function [energyImage, Ix, Iy] = energy_image(im)

% read in matrix im, conv to grayscale
im = rgb2gray(im);
im = double(im); 

% vertical gradient filter
v = [1 0 -1; 2 0 -2; 1 0 -1];
% horizontal
h = transpose(v);

% compute energy of each pixel using x,y gradients
% compute Ix, Iy gradients in x/y dirs using imfilter
Ix = imfilter(im,h);
Iy = imfilter(im,v);
% compute energyImage using sqrt((dI/dx)^2+(dI/dy)^2)
energyImage = Ix .^ 2;
energyImage = energyImage + Iy .^ 2;
energyImage = sqrt(energyImage);

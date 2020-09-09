% Emma Akbari (eea21) hw2
% Part III: Content-Aware Image Resizing - 3
function [reducedColorImage] = reduceWidth(im, display_flag)

% reduce image width in content-aware way
% output 3D reducedColorImage of uint8 (based on reduceHeight)
e_im = energy_image(im);
M = cumulative_minimum_energy_map(e_im, 'VERTICAL');
vertSeam = find_optimal_vertical_seam(M);

num_rows = size(im, 1);
num_cols = size(im, 2);
num_channels = size(im, 3);

assert(length(vertSeam) == num_rows);

reducedColorImage = zeros([num_rows num_cols-1 num_channels]);

for i = 1:num_rows
    for j = 1:num_channels
        this_row = im(i, :, j);
        this_row(vertSeam(i)) = [];
        reducedColorImage(i, :, j) = this_row;
    end      
end

reducedColorImage = uint8(reducedColorImage);

% if display_flag is true, show images
if(display_flag)
    figure;
    subplot(1,3,1);
    imagesc(e_im);
    subplot(1,3,2);
    imagesc(M);
    subplot(1,3,3);
    displaySeam(im,vertSeam,'VERTICAL');
end
    


% Emma Akbari (eea21) hw8
function [Output] = my_conv(Image, Filter, Padding, Stride);
% Part IV: ConvNet Operations: 1

% create padding
image_h = size(Image,1);
image_w = size(Image,2);
pad_image = zeros(image_h + Padding*2,image_w + Padding*2);

start_r = Padding + 1; end_r = start_r + image_h - 1;
start_c = Padding + 1; end_c = start_c + image_w - 1;
pad_image(start_r:end_r,start_c:end_c) = Image;

% convolve
Output_h = (image_h + 2*Padding - size(Filter,1)) / Stride + 1;
Output_w = (image_w + 2*Padding - size(Filter,2)) / Stride + 1;
start_r = 1; end_r = start_r + size(Filter,1) - 1;
start_c = 1; end_c = start_c + size(Filter,2) - 1;

for i = 1:Output_h
    for j = 1:Output_w
        temp = pad_image(start_r:end_r,start_c:end_c);
        prod =  temp .* Filter;
        Output(i,j) = sum(prod, 'all');
        start_c = start_c + Stride; end_c = end_c + Stride;
    end
    start_r = start_r + Stride; end_r = end_r + Stride;
    start_c = 1; end_c = start_c + size(Filter,2) - 1;
end


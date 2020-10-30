% just testing stuff lol
% convolve filter
% conv = zeros(size(Filter));
% f = Filter(:);
% index = size(f,1); % index of col-vector filter
% 
% for i = 1:size(Filter,2) % cols
%     for j = 1:size(Filter,1) % rows
%         conv(j,i) = f(index);
%         index = index - 1;
%     end
% end

% create padding
Image = [1 2 3; 4 5 6];
Padding = 1;

image_h = size(Image,1);
image_w = size(Image,2);
pad_image = zeros(image_h + Padding*2,image_w + Padding*2);

start_r = Padding + 1; end_r = start_r + image_h - 1;
start_c = Padding + 1; end_c = start_c + image_w - 1;
pad_image(start_r:end_r,start_c:end_c) = Image;
pad_image

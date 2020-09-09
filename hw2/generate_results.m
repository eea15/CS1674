% Emma Akbari (eea21) hw2
% Part III: Content-Aware Image Resizing - 4
function [] = generate_results(filename, reduceAmt, reduceWhat)

% reduceWhat of filename by reduceAmt times
image = imread(filename);
image = imresize(image, 0.4);
% get energy image
energy = energy_image(image);

% determine seam direction
if strcmp(reduceWhat,'HEIGHT')
    seamDir = 'HORIZONTAL';
elseif strcmp(reduceWhat, 'WIDTH')
    seamDir = 'VERTICAL';
end
 
% get min energy
M = cumulative_minimum_energy_map(energy,seamDir);

% determine seam
if strcmp(reduceWhat,'HEIGHT')
    seam = find_optimal_vertical_seam(M);
elseif strcmp(reduceWhat, 'WIDTH')
    seam = find_optimal_vertical_seam(M);
end

for counter = 1:reduceAmt
    
    if counter == 1 % first iteration display
        if strcmp(reduceWhat,'HEIGHT')
            new_im = reduceHeight(image, true);
        elseif strcmp(reduceWhat, 'WIDTH')
            new_im = reduceWidth(image, true); 
        end
    else % other iterations
        if strcmp(reduceWhat,'HEIGHT')
            new_im = reduceHeight(new_im, false);
        elseif strcmp(reduceWhat, 'WIDTH')
            new_im = reduceWidth(new_im, false); 
        end
    end
end

% display results
figure;
sgtitle(sprintf('Image %s Reduced by %d Pixels',reduceWhat,reduceAmt));
% original image
subplot(1,3,1);
imagesc(image);
title('Original');
% content-aware-reduced image
subplot(1,3,2);
imagesc(new_im);
title('Content-aware');
% content-agnostic
subplot(1,3,3);

rows = size(image,1);
cols = size(image,2);

if strcmp(reduceWhat,'HEIGHT')
    rows = rows - reduceAmt;
elseif strcmp(reduceWhat, 'WIDTH')
    cols = cols - reduceAmt;
end

J = imresize(image, [rows cols]);
imagesc(J);
title('Standard');
saveas(gcf,'interesting.png'); % edit

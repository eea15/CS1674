% Emma Akbari (eea21) hw2

% Part I: Image Responses with Filters
% 2
F = makeLMfilters;
%set(0, 'DefaultFigureVisible', 'off');
% 3: store images in cell array
filenames = {'cardinal1.jpg', 'cardinal2.jpg', 'leopard1.jpg', ...
    'leopard2.jpg', 'panda1.jpg', 'panda2.jpg'};

% read in images
filtered = cell([6 48]); % cell array of 6 images x 48 filters
for i = 1:6
    I = imread(filenames{i});
    I = rgb2gray(I);
    I = imresize(I, [100 100]);
    filenames{i} = I;
    % compute cross-correlation of each image w/48 filters
    for j = 1:48
      filtered{i,j} = imfilter(filenames{i},F(:,:,j));
    end
end

% 4: generate subplot for each filter
figure;
for i = 1:48 %48
    % filter
    subplot(2,4,1);
    imagesc(F(:,:,i));
    % blank
    % cardinal
    subplot(2,4,3);
    imagesc(filtered{1,i});
    title('cardinal1.jpg');
    subplot(2,4,4);
    imagesc(filtered{2,i});
    title('cardinal2.jpg');
    % leopard
    subplot(2,4,5);
    imagesc(filtered{3,i});
    title('leopard1.jpg');
    subplot(2,4,6);
    imagesc(filtered{4,i});
    title('leopard2.jpg');
    % panda
    subplot(2,4,7);
    imagesc(filtered{5,i});
    title('panda1.jpg');
    subplot(2,4,8);
    imagesc(filtered{6,i});
    title('panda2.jpg');
    % save subplots
    % saveas(gcf, strcat('responses_to_filter_', num2str(i), '.png'));
end

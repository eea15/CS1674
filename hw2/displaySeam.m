% Emma Akbari (eea21) hw2
% Part III: Content-Aware Image Resizing - 2
function displaySeam(im, seam, seamDirection)

% display the selected seam on top of input im
sz = size(im);
imagesc(im);
hold on;
if strcmp(seamDirection,'HORIZONTAL')
    %cols = sz(1);
    plot(1:size(seam),seam,'r');
elseif strcmp(seamDirection,'VERTICAL')
    %rows = sz(2);
    plot(seam,1:size(seam),'r');
end
hold off;


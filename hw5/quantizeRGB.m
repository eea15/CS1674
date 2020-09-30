% Emma Akbari (eea21) hw5
function [outputImg, meanColors, clusterIds] = quantizeRGB(origImg, k)

% perform kmeans
numpixels = size(origImg,1) * size(origImg,2);
X = reshape(origImg, [numpixels, 3]);
X = double(X);
[clusterIds, meanColors] = kmeans(double(X),k); % nx1 vector

M = reshape(clusterIds, size(origImg,1),size(origImg,2));
outputImg = zeros(size(origImg));

for x = 1:size(origImg,1)
    for y = 1:size(origImg,2)
        for i = 1:k
            if M(x,y) == i
                for c = 1:3
                     outputImg(x,y,c) = meanColors(i,c);   
                end
            end
        end
    end
end

outputImg = uint8(outputImg);

figure;
subplot(2,1,1);
imshow(origImg);
title('Original');
subplot(2,1,2);
imshow(outputImg);
title(['K =',num2str(k)]);
saveas(gcf,'k3.png');



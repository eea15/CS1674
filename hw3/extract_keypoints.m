function [x, y, scores, Ih, Iv] = extract_keypoints(image)

image=rgb2gray(image);
k=.05;
w=5;
g=[1 0 -1;2 0 -2;1 0 1];
Ih=imfilter(image, g);
Iv=imfilter(image, g');

cur=size(image);
R = zeros(cur);

Ih2=Ih.^2;
Iv2=Iv.^2;
Ivh=Iv .* Ih;

for i=1:size(image,1)
    for j=1:size(image,2)
        
        if i<3
            R(i,j) = -inf;
        elseif i>size(R,1)-3
            R(i,j) = -inf;
        elseif (j<3)  
            R(i,j) = -inf;
        elseif (j>size(R,2)-3)
            R(i,j) = -inf;
        else
            twobytwo=[0 0; 0 0];
            M=twobytwo;
            M(1,1)=sum(Ih2(i-2:i+2,j-2:j+2), 'all');
            M(2,2)=sum(Iv2(i-2:i+2,j-2:j+2), 'all');
            M(1,2) = sum(Ivh(i-2:i+2,j-2:j+2), 'all');
            M(2,1) = sum(Ivh(i-2:i+2,j-2:j+2), 'all');

            R(i,j)=det(M) - k.*(trace(M).^2) ;
        end
    end
end
notneg = R>-inf;
average = mean(notneg,'all');
%average = s./size(R);
%average = average./size(R,2);
%average = sum(R,'all')/size(R)*size(R,2);

b = R > 5.* average;
y=1;
scores=zeros(0,0);
x=zeros(0,0);
y=zeros(0,0);
for f=1:size(b)
    for g=1:size(b,2)
        if b(f,g) == 1
            for i=-1:1
                for j=-1:1
                    if(R(f+i, g+j)> R(f,g))
                        b(f,g) = 0;
                    end
                end
            end
        end 
        if b(f,g) == 1
            scores = [scores; R(f,g)];
            x = [x; f];
            y = [y; g];
            
        end 
    end
end
figure;
imshow(image);
hold on;
for i=1:size(x)
    plot(y(i), x(i), 'ro', 'MarkerSize', scores(i) / 1000000);
end
hold off;

end









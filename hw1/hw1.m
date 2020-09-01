% Emma Akbari (eea21) CS1674 hw1

% Matrices and vectors
% 1
s = rng;
bigVec = 5 .* randn(1000, 1);
% stats = [mean(bigVec) std(bigVec) var(bigVec)] to check

% 2
sz = size(bigVec);
tic
for i = 1:sz(1)
   bigVec(i) + 1; % should I save this in the vector?
end
toc

% 3
start = cputime;
bigVec = bigVec + 1;
elapsed = cputime - start;
fprintf("%f seconds without for loop.\n", elapsed)
% why does this keep returning 0.000000?

% 4
x = 0:2:98;
plot(2.^x)

% 5
A = [1:10:91;2:10:92;3:10:93;4:10:94;5:10:95;6:10:96;7:10:97;8:10:98;9:10:99;10:10:100];
B = zeros(10,10);
C = A + B;
assert(all(C(:) == (1:100)') == 1);

% Loops allowed
% 6
randOrder = randperm(10);
fprintf('Printing nums 1-10 in random order:\n')
for i = 1:10
    fprintf('%d\n', randOrder(i))
    if(mod(i,2) == 0) % pause b/w each two prints
        pause(1);
    end
end

% 7
A = rand(5,3);
B = rand(3,5);
result = zeros(5,5);
for i = 1:5 % rows
    for j = 1:5 % columns
        % calculate result for (i,j)
        num = A(i,1)*B(1,j)+A(i,2)*B(2,j)+A(i,3)*B(3,j);
        result(i,j) = num;
    end
end
fprintf("My multiplication:\n")
result
fprintf("MATLAB multiplication:\n")
A * B

% Functions
% 8 
A = rand(5,5);
normRow = normalize_rows(A);

% 9
A = rand(5,5);
normCol = normalize_columns(A);

% 10
num = input("Enter the nth digit of the Fibonacci sequence you would like to see:");
fibo = fib(num)

% 11
fprintf("Testing my_unique()")
test = [4 8 2; 4 8 2; 1 4 2; 7 9 0; 1 2 3; 1 3 2; 7 9 0];
% 482 142 123 132 790 
u = my_unique(test)

% Images
% 12
figure;
I = imread('pittsburgh.png');
imshow(I)
[r, c, channels] = size(I);
fprintf("The image pittsburgh.png is %d x %d x %d pixels\n", r, c, channels)

% 13
figure;
IGray = rgb2gray(I);
imshow(IGray)

% 14
% when matrix == matrix of sixes, new matrix of 1/0
% sum(new matrix, 'all')
sixes = ones(750, 1500) * 6;
eqSix = (IGray == sixes);
total = sum(eqSix, 'all');
fprintf("%d pixels are equal to 6\n", total)

% 15
asCol = IGray(:);
[M,index] = min(asCol);
[r, c] = ind2sub([750 1500], [index]);
fprintf("The darkest pixel val=%d at %d,%d\n", M,r,c)

% 16
figure;
rowStart = r - 15;
rowEnd = r + 15;
colStart = c - 15;
colEnd = c + 15;

for i = rowStart:rowEnd
    for j = colStart:colEnd
       IGray(i,j) = 255;
    end
end

% 17
% image center: [375,750]
rowStart = 375 - 60;
rowEnd = 375 + 60;
colStart = 750 - 60;
colEnd = 750 + 60;

IGray(rowStart:rowEnd, colStart:colEnd) = 150;
imshow(IGray)

% 18
saveas(gcf, 'new_image.png');

% 19
figure;
% compute scalar average pixel value for each channel
r = I(:,:,1);
g = I(:,:,2);
b = I(:,:,3);
% compute avg
av = (r+g+b)/3;
I = I(:,:,:) - av;
imshow(I)
saveas(gcf, 'mean_sub.png')
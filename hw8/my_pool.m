% Emma Akbari (eea21) hw8
function [Output] = my_pool(Input, Pool_Size);
% Part IV: ConvNet Operations: 2

h = size(Input,1)/Pool_Size;
w = h; % same size since square
Output = zeros(h,w);

start_r = 1; end_r = start_r + Pool_Size - 1;
start_c = 1; end_c = start_c + Pool_Size - 1;

% find max in each pool
for i = 1:h
    for j = 1:w
        temp = Input(start_r:end_r, start_c:end_c);
        max_val = max(temp, [], 'all');
        Output(i,j) = max_val;
        start_c = start_c + Pool_Size; end_c = end_c + Pool_Size;
    end
    start_c = 1; end_c = start_c + Pool_Size - 1;
    start_r = start_r + Pool_Size; end_r = end_r + Pool_Size;
end
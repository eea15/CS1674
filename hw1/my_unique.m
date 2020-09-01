function [N] = my_unique(M)
% return matrix without duplicate rows
sz = size(M);
curr = 1;
while curr <= sz(1)
    % generate new vector based on curr row
    currVec = M(curr,:);
    % check if in matrix rows 1 - (curr-1) it exists
    match = ismember(M(1:curr-1, :), currVec, 'rows');
    % if it does, delete curr row
    if nnz(match)
        M(match,:) = [];
    else
        curr = curr+1;
    end
    sz = size(M);
end

N = M;
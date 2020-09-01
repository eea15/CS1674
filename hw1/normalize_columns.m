function [B] = normalize_columns(A)
% return row normalized matrix (divide each row by respective sum)
copyA = repmat(A,1,1);
B = copyA./sum(copyA);
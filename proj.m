function [Pn, R_inv] = proj(R)
% Perform Singular Value Decomposition (SVD) of R
% (same source utilized as previous functions)
[U, ~, ~] = svd(R);
% Compute the projection matrix
%https://www.mathworks.com/help/matlab/ref/eye.html
Pn = eye(size(R, 1)) - U .* U';
% inverse of R 
R_inv = inv(R);
end
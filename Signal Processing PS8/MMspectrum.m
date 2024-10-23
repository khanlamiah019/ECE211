function [MusS, mdVRS] = MMspectrum(A, LaOA, theta, d_lambda)
% first, we defined parameters 
M = size(A, 1);
L = length(LaOA);
sTheta = zeros(M, length(theta));
%steering vector for each theta
% https://www.mathworks.com/help/phased/ref/steervec.html
for i = 1:length(theta)
    sTheta(:, i) = exp(1i * 2 * pi * d_lambda*(0:M-1)' * sind(theta(i)));
end
%https://www.mathworks.com/help/matlab/ref/double.svd.html# 
% SVD for A. 
[U,~, ~] = svd(A);
u = U(:, L+1:end);
MusS = zeros(size(theta));
% computing the actual spatial spectrum 
% https://www.mathworks.com/help/phased/ref/phased.mvdrestimator.step.html
for i = 1:length(theta)
   MusS(i) = 1/(abs(sTheta(:, i)'*(u)*(u')*sTheta(:, i)));
end
% variables for matrices (also a tie into another function matCor)
% Compute the correlation matrix (same as prev)
% the correlation matrix using corrcoef
%https://www.mathworks.com/help/matlab/ref/corrcoef.html#d126e291682
  R = corrcoef(A.');
R_inv = inv(R);
mdVRS = zeros(size(theta));
% calculating modified spectrum! there may in an error in this line of
% code, but i am unsure. 
 for i = 1:length(theta)
    mdVRS(i) = 1/(abs(sTheta(:, i)'*R_inv *sTheta(:, i)));
 end
end



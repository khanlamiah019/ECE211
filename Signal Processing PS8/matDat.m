function [A, U, S, V] = matDat(M, LaOA, d_lambda, PdB, PndB)
% set parameters. 
N = 2 * M;
AOA_rad = deg2rad(LaOA);
L = length(LaOA);
S = zeros(M, L);
% Calculate steering vectors for each angle (same source of Mathworks as
% prev)
for i = 1:L
  S(:, i) = exp(1j * pi * d_lambda * (0:M-1)' * sin(AOA_rad(i)));
end
% dB to linear scale
  P_linear = 10.^(PdB/10);
% noise power converted from dB to linear scale
Pn_linear = 10.^(PndB/10);
S = sqrt(P_linear / sum(P_linear)) .* S; 
% random complex matrix, B
B = randn(L, N) + 1j * randn(L, N);  
% noise matrix, V
V = sqrt(Pn_linear) * (randn(M, N) + 1j * randn(M, N)) / sqrt(2);
 A = zeros(M, N);
% Sum contributions from each path and noise
 for i = 1:L
    A = A + S(:, i) * B(i, :) + V;
 end
% Compute the correlation matrix (same as prev)
% the correlation matrix using corrcoef
%https://www.mathworks.com/help/matlab/ref/corrcoef.html#d126e291682
  R = corrcoef(A.');
 % SVD on R
[U, S, V] = svd(R);
end

function [sval, eigval, eigvec] = SVDeigen(A)
% similar to MMspectrum, computing SVD of A
[~, sval, ~] = svd(A);
sval = diag(sval);
% correlation matrix computing by MatCor
% Compute the correlation matrix (same as prev)
% the correlation matrix using corrcoef
%https://www.mathworks.com/help/matlab/ref/corrcoef.html#d126e291682
  R = corrcoef(A.');
[eigvec, eigval0] = eig(R);
% line 9 was assited by: 
% https://stackoverflow.com/questions/8092920/sort-eigenvalues-and-associated-eigenvectors-after-using-numpy-linalg-eig-in-pyt
[eigval, idx] = sort(diag(eigval0), 'descend');
eigvec = eigvec(:,idx);
end


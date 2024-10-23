function R = MatCor(A)
% the correlation matrix using corrcoef
%https://www.mathworks.com/help/matlab/ref/corrcoef.html#d126e291682
  R = corrcoef(A.');
end

% note: i am not sure whether this was the correct way to create the
% correlation matrix. it seems it somehow made the plots for experiment 1
% and 2 a lot more noisy. This is especially true for MVDR. 

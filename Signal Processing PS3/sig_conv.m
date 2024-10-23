%% Signals Homework #3-Convolution Question
% Lamiah Khan, February 17, 2024

%% Function for convolution plot. 
% n1 = 1st time index for signal 1
% n2 = 1st time index for signal 2
% d1 = the values of signal 1
% d2 = the values of signal 2
% start = initial time for conv.
% value = values of the convolution

function [start, value] = sig_conv(n1, d1, n2, d2)

% command two sets to compute convolution
value = conv(d1, d2);
start = n1 + n2;
disp('The starting index is:');
disp(start)

% plotting the figure
discSig_plot(start, value);

end






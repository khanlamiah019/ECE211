%% Signals Homework #3-Convolution Question
% Lamiah Khan, February 17, 2024

clear; close all; clc;

% Plot of x(t)
figure(); 
x = [3 4 5 1 2];
discSig_plot(-2, x);
title('impulse response of x(t)');

% Plot of h(t)
figure();
h = [2 3 4 2 5]; 
discSig_plot(-1, h);
title('impulse response of h(t)');

% Calculating convolution and plot y(t)
figure();
sig_conv(-1, h, -2, x);
title('impulse response of y(t)');

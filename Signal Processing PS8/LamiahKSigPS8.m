%%% Signals PS 8
% Lamiah Khan, 04/18/2024
% I worked on this assignment with Megan Vo! We experimented with some of
% the elements from mathworks when doing this assignment. 
% sources we used are mainly stack overflow and mathworks. relevant sources
% are cited based on when they are used.  
close all; clear; clc;

%% Signal Generation and Analysis
% Part I
% defining variables, mostly parameters.  
M1 = 100;
PdB1 = [0, -2, -4];
PndB1 = 10;
LaOA1 = [10, 25, 70];
d_lambda1 = 0.5;
A1 = matDat(M1, LaOA1, d_lambda1, PdB1, PndB1);
R1 = MatCor(A1);
SHS1 = shsMAtrix(M1, LaOA1, d_lambda1);
M2 = 100;
LaOA2 = [10, 12, 70];
d_lambda2 = 0.5;
PdB2 = [0, -2, -4];
PndB2 = 10;
A2 = matDat(M2, LaOA2, d_lambda2, PdB2, PndB2);
R2 = MatCor(A2);
SHS2 = shsMAtrix(M2, LaOA2, d_lambda2);

% Part II
[sval1, eigval1, eigvec1] = SVDeigen(A1);
[sval2, eigval2, eigevec2] = SVDeigen(A2);
[Pn1, rInv1] = proj(R1);
[Pn2, rInv2] = proj(R2);

%first experiment 
figure;
grid on;
stem(sval1, 'filled');
title('singular values of A1');
xlabel('index');
ylabel('Singular Values');

figure;
grid on;
stem(eigval1, 'filled');
title('sorted eigenvals of R1');
xlabel('index');
ylabel('eigen-values');

% SVD and Eigen ratio between 3rd and 4th largest values
% https://www.mathworks.com/content/dam/mathworks/mathworks-dot-com/moler/eigs.pdf
% http://eceweb1.rutgers.edu/~orfanidi/aosp/aosp-ch15.pdf
svdRatio1 = sval1(3)/sval1(4);
eigRatio1 = eigval1(3)/eigval1(4);
fprintf('Ratio for A1: %.4f\n', svdRatio1);
fprintf('Ratio for R1: %.4f\n', eigRatio1);

% second experiment
figure;
grid on;
stem(sval2, 'filled');
title('singular values of A2');
xlabel('index');
ylabel('singular value');

figure;
grid on;
stem(eigval2, 'filled');
title('sorted eigenvals of R2');
xlabel('index');
ylabel('eigen-values');

% SVD and Eigen ratio between 3rd and 4th largest values
% https://www.mathworks.com/content/dam/mathworks/mathworks-dot-com/moler/eigs.pdf
% http://eceweb1.rutgers.edu/~orfanidi/aosp/aosp-ch15.pdf
svdRatio2 = sval2(3)/sval2(4);
eigRatio2 = eigval2(3)/eigval2(4);
fprintf('Ratio of A2: %.4f\n', svdRatio2);
fprintf('Ratio of R2: %.4f\n', eigRatio2);

% SMusic and SMVDR for 1st Experiment 
theta = 0:0.2:180;
[MusS1, mdVRS1] = MMspectrum(A1, LaOA1, theta, d_lambda1);
figure;
plot(theta, 10*log10(abs(MusS1)), 'b', 'LineWidth', 2);
hold on;
plot(theta, 10*log10(abs(mdVRS1)), 'r', 'LineWidth', 2);
xlim([10 170])
xlabel('Angle (degrees)');
ylabel('Spectrum (dB)');
title('MUSIC and MVDR Spectrum for First Experiment');
legend('MUSIC', 'MVDR');
for i = 1:length(LaOA1)
    idx = find(abs(theta - LaOA1(i)) < 0.01); 
    plot(theta(idx), 10*log10(abs(MusS1(idx))), 'bo', 'MarkerSize', 7, 'MarkerFaceColor', 'g');
    plot(theta(idx), 10*log10(abs(mdVRS1(idx))), 'ro', 'MarkerSize', 7, 'MarkerFaceColor', 'g');
end
hold off;

% SMusic and SMVDR for 2nd experiment
theta = 0:0.2:180;
[MusS2, mdVRS2] = MMspectrum(A2, LaOA2, theta, d_lambda2);
figure;
plot(theta, 10*log10(abs(MusS2)), 'b', 'LineWidth', 2);
hold on;
plot(theta, 10*log10(abs(mdVRS2)), 'r', 'LineWidth', 2);
xlabel('Angle (degrees)');
ylabel('Spectrum (dB)');
title('MUSIC and MVDR Spectrum for Second Experiment');
legend('MUSIC', 'MVDR');
for i = 1:length(LaOA2)
    idx = find(abs(theta - LaOA2(i)) < 0.01); % Find closest index
    plot(theta(idx), 10*log10(abs(MusS2(idx))), 'bo', 'MarkerSize', 5, 'MarkerFaceColor', 'g');
    plot(theta(idx), 10*log10(abs(mdVRS2(idx))), 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'g');
end
hold off;

% my thoughts: Yes, there are clear peaks even when the two sources are
% close to each other. 
% comparing MVDR and MUSIC, it is clear that the peaks in MUSIC are 
% more clear. Additionally, the MUSIC signal is a lot clearer, with less
% noise. It is possible that MUSIC provides better spatial resolution than
% MVDR, according to https://www.mathworks.com/help/phased/ug/direction-of-arrival-estimation-with-beamscan-mvdr-and-music.html



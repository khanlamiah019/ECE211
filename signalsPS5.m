%% Lamiah Khan, 03/17/2024
% Signals PS5, Problem 1
% citation: jacob's MATLAB filter design notes! 
clc; clear;  close all;

%% Defining Variables
fs = 10e6; % 10 MHz, ampling rate of digital filters
ws = [1.4e6, 2.2e6]; % stopband
wp = [1.5e6, 2e6]; % passband
fn = fs/2; % nyquist bandwidth
rs = 40; % peak-to-peak ripple (stopband)
rp = 2; % peak-to-peak ripple (passband)

%% Filter 1 - Analog Elliptic
% Order and normalized band
[n1, wn] = ellipord(wp, ws, rp, rs, 's');

% get zeros, poles, and scaling factor k
[z1, p1, k1] = ellip(n1, rp, rs, wn, 's');

% transfer function 
[b1, a1] = zp2tf(z1, p1, k1);

% print out order 
ellipOrder = 2*n1;

% magnitude and phase from frequency
[h1, wout1] = freqs(b1, a1, 1e3);
mag1 = 20 * log10(abs(h1));
phase1 = unwrap(angle(h1));
phdeg1 = phase1*180/pi;

% plots for filter 1
figure;
% magnitude response plot
subplot(2, 2, 2);
plot(wout1, mag1);
grid on;
ylim([-70,5]);
xticklabels(0:5);
title("Plot of Magnitude Response");
xlabel("MHz");
ylabel("dB");

% phase response plot
subplot(2, 2, 4);
plot(wout1, phdeg1);
grid on;
xticklabels(0:5);
title("Plot of Phase Response");
xlabel("MHz");
ylabel("Degrees");

% poles and zeros plot
subplot(2, 2, [1,3]);
zplane(z1, p1);

%% Filter 2 - Analog Chebyshev I
% order of cheb1ord and normalized band
[n2, wn] = cheb1ord(wp, ws, rp, rs, 's');

% get zeros, poles, and scaling factor k
[z2, p2, k2] = cheby1(n2, rp, wn, 's');

% get transfer function given zpk
[b2, a2] = zp2tf(z2, p2, k2);

% print out order 
anaOrder = 2 * n2;

% magnitude and phase from frequency
[h2, wout2] = freqs(b2, a2, 1e3);
mag2 = 20 * log10(abs(h2));
phase2 = unwrap(angle(h2));
phdeg2 = phase2*180/pi;

% plot for filter 2
figure;
% magnitude response plot
subplot(2, 2, 2);
plot(wout2, mag2);
grid on;
ylim([-350,2]);
title("Plot of Magnitude Response");
xlabel("MHz");
ylabel("dB");

% phase response plot
subplot(2, 2, 4);
plot(wout2, phdeg2);
grid on;
title("Plot of Phase Response");
xlabel("MHz");
ylabel("Degrees");

% poles and zeros plot
subplot(2, 2, [1,3]);
zplane(z2, p2);

%% Filter 3 - Digital Elliptic
%  order and normalized band to nyquist bandwidth
[n3, wn] = ellipord(wp/fn, ws/fn, rp, rs);

% get zeros, poles, and scaling factor k
[z3, p3, k3] = ellip(n3, rp, rs, wn);

% transfer func
[b3, a3] = zp2tf(z3, p3, k3);

% print out order 
digiOrder = 2 * n3;

% magnitude and phase from frequency
[h3, wout3] = freqz(b3, a3, 1e3);
mag3 = 20 * log10(abs(h3));
phase3 = unwrap(angle(h3));
phdeg3 = phase3*180/pi;

% plot for filter 3
figure;
% magnitude response plot
subplot(2, 2, 2);
plot(wout3, mag3);
grid on;
title("Plot of Magnitude Response");
ylim([-90,3]);
xlabel("MHz");
ylabel("dB");

% phase response plot
subplot(2, 2, 4);
plot(wout3, phdeg3);
grid on;
title("Plot of Phase Response");
xlabel("MHz");
ylabel("Degrees");

% poles and zeros plot
subplot(2, 2, [1,3]);
zplane(z3, p3);

%% Filter 4 - Digital Chebyshev I
% order and normalized band to nyquist bandwidth
[n4, wn] = cheb1ord(wp/fn, ws/fn, rp, rs);

% zeros, poles, and scaling factor k
[z4, p4, k4] = cheby1(n4, rp, wn);

% transfer func
[b4, a4] = zp2tf(z4, p4, k4);

% print out order 
chebyOrder = 2 * n4;

% magnitude and phase from frequency
[h4, wout4] = freqz(b4, a4, 1e3);
mag4 = 20 * log10(abs(h4));
phase4 = unwrap(angle(h4));
phdeg4 = phase4*180/pi;

% plot for filter 4
figure;
% magnitude response plot
subplot(2, 2, 2);
plot(wout4, mag4);
grid on;
ylim([-520,7]);
title("Plot of Magnitude Response");
xlabel("MHz");
ylabel("dB");

% phase response plot
subplot(2, 2, 4);
plot(wout4, phdeg4);
grid on;
title("Plot of Phase Response");
xlabel("MHz");
ylabel("Degrees");

% zeros and poles plot
subplot(2, 2, [1,3]);
zplane(z4, p4);

%%% Signals PS 9 
% Lamiah Khan, 05/01/2024
% i did use sources such as mathworks! So I am going to be linking them
% below!

close all; clear; clc;

%% Heavy Tail Distributions 
% Part (a)
% first, im going to set up some parameters
 N = 1e6;
gausVal = randn(N, 1);
tVal = trnd(5, N, 1);
% source: https://www.mathworks.com/matlabcentral/answers/154075-how-to-scale-normalize-values-in-a-matrix-to-be-between-1-and-1
tVal = tVal/sqrt(var(tVal));
cauchyVal = 0.544 * tan(pi*rand(N, 1));

% next, compute fraction of samples with absolute value below 1,
% then display 
gausFrac = sum(abs(gausVal)<1)/N;
tFrac = sum(abs(tVal)<1)/N;
cauchyFra = sum(abs(cauchyVal)<1)/N;
fprintf('Fraction of Gaussian samples with abs. val below 1: %.4f\n', gausFrac);
fprintf('Fraction of Student''s t samples with abs. val below 1: %.4f\n', tFrac);
fprintf('Fraction of Cauchy samples with abs. val below 1: %.4f\n', cauchyFra);

% plotting data with superimpose dashed lines at x = ±1
% used subplots to make it cleaner. 
figure;
% Gaus
subplot(3, 2, 1);
histogram(gausVal, 'Normalization', 'probability');
hold on;
line([-1 -1], ylim, 'Color', 'r', 'LineStyle', '--');
line([1 1], ylim, 'Color', 'r', 'LineStyle', '--');
title('Gaussian Distribution');
xlabel('Value');
ylabel('Probability');
% Student's t
subplot(3, 2, 3);
histogram(tVal, 'Normalization', 'probability');
hold on;
line([-1 -1], ylim, 'Color', 'r', 'LineStyle', '--');
line([1 1], ylim, 'Color', 'r', 'LineStyle', '--');
title('Student''s t-Distribution (v=5)');
xlabel('Value');
ylabel('Probability');
% Cauchy
subplot(3, 2, 5);
histogram(cauchyVal, 'Normalization', 'probability');
hold on;
line([-1 -1], ylim, 'Color', 'r', 'LineStyle', '--');
line([1 1], ylim, 'Color', 'r', 'LineStyle', '--');
title('Cauchy Distribution');
xlabel('Value');
ylabel('Probability');

% Part (b)
% we want the data vectors to split into 10 segments of length 100,000 
seg = 10;
segLength = N/seg;

% i was not sure if you wanted us to just calculate and display the
% means, or graph it. I think a graphical display makes it easier to answer
% the discussion question, so I did both!

% citation: https://www.mathworks.com/help/stats/normal-distribution.html
% computing the means
gausMean = mean(reshape(gausVal, segLength, seg));
tMean = mean(reshape(tVal, segLength, seg));
cauchMean = mean(reshape(cauchyVal, segLength, seg));

% plotting the means
% Gaussian
subplot(3, 2, 2);
plot(gausMean);
title('Gaussian Distribution - Segment Means');
xlabel('Segment');
ylabel('Mean');
fprintf('Mean of Gaussian seg:\n');
disp(gausMean);
% Student's t
subplot(3, 2, 4);
plot(tMean);
title('Student''s t-Distribution (v=5) - Segment Means');
xlabel('Segment');
ylabel('Mean');
fprintf('Mean of Student''s t seg:\n');
disp(tMean);
% Cauchy
subplot(3, 2, 6);
plot(cauchMean);
title('Cauchy Distribution - Segment Means');
xlabel('Segment');
ylabel('Mean');
fprintf('Mean of Cauchy seg:\n');
disp(cauchMean);

%from the data and the values printed, all the cauchy mean
% values are relatively close to 0. Additionally, the mean values
% oscillate. Overall, it is a valid conclusion that the Cauchy distribution
% has mean 0, and in fact has no mean at all.
% citation: https://www.sciencedirect.com/topics/computer-science/cauchy-distribution#:~:text=The%20Cauchy%20distribution%20has%20a%20very%20heavy%20tail%2C%20comparable%20to,not%20have%20a%20mean%20value.

%% ARMA and AR Models 
% 2a-6
% some parameters
numerator = [1 0.4 0.2];
denomin = [1 -1.6 0.81];
zeroH = roots(numerator);
poleH = roots(denomin);
minPhase = all(abs(poleH) < 1);

% plot
figure;
hold on;
grid on;
plot(real(zeroH), imag(zeroH), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'b');
plot(real(poleH), imag(poleH), 'x', 'MarkerSize', 12, 'LineWidth', 2, 'Color', 'r');
xlabel('Real');
ylabel('Imaginary');
title('poles and zeros for H(z)');
legend('Zeros', 'Poles');
hold off;

% displays if H(z) is in minimum-phase
if minPhase
    disp('H(z) is minimum-phase.');
else
    disp('H(z) is not minimum-phase.');
end
% from this, we know that H(z) is in minimum phase!

% (b)
% (1)
N = 10e4;
v = sqrt(2)*randn(1,N);
x = filter(numerator,denomin,v);

% (2)
% citation: https://www.mathworks.com/matlabcentral/answers/515370-taking-an-average-of-multiple-outputs-from-for-loop
r = zeros(1,7);
for m = 0:6
      sum = 0;
    for n = 1:N-m 
    sum=sum+x(n+m)*x(n);
    end
    sum = sum./(N-m);
     r(m+1) = sum;
end

% (3)
rMax = [flip(r(2:7)),r];
figure();
grid on;
hold on;
stem(-6:1:6,rMax);
xlabel 'm';
ylabel 'r(x[m])';
title('r[m] estimates for sig x');
hold off; 
% (4)
R1 = toeplitz(r);
disp(['Toeplitz matrix R1' newline]);
disp(R1);

% (5)
% all values in eigenvalueR are positive, and R is hermitian 
% which means that it is positive definite if all eigenvalues > 0. 
eigenvaluesR = eig(R1);
disp(['Eigenvalues of R1' newline]);
disp(eigenvaluesR);

% (6)
xToep = zeros(7,N-6);
for n = 7:N
   xColumn = zeros(7,1);
 for m = 0:6
    xColumn(m+1) = x(n-m);
end
 xToep(:,n) = xColumn;
end
R2 = (xToep*xToep')./(N-7);
disp(['norm of R1-R2' newline]);
disp(norm(R1-R2));

% (c)
 % (1)
 [s_est,w] = pwelch(x,hamming(512),256,512);
 figure();
 plot(w,s_est);
 grid on;
xlabel 'w[rad]';
 ylabel 'S(w)';
 title('Power Spectral Density of x');
% (2) 
 disp(['w_0[rad] ≈ 0.490874' newline]);

% (3) poles calculated earlier
 disp(['Pole Angle [rad]' newline]);
 disp(cart2pol(0.8,0.412311));
% The values are close to each other, and the most different is approx. by
% 0.3-0.7. 

% (d)
 [a,varv] = aryule(x,4);
% from this varv is approx 1.9923, which is really close to variance of 2!
  x0 = filter(1,a,v);
  r0 = zeros(1,7);
  for m = 0:6
     sum = 0;
    for n = 1:N-m
      sum = sum + x0(n+m)*x0(n);
    end
    sum = sum./(N-m);
    r0(m+1) = sum;
  end
correlationR0 = [flip(r0(2:7)),r0];
disp(['r' newline]);
 disp(r);
disp(['r0' newline]);
disp(r0);
% r and r0 are very similar for m < 4
    figure();
    grid on;
    hold on;
    stem(x(1:100));
    stem(x0(1:100));
    hold off;
    title('x vs x0');
    legend('x','x0');



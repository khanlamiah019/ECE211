%% Signals Homework #3-Convolution Question
% Lamiah Khan, February 17, 2024

%% Function for stem plot. 
% startTime = the start time of the signal
% signalVal = the signal  values 
% index = time index values
% val = values of the data set

function [n, val] = discSig_plot(startTime, signalVal)

% setting time index scale
time = startTime:1:startTime+length(signalVal)-1;
stem(time, signalVal);

% figure + styling 
grid on;
xlabel('time index');
ylabel('amplitude');
xlim([(min(time)-1), (max(time)+1)])
ylim([(min(signalVal)-1), (max(signalVal)+1)])

end


clc;
clear all;
close all;

% Step-1 : Read bitstream from file
bitstream = [1 1 0 0 1 1]   %dlmread("input.txt");  % Reads numbers separated by space

% Step-2 : Basic Parameters
fc = 5;          % Carrier frequency
Tb = 1;          % Bit duration
fs = 100;        % Sampling frequency
t = 0:1/fs:Tb-(1/fs);
Ac = 5;          % Carrier amplitude

% Step-3 : ASK Modulation
ASK = [];
for i = 1:length(bitstream)
    if bitstream(i) == 1
        ask = 2*Ac*cos(2*pi*fc*t);   % High amplitude for '1'
    else
        ask = 0.5*Ac*cos(2*pi*fc*t); % Low amplitude for '0'
    end
    ASK = [ASK ask];
end

% Step-4 : Plot
plot(ASK, 'g');
xlabel('Time Index');
ylabel('Amplitude');
title('Amplitude Shift Keying (ASK) Signal');
grid on;


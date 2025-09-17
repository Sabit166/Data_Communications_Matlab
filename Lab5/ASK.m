
clc;                % Clear the command window
clear all;          % Remove all variables from workspace
close all;          % Close all figure windows

% bitstream ---> message digital signal

% Option 1: Take bitstream input from user (commented out)
% bitstream=input('Enter bistream: ');  % Take input from console

% Option 2: Use a predefined bitstream (used here)
bitstream=[1 1 0 0 1 1];                % Bitstream defined in the code

% Step 2: Define Basic Parameters
fc = input('Enter the value of Fc : '); % Carrier frequency (user input)
Tb = 1;                                % Bit duration (seconds)
fs = 100;                              % Sampling frequency (samples per second)
t = 0:1/fs:Tb-(1/fs);                  % Time vector for one bit duration
Ac = 5;                                % Amplitude of the carrier signal

% Initialize empty arrays to store modulated signals
ASK = [];                              % Amplitude Shift Keying signal
PSK = [];                              % Phase Shift Keying signal
FSK = [];                              % Frequency Shift Keying signal

% Loop through each bit in the bitstream
for i = 1:length(bitstream)
    if bitstream(i) == 1
        % For bit 1:
        ask = 2*Ac*cos(2*pi*fc*t);         % ASK: Higher amplitude for '1'
        psk = Ac*cos(2*pi*fc*t);           % PSK: Normal phase for '1'
        fsk = Ac*cos(2*pi*3*fc*t);         % FSK: Higher frequency for '1'
    else
        % For bit 0:
        ask = 0.5*Ac*cos(2*pi*fc*t);       % ASK: Lower amplitude for '0'
        psk = Ac*cos(2*pi*fc*t + pi);      % PSK: Phase shifted by 180° for '0'
        fsk = Ac*cos(2*pi*(fc/2)*t);       % FSK: Lower frequency for '0'
    end
    % Concatenate the modulated signal for each bit to the full signal
    ASK = [ASK ask];
    PSK = [PSK psk];
    FSK = [FSK fsk];
end

% Plot the ASK modulated signal
subplot(3,1,1);              % Divide the figure into 3 rows, 1 column, plot 1st
plot(ASK, 'g');              % Plot ASK in green
title('ASK');                % Title for ASK plot
grid on;                     % Enable grid

% Plot the PSK modulated signal
subplot(3,1,2);              % Plot in 2nd position
plot(PSK, 'r');              % Plot PSK in red
title('PSK');                % Title for PSK plot
grid on;                     % Enable grid

% Plot the FSK modulated signal
subplot(3,1,3);              % Plot in 3rd position
plot(FSK, 'b');              % Plot FSK in blue
title('FSK');                % Title for FSK plot
grid on;                     % Enable grid

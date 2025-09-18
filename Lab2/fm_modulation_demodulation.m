clear all;
clc;

% Time parameters
fs = 1000;                % Sampling frequency (Hz)
t = linspace(0, 1, 1000); % Time vector (0 to 1 second)

% Message signal parameters
fm = 10;                  % Message signal frequency (Hz)
Am = 1;                   % Message signal amplitude
message_signal = Am * sin(2*pi*fm.*t); % Message signal

% Carrier signal parameters
fc = 100;                 % Carrier signal frequency (Hz)
Ac = 2;                   % Carrier signal amplitude
carrier_signal = Ac * sin(2*pi*fc.*t); % Carrier signal

% Frequency deviation constant
kf = 25;                  % Frequency deviation constant for FM

% Perform frequency modulation (FM)
modulated_signal = Ac * sin(2*pi*fc.*t + kf * cumsum(message_signal)/fs);

% Plotting
figure;
subplot(3,1,1);
plot(t, message_signal);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(t, carrier_signal);
title('Carrier Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(t, modulated_signal);
title('Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Demodulation
% Differentiate the modulated signal
demodulated_signal = [diff(modulated_signal) 0] * fs; % Append zero to maintain length

% Rectify the demodulated signal for better visibility in filtering
rectified_signal = abs(demodulated_signal);

% Plotting
figure;
subplot(2,1,1);
plot(t, demodulated_signal);
title('Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(t, rectified_signal);
title('Rectified Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Low pass filter parameters
cutoff_freq = 20; % Hz

% FIR filter design using window method
numtaps = 20; % Number of taps in the FIR filter, a simple choice
normalized_cutoff_freq = cutoff_freq / (fs / 2); % Normalize cutoff frequency
fir_coeff = fir1(numtaps-1, normalized_cutoff_freq, 'low'); % Design a low-pass FIR filter

% Apply the FIR filter to the rectified signal
filtered_signal = filter(fir_coeff, 1, rectified_signal); % Notice 'a' is simply 1

% Plotting
figure;
subplot(2,1,1);
plot(t, rectified_signal);
title('Rectified Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(t, filtered_signal);
title('Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
% Time parameters
fs = 1000;
t = linspace(0, 1, 1000);

% Message signal
fm = 10;
Am = 1;
message_signal = Am * sin(2*pi*fm .* t);

% Carrier parameters
fc = 100;
Ac = 2;

% Frequency deviation
kf = 25;

% Correct frequency modulation (using integral approximation)
modulated_signal = Ac * sin(2*pi*fc .* t + 2*pi*kf * cumsum(message_signal)/fs);

% Demodulation (rough): differentiate and scale
demodulated_signal = [diff(modulated_signal) 0] * fs;

% Plotting
figure;
subplot(3,1,1);
plot(t, message_signal); title('Message Signal');

subplot(3,1,2);
plot(t, modulated_signal); title('FM Signal');

subplot(3,1,3);
plot(t, demodulated_signal); title('Demodulated Signal (Approx)');

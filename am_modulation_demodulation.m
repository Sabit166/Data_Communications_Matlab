%Time Parameters
fs = 1000;              %Sampling
t = linspace(0,1,1000); %Time vector

%Message signal
fm = 10;
am = 1;
message_signal = am*sin(2*pi*fm.*t); %. for element wise multiplication

%Carrier signal
fc = 100;
ac = 2;
carrier_signal = ac*sin(2*pi*fc.*t);

%%performing modulation
modulated_signal = (1+message_signal).*carrier_signal; %unsuppressed carrier


figure;
subplot(3,1,1);
plot(t,message_signal);


subplot(3,1,2);
plot(t,carrier_signal);

subplot(3,1,3);
plot(t,modulated_signal);

%%modulation signal
%%Rectification process
rectified_signal = abs(modulated_signal);

%%Plotting
figure;
subplot(2, 1, 1);
plot(t, modulated_signal);
title('modulated_signal');
xlabel('Time(s)');
ylabel('Amplitude');
grid on;

subplot(2, 1, 2);
plot(t, rectified_signal);
title('Rectified_signal');
xlabel('Time(s)');
ylabel('Amplitude');
grid on;

%Low pass filter
cutoff_freq = 20; %Hz

%FIRfilter design using window method
numtaps = 20;
normalized_cutoff_freq = cutoff_freq / (fs/2);
fir_coeff = fir1(numtaps - 1, normalized_cutoff_freq, 'low');

%Apply the FIR filter to the rectified signal
filtered_signal = filter(fir_coeff, 1, rectified_signal);


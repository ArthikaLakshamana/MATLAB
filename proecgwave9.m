matlab
% Read ECG signal from file
[ecg_data] = audioread('100m.mat');

% Define the order of the Butterworth filter
n = 2;

% Define the cutoff frequency of the filter
cutoff_freq = 50;

% Define the sample rate of the ECG signal
fs = 360;

% Apply the Butterworth filter to the ECG signal
[b, a] = butter(n, cutoff_freq/(fs/2));
filtered_ecg = filter(b, a, ecg_data);

% Plot the original and filtered ECG signals
figure;
subplot(2,1,1);
plot(ecg_data);
title('Original ECG Signal');
xlabel('Samples');
ylabel('Amplitude');

subplot(2,1,2);
plot(filtered_ecg);
title('Filtered ECG Signal');
xlabel('Samples');
ylabel('Amplitude');
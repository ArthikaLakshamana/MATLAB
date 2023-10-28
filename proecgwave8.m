clc;
close all;
matlab
% Read ECG signal from file
[ecg_data] =audioread('100m.mat');

% Define the sampling frequency
fs = 360;

% Define the QRS complex duration
qrs_duration = 0.12;

% Find the R-peak of the ECG signal
rpeak_index = findpeaks(ecg_data, qrs_duration*fs);

% Plot the ECG signal and the R-peak
figure;
subplot(2,1,1);
plot(ecg_data);
title('ECG Signal');
xlabel('Samples');
ylabel('Amplitude');

subplot(2,1,2);
plot(ecg_data);
hold on;
plot(rpeak_index, ecg_data(rpeak_index), 'ro');
title('ECG Signal with R-peak');
xlabel('Samples');
ylabel('Amplitude');
hold off;

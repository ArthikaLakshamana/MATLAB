clc;
close all;
% Load your ECG signal data (replace 'ecg_signal.mat' with your file)
load('100m.mat'); 

% Define the sampling frequency and time vector
Fs = 360; % Replace with your actual sampling frequency
t = (0:length('100m.mat')-1) / Fs;

% Apply a bandpass filter to the ECG signal
low_cutoff = 0.5; % Low-frequency cutoff in Hz
high_cutoff = 50; % High-frequency cutoff in Hz
[b, a] = butter(1, [low_cutoff, high_cutoff] / (Fs / 2), 'bandpass');
filtered_ecg = filtfilt(b, a, '100m.mat');

% Calculate the derivative of the filtered signal
derivative_ecg = diff(filtered_ecg);

% Square the derivative signal
squared_ecg = derivative_ecg.^2;

% Create a moving average filter
window_width = round(0.12 * Fs); % Choose an appropriate window width
ma_filter = ones(1, window_width) / window_width;

% Apply the moving average filter to the squared signal
smoothed_ecg = conv(squared_ecg, ma_filter, 'same');

% Find R-peak candidates (local maxima in the smoothed signal)
[~, r_peak_indices] = findpeaks(smoothed_ecg, 'MinPeakHeight', 0.6 * max(smoothed_ecg));

% Plot the original ECG signal and mark R-peaks
figure;
subplot(2,1,1);
plot(t, ecg_signal);
title('ECG Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(t, smoothed_ecg);
hold on;
plot(t(r_peak_indices), smoothed_ecg(r_peak_indices), 'ro', 'MarkerSize', 5);
title('Smoothed Signal with R-Peak Detection');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% r_peak_indices contains the sample indices of the R-peaks


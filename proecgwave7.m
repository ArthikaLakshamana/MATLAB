% Read ECG signal from file
[ecg_data] =audioread('100m.mat');
% Define the sampling frequency
fs = 360;
% Define the QRS complex duration
qrs_duration = 0.12;
% Find the R-peak of the ECG signal
rpeak_index = findpeaks(ecg_data, qrs_duration*fs);
% Find the indices of the R-peaks that are within the valid range
valid_rpeak_index = find(rpeak_index > 0 & rpeak_index < length(ecg_data));
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
plot(valid_rpeak_index, ecg_data(valid_rpeak_index), 'ro');
title('ECG Signal with R-peak');
xlabel('Samples');
ylabel('Amplitude');
hold off;
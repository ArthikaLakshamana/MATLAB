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

[filename,pathname]=uigetfile('*.*','select the ECG Signal');
filewithpath=char(pathname,filename);
Fs=input('enter sampling rate: ');

ecg = load('100m.mat');
ecgsig=(ecg.val)./200;
t=1:length(ecgsig);
tx=t./Fs;

wt = modwt(ecgsig,4,'sym4');

wtrec = zeros(size(wt));

wtrec(3:4,:) = wt(3:4,:);
y = imodwt(wtrec,'sym4');
y = abs(y).^2;

avg=mean(y);

[Rpeaks,locs]=findpeaks(y,t,'MinpeakHeight',8*avg,'MinPeakDistance',50);

nohb=length(locs);
timelimit=length(ecgsig)/Fs;
hbpermin=(nohb*60)/timelimit;
disp(strcat('Heart Rate= ',(hbpermin)))

subplot(2,1,3)
plot(tx,ecgsig);
xlim([0,timelimit]);
grid on;
xlabel('Seconds')
title('ECG Signal')

subplot(2,1,4)
plot(t,y)
grid on;
xlim([0,length(ecgsig)]);
hold on
plot(locs,Rpeaks,'ro')
xlabel('Samples')
title(strcat('R Peaks found and Heart Rate: ',(hbpermin)))
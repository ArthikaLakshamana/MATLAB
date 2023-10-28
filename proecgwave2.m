[filename,pathname]=uigetfile('*.*','select the ECG Signal');
filewithpath=char(pathname,filename);
Fs=input('enter sampling rate: ');

ecg = load(filename);
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

subplot(211)
plot(tx,ecgsig);
xlim([0,timelimit]);
grid on;
xlabel('Seconds')
title('ECG Signal')

subplot(212)
plot(t,y)
grid on;
xlim([0,length(ecgsig)]);
hold on
plot(locs,Rpeaks,'ro')
xlabel('Samples')
title(strcat('R Peaks found and Heart Rate: ',(hbpermin)))
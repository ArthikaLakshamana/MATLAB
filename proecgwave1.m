clc;
load ('100m.mat')
ECGsignal = (val - 1024)/200;
Fs=360 ;
t = (0:length(ECGsignal)-1)/Fs;
plot(t,ECGsignal)
xe=ECGsignal;
t = repmat(xe,1,3);
Fs = awgn(t,15,'measured');
lev = 4;
xd = wden(Fs,'heursure','s','one',lev,'sym8');
f=figure;
plot(t)
legend('Original Signal');
f2=figure;
plot(Fs)
legend('Noise Signal');
f3=figure;
plot(xd,'r','linewidth',2)
legend('Denoised Signal');
f4=figure;
subplot(3,1,1)
plot(t)
legend('Original Signal');
subplot(3,1,2)
plot(Fs);
legend('Noise Signal');
subplot(3,1,3)
plot(xd,'r','linewidth',2)
legend('Denoised Signal');
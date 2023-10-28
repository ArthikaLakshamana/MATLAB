clc;
close all;
clear all;
xe = ecg(500);
x = repmat(xe,1,3);
y = awgn(x,15,'measured');
lev = 4;
xd = wden(y,'heursure','s','one',lev,'sym8');
f=figure;
plot(x)
legend('Original Signal');
f1=figure;
plot(y)
legend('Noise Signal');
f2=figure;
plot(xd,'r','linewidth',2)
legend('Denoised Signal');
f3=figure;
subplot(3,1,1)
plot(x)
legend('Original Signal');
subplot(3,1,2)
plot(y);
legend('Noise Signal');
subplot(3,1,3)
plot(xd,'r','linewidth',2)
legend('Denoised Signal');
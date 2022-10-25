clc,clear
wp=0.24*pi; ws=0.3*pi; ap=0.1; As=60;

figure;
fs=1000; %采样频率
[xt,t]=xtg(fs);
h=fir_lowpass_filter(wp,ws,As)
yt=fftfilt(h,xt);
Yk=abs(fft(yt));
figure;
subplot(2,1,1);
plot((0:length(yt)-1),yt);
xlabel('t');
ylabel('yt');
title('滤波后信号的连续时域波形图');
subplot(2,1,2);
%plot((0:length(Yk)/2-1)*fs/length(Yk),Yk(1:length(Yk)/2));
% plot((0:length(Yk)-1)*fs/length(Yk),Yk(1:length(Yk)));
stem(Yk,'.');
xlabel('f/Hz');
ylabel('Yk');
title('滤波后信号的幅度频谱图');

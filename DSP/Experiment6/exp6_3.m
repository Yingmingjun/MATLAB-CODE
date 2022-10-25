clear,clc
close all
% 实现了一个对音频信号的整数倍抽取，并保存的案例
[xn,fs]=audioread('motherland.wav');
% sound(5*xn,fs); pause((length(xn)-1)/fs+3);
N=2048;
Yn=1/fs*fft(xn(8000:8199),N);
figure
subplot(311); 
plot((0:N/2-1)*fs/N,abs(Yn(1:N/2))); 
xlabel('f(Hz)');ylabel('Magnitude');
title('某段语音信号模拟域连续幅度谱');

% 语音信号整数倍抽取
D=2;  % D为抽取因子
xn1=xn(1:D:length(xn)); %每隔D-1个点抽取语音信号
Yn1=D/fs*fft(xn1(4000:4099),N);
subplot(312); 
plot((0:N/2-1)*fs/(N*D),abs(Yn1(1:N/2))); 
xlabel('f(Hz)');ylabel('Magnitude');
title('某段语音信号模拟域连续幅度谱(直接抽取)');
% sound(xn1,fs/D);


%假设频谱混叠失真不超过0.1%，频带幅频失真小于1%
wp=0.25*pi;%滤波器的通带截止频率
ws=pi/D;%滤波器的阻带截止频率%pi/D
Rp=0.0873;%滤波器的通带最大衰减
As=60;%滤波器的阻带最小衰减

% wp=0.2*pi;%滤波器的通带截止频率
% ws=0.35*pi;%滤波器的阻带截止频率
% Rp=1;%滤波器的通带最大衰减
% As=15;%滤波器的阻带最小衰减


ripple=10^(-Rp/20);
Attn=10^(-As/20);
Fs=100;
[bd,ad]=LPF_b(wp,ws,Rp,As,Fs);
yn2=filter(bd,ad,xn);

% 语音信号整数倍抽取
D=2;% D为抽取因子
xn2=yn2(1:D:length(yn2)); %每隔D-1个点抽取语音信号
zn2=D/fs*fft(xn2(4000:4099),N);
subplot(313); 
plot((0:N/2-1)*fs/(N*D),abs(zn2(1:N/2))); 
xlabel('f(Hz)');ylabel('Magnitude');
title('某段语音信号模拟域连续幅度谱(先滤波)');
% pause(10)
% sound(xn2,fs/D);

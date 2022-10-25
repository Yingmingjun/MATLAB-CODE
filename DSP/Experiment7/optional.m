clear,clc
close all
[xn,fs]=audioread('motherland.wav');% 读取音频信号

% sound(xn,fs); % 播放音频信号

% pause(length(xn)/fs); % 暂停执行程序 length(xn)/fs 秒，确保音频播放完。
I=2; % 实现I=2的整数倍0值内插
for i=1:length(xn)
 yn1(I*i-1)=xn(i);
 yn1(I*i)= 0;
end

% sound(yn1,I*fs); %采样频率变大了，为 I*fs

wp=pi/I-pi/20;
ws=pi/I;
As=60;
b=fir_lowpass_filter(wp,ws,As);

N=2048;
figure;
Xn=1/fs*fft(xn(8000:8199),N); % 从xn中取200点做谱分析，N可取2048
subplot(3,1,1);
plot((0:N/2-1)*fs/N,abs(Xn(1:N/2)));% 模拟域幅度谱
xlabel('f/Hz')
title('原信号模拟域幅度谱');
Yn1=1/(I*fs)*fft(yn1(16000:16399),N); % 内插后，200点长变成了400点长
subplot(3,1,2);
plot((0:N/2-1)*I*fs/N,abs(Yn1(1:N/2)));
xlabel('f/Hz');
title('I=2 内插后的模拟域幅度谱');
yn2=filter(b,1,yn1); % 对yn1进行滤波，b为所设计的镜像滤波器
Yn2=1/(I*fs)*fft(yn2(16000:16399),N); % 内插后，200点长变成了400点长

% sound(yn2,I*fs); %采样频率变大了，为 I*fs
subplot(3,1,3);
plot((0:N/2-1)*I*fs/N,abs(Yn2(1:N/2)));
xlabel('f/Hz');
title('内插后再经过镜像滤波后的模拟域幅度谱');
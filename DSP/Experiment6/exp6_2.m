clear,clc
close all

wp=0.2*pi;%滤波器的通带截止频率
ws=0.35*pi;%滤波器的阻带截止频率
Rp=1;%滤波器的通带最大衰减
As=15;%滤波器的阻带最小衰减
ripple=10^(-Rp/20);%滤波器的通带衰减对应的幅度值
Attn=10^(-As/20);%滤波器的阻带衰减对应的幅度值
Fs=10;%采样频率

[bd,ad]=LPF_b(wp,ws,Rp,As,Fs);
xn=[-4,-2,0,-4,-6,-4,-2,-4,-6,-6,-4,-4,-6,-6,-2,6,12,8,...
    0,-16,-38,-60,-84,-90,-66,-32,-4,-2,-4,8,12,12,10,6,6,6,...
    4,0,0,0,0,0,-2,-4,0,0,0,-2,-2,0,0,-2,-2,-2,-2,0];
yn=filter(bd,ad,xn);
figure(1)
subplot(2,1,1);
stem(0:length(xn)-1,xn,'b.');
axis([0,60,-100,50]);
xlabel('n','FontSize',10)
title('滤波前信号采样序列');

subplot(2,1,2);
stem(0:length(yn)-1,yn,'b.');
axis([0,60,-100,50]);
xlabel('n','FontSize',10)
title('滤波后信号采样序列');
figure(2)
subplot(4,1,1);
%为保证曲线平滑故取1024点FFT，序列56点，最少只需要64点FFT
zn1=fft(xn,1024);
plot((0:length(zn1)-1)*2/1024,abs(zn1),'b');
title('滤波前频谱');
xlabel('\omega(\pi)','FontSize',10)
ylabel('$$\left|{\rm H}({{e}^{j\omega}}) \right|$$','Interpreter','latex','FontSize',10);
axis([0,2,0,500]);

subplot(4,1,2);
zn2=fft(yn,1024);
plot((0:length(zn2)-1)*2/1024,abs(zn2),'b');
title('滤波后频谱');
xlabel('\omega(\pi)','FontSize',10)
ylabel('$$\left|{\rm H}({{e}^{j\omega}}) \right|$$','Interpreter','latex','FontSize',10);
axis([0,2,0,500]);

subplot(4,1,3);
%为保证曲线平滑故取1024点FFT，序列56点，最少只需要64点FFT
zn1=fft(xn,1024);
plot((0:length(zn1)-1)*2/1024,20*log10((abs(zn1)+eps)/max(abs(zn1))),'b');
title('滤波前频谱');
xlabel('\omega(\pi)','FontSize',10)
ylabel('$$\left|{\rm H}({{e}^{j\omega}}) \right|(\rm dB)$$','Interpreter','latex','FontSize',10);


subplot(4,1,4);
zn2=fft(yn,1024);
plot((0:length(zn2)-1)*2/1024,20*log10((abs(zn2)+eps)/max(abs(zn2))),'b');
title('滤波后频谱');
xlabel('\omega(\pi)','FontSize',10)
ylabel('$$\left|{\rm H}({{e}^{j\omega}}) \right|(\rm dB)$$','Interpreter','latex','FontSize',10);

% zn1=fft(xn,64);
% plot((0:length(zn1)-1)*2/64,abs(zn1),'b');
% title('滤波前频谱');
% axis([0,2,0,500]);
% 
% subplot(4,1,4);
% zn2=fft(yn,64);
% plot((0:length(zn2)-1)*2/64,abs(zn2),'b');
% title('滤波后频谱');
% axis([0,2,0,500]);

clear,clc
close all

wp=0.2*pi;%滤波器的通带截止频率
ws=0.35*pi;%滤波器的阻带截止频率
Rp=1;%滤波器的通带最大衰减
As=15;%滤波器的阻带最小衰减

ripple=10^(-Rp/20);%滤波器的通带衰减对应的幅度值
Attn=10^(-As/20);%滤波器的阻带衰减对应的幅度值
Fs=10;T=1/Fs;
%预修正将数字滤波器设计指标转换为模拟滤波器设计指标
Omgp=(2/T)*tan(wp/2);%原型通带频率的预修正
Omgs=(2/T)*tan(ws/2);%原型阻带频率的预修正

%模拟原型滤波器计算
[n,Omgc]=buttord(Omgp,Omgs,Rp,As,'s')%计算阶数n和3dB截止频率

[ba,aa]=butter(n,Omgc,'s');%直接求模拟滤波器系数

[bd,ad]=bilinear(ba,aa,Fs)%用双线性变换法计算数字滤波器系数

[H,w]=freqz(bd,ad);%求数字系统的频率特性;

dbH=20*log10((abs(H)+eps)/max(abs(H)));

figure(1)
subplot(2,2,1);
plot(w/pi,abs(H));
xlabel('\omega(\pi)','FontSize',10)
ylabel('$$\left|{\rm H}({{e}^{j\omega}}) \right|$$','Interpreter','latex','FontSize',10);
title('幅度响应');
axis([0,1,0,1.1]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.35,1]);
set(gca,'YTickMode','manual','YTick',[0,Attn,ripple,1]);
grid on

subplot(2,2,2);
plot(w/pi,angle(H)/pi);
xlabel('\omega(\pi)','FontSize',10)
ylabel('\phi','FontSize',12);
title('相位响应');
axis([0,1,-1,1]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.35,1]);
grid on

subplot(2,2,3);
plot(w/pi,dbH);
xlabel('\omega(\pi)');
ylabel('(dB)');
title('幅度响应(dB)');
axis([0,1,-40,5]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.35,1]);
set(gca,'YTickMode','manual','YTick',[-40,-15,-1,0]);
grid on

subplot(2,2,4);
zplane(bd,ad);
title('零极点图');
axis([-1.1,1.1,-1.1,1.1]);
grid on
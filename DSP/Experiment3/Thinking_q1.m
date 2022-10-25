%对音频信号进行滤波
clear
clc
close all

%H1系统滤波
b1=[1 0];
a1=[1 0.8];
h1=impz(b1,a1)%求解对应系统的单位冲击响应


%H2系统滤波
b2=[1 0];
a2=[1 -1];
h2=impz(b2,a2);


%H3系统滤波
b3=[1 0];
a3=[1 1.2];
h3=impz(b3,a3);

%音频读取
[xn,fs]=audioread("motherland.wav");

%fs 采样频率为8000Hz
%卷积滤波
y1=conv(xn,h1);
y2=conv(xn,h2);
y3=conv(xn,h3);

%考虑时间区间为[1,2]s
subplot(2,2,1)
k=8000:16000;
fig1=stem(k,xn(8000:16000),'b.');
fig1.LineWidth=0.5;
fig1.MarkerSize=0.5;
set(gca,'xtick',[8000,12000,16000]);
set(gca,'XTickLabel',{'1.0s','1.5s','2.0s'});
grid on
xlabel('t')
ylabel('Amplitude')
title('滤波前时域波形图')


subplot(2,2,2)
fig2=stem(k,y1(8000:16000),'b.');
fig2.LineWidth=0.5;
fig2.MarkerSize=0.5;
set(gca,'xtick',[8000,12000,16000]);
set(gca,'XTickLabel',{'1.0s','1.5s','2.0s'});
grid on
xlabel('t')
ylabel('Amplitude')
title('h1滤波后时域波形图')

subplot(2,2,3)
fig3=stem(k,y2(8000:16000),'b.');
fig3.LineWidth=0.5;
fig3.MarkerSize=0.5;
set(gca,'xtick',[8000,12000,16000]);
set(gca,'XTickLabel',{'1.0s','1.5s','2.0s'});
grid on
xlabel('t')
ylabel('Amplitude')
title('h2滤波后时域波形图')

subplot(2,2,4)
fig4=stem(k,y3(8000:16000),'b.');
fig4.LineWidth=0.5;
fig4.MarkerSize=0.5;
set(gca,'xtick',[8000,12000,16000]);
set(gca,'XTickLabel',{'1.0s','1.5s','2.0s'});
grid on
xlabel('t')
ylabel('Amplitude')
title('h3滤波后时域波形图')





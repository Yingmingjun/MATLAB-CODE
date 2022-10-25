%音频读取
clear
clc

[xn,fs]=audioread("motherland.wav");

sound(xn,fs);%播放音频
fs
% figure(1)
subplot(2,1,1)
k=400:500;
fig1=stem(k,xn(400:500));

%fs=8000Hz， 即采样间隔为：1/8000=1.25e-04;

% figure(2)
subplot(2,1,2)
k=1:16000;

fig2=stem(k,xn(1:16000));
axis([1,16000,-0.4,0.4]);
set(gca,'xtick',[0,4000,8000,12000,16000]);
set(gca,'XTickLabel',{'0.0s','0.5s','1.0s','1.5s','2.0s'});












clear,clc
close all
wp=0.24*pi; ws=0.3*pi;
als=60;
deltaw=ws-wp;

% width=12*pi;
% N0=ceil(width/deltaw); % 根据阻带衰减值，选择blackman窗
% N=N0+mod(N0+1,2); % mod取模运算(这里完成取余运算)
% windows=(blackman(N))';

N0=(als-8)/(2.285*deltaw); % 根据阻带衰减值，选择kaiser窗
N=N0+mod(N0+1,2); % mod取模运算(这里完成取余运算)
beta=0.112*(als-8.7);
windows=(kaiser(N,beta))';%经验公式beta=0.1102(As−8.7), As>50

wc=(ws+wp)/2;
hd=ideal_lp(wc,N);
b=hd.*windows;
% b=fir1(N-1,wc,'low',windows);

[H,w]=freqz(b,1,1000,'whole');
H=(H(1:501))';
w=(w(1:501))';
mag=abs(H);
db=20*log10((mag+eps)/max(mag));
pha=angle(H);
n=0:N-1;
dw=2*pi/1000;

Rp=-(min(db(1:wp/dw+1)))%检验通带波动
As=-round(max(db(ws/dw+1:501)))%检验最小阻带衰减

% 设计要求
% Rp=0.1;
% As=60;
figure
subplot(2,2,1);
stem(n,b,'.');
axis([0,N,1.1*min(b),1.1*max(b)]);
title('实际脉冲响应');
xlabel('n');
ylabel('h(n)');
subplot(2,2,2);
stem(n,windows,'.');
axis([0,N,0,1.1]);
title('窗函数特性');
xlabel('n');
ylabel('wd(n)');
subplot(2,2,3);
plot(w/pi,db);
axis([0,1,-100,10])
title('幅度频率响应');
xlabel('频率(单位:\pi)');
ylabel('H(e^{j\omega})');
set(gca,'XTickMode','manual','XTick',[0,wp/pi,ws/pi,1]);
set(gca,'YTickMode','manual','YTick',[-60,-20,-3,0]);grid
subplot(2,2,4);
plot(w/pi,pha);
axis([0,1,-4,4]);
title('相位频率响应');
xlabel('频率(单位:\pi)');
ylabel('\phi(\omega)');
set(gca,'XTickMode','manual','XTick',[0,wp/pi,ws/pi,1]);
set(gca,'YTickMode','manual','YTick',[-3.1416,0,3.1416,4]);grid



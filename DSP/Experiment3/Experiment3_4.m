clear
clc
close all


a=[1 0 0 0 0 0 0 0 -0.9];
b=[1 0 0 0 0 0 0 0 -1];


subplot(2,2,1);
zplane(b,a)
title("零极点分布图")
legend("零点","极点")

subplot(2,2,2)
impz(b,a,30)
grid on


[H,w]=freqz(b,a,400,'whole');

Hm=abs(H);
Hp=angle(H);

subplot(2,2,3);
plot(w,Hm,'b-',LineWidth=1)
grid on
hold on
xlabel('\omega(rad/s)')
ylabel('Magnitude')
title('离散系统幅频特性曲线')

subplot(2,2,4)
plot(w,Hp,'b-',LineWidth=1)

grid on
xlabel('\omega(rad/s)')
ylabel('Phase')
title('离散系统相频特性曲线')


















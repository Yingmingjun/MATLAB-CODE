%试用 Matlab 画出下列因果系统的系统函数频率响应曲线
% 并判断系统的稳定性。
clear
clc
close all
b1=[1 0 0];
a1=[1 -0.75 0.125];

[H,w]=freqz(b1,a1,400,'whole');
Hm=abs(H);
Hp=angle(H);

subplot(2,1,1);
plot(w,Hm,'b-',LineWidth=1)
grid on
hold on
xlabel('\omega(rad/s)')
ylabel('幅度(Magnitude)')
title('离散系统幅频特性曲线')

subplot(2,1,2)
plot(w,Hp,'b-',LineWidth=1)

grid on
xlabel('\omega(rad/s)')
ylabel('相位(Phase)')
title('离散系统相频特性曲线')

















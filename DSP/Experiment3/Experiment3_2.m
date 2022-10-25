%试用 Matlab 画出下列因果系统的系统函数零极点分布图
% 并判断系统的稳定性。
clear
clc
close all
b1=[2 -1.6 -0.9];
a1=[1 -2.5 1.96 -0.48];


b2=[1 -1];
a2=[1 -0.9 -0.65 0.873 0];


subplot(2,2,1);
zplane(b1,a1)
title("零极点分布图")
legend("零点","极点")

subplot(2,2,2)
impz(b1,a1,100)
grid on

subplot(2,2,3);
zplane(b2,a2)
title("零极点分布图");
legend("零点","极点")

subplot(2,2,4)
impz(b2,a2,100)
grid on



















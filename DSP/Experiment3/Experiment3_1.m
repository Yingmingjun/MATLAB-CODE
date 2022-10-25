%有理函数 z 变换的部分分式展开
% [R,P,K]=residuez(B,A)
% 其中，B，A 分别表示 X(z)的分子与分母多项式的
% 系数向量；R为部分分式的系数向量；P 为极点向量；
% K 为多项式的系数。若 X(z)为有理真分式，则 K 为0;
clear 
clc
close all

B=[2 16 44 56 32];
A=[3 3 -15 18 -12];

[R,P,K]=residuez(B,A)






























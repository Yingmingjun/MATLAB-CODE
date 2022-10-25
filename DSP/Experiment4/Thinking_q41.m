% 对信号x2(n)和x3(n) 做 8 点 和 16 点的 FFT
clear
clc
close all
N1=8;
N2=16;
x=[1 2 3 4 4 3 2 1];
x3=[4:-1:1 1:4];
xk1=fft(x,N1);
xk2=fft(x,N2);
xk3=fft(x3,N1);
xk4=fft(x3,N2);

figure(1)
subplot(211);
fig1=stem(0:N1-1,abs(xk1),'b.');
% title('x2的8点FFT离散幅度谱')
title('$${8-point\,\,{\rm FFT}\,\,for\,\,{{x}_{2}}(n)}$$','Interpreter','latex')
fig1.LineWidth=1;
fig1.MarkerSize=10;
xlabel('$$k$$','Interpreter','latex')
ylabel('$$\left| {{X}_{8}}(k) \right|$$','Interpreter','latex')

subplot(212);
fig2=stem(0:N1-1,abs(xk3),'b.');
% title('x3的8点FFT离散幅度谱')
title('$${8-point\,\,{\rm FFT}\,\,for\,\,{{x}_{3}}(n)}$$','Interpreter','latex')
fig2.LineWidth=1;
fig2.MarkerSize=10;
xlabel('$$k$$','Interpreter','latex')
ylabel('$$\left| {{X}_{8}}(k) \right|$$','Interpreter','latex')

figure(2)
subplot(211);
fig3=stem(0:N2-1,abs(xk2),'b.');
% title('x2的16点FFT离散幅度谱')
title('$${16-point\,\,{\rm FFT}\,\,for\,\,{{x}_{2}}(n)}$$','Interpreter','latex')
fig3.LineWidth=1;
fig3.MarkerSize=10;
xlabel('$$k$$','Interpreter','latex')
ylabel('$$\left| {{X}_{16}}(k) \right|$$','Interpreter','latex')

subplot(212);
fig4=stem(0:N2-1,abs(xk4),'b.');
% title('x3的16点FFT离散幅度谱')
title('$${16-point\,\,{\rm FFT}\,\,for\,\,{{x}_{3}}(n)}$$','Interpreter','latex')
fig4.LineWidth=1;
fig4.MarkerSize=10;
xlabel('$$k$$','Interpreter','latex')
ylabel('$$\left| {{X}_{16}}(k) \right|$$','Interpreter','latex')



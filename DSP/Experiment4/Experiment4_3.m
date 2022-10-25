% 对信号x4(n) 做 8 点 和 16 点的 FFT
clear
clc
close all
N1=8;
N2=16;
n=0:20;
x=cos(n*pi/4);
xk1=fft(x,N1);
xk2=fft(x,N2);

figure(1)
subplot(211);
fig1=stem(0:length(x)-1,x,'b.');
% title('x4的波形')
title('$${Discrete\,\,sequence\,\,of\,\,}{{x}_{4}}(n)$$','Interpreter','latex')
fig1.LineWidth=1;
fig1.MarkerSize=10;
xlabel('$$n$$','Interpreter','latex')
ylabel('$${{x}_{4}}(n)$$','Interpreter','latex')

subplot(212);
fig2=stem(0:N1-1,abs(xk1),'b.');
% title('x4的8点FFT离散幅度谱')
title('$${8-point\,\,{\rm FFT}\,\,for\,\,{{x}_{4}}(n)}$$','Interpreter','latex')
fig2.LineWidth=1;
fig2.MarkerSize=10;
xlabel('$$k$$','Interpreter','latex')
ylabel('$$\left| {{X}_{8}}(k) \right|$$','Interpreter','latex')

figure(2)
subplot(211);
fig3=stem(0:length(x)-1,x,'b.');
% title('x4的波形')
title('$${Discrete\,\,sequence\,\,of\,\,}{{x}_{4}}(n)$$','Interpreter','latex')
fig3.LineWidth=1;
fig3.MarkerSize=10;
xlabel('$$n$$','Interpreter','latex')
ylabel('$${{x}_{4}}(n)$$','Interpreter','latex')

subplot(212);
fig4=stem(0:N2-1,abs(xk2),'b.');
% title('x4的16点FFT离散幅度谱')
title('$${16-point\,\,{\rm FFT}\,\,for\,\,{{x}_{4}}(n)}$$','Interpreter','latex')
fig4.LineWidth=1;
fig4.MarkerSize=10;
xlabel('$$k$$','Interpreter','latex')
ylabel('$$\left| {{X}_{16}}(k) \right|$$','Interpreter','latex')



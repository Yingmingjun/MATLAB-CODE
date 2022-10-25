% 件对信号x6(n)以 fs=64（Hz）采样后做 N=16、32、64 点的FFT
clear
clc
close all
N1=16;
N2=32;
N3=64;
T=1/64;%T=1/fs

n1=0:15;
x1=cos(8*pi*n1*T)+cos(16*pi*n1*T)+cos(20*pi*n1*T);
n2=0:31;
x2=cos(8*pi*n2*T)+cos(16*pi*n2*T)+cos(20*pi*n2*T);
n3=0:63;
x3=cos(8*pi*n3*T)+cos(16*pi*n3*T)+cos(20*pi*n3*T);
xk1=fft(x1,N1);
xk2=fft(x2,N2);
xk3=fft(x3,N3);

figure(1)
subplot(211);
fig1=stem(0:length(x1)-1,x1,'b.');
% title('x6的波形')
title('$${Discrete\,\,sequence\,\,of\,\,}{{x}_{6}}(n)$$','Interpreter','latex')
fig1.LineWidth=1;
fig1.MarkerSize=10;
xlabel('$$n$$','Interpreter','latex')
ylabel('$${{x}_{4}}(n)$$','Interpreter','latex')

subplot(212);
fig2=stem(0:N1-1,abs(xk1),'b.');
% title('x6的16点FFT离散幅度谱')
title('$${16-point\,\,{\rm FFT}\,\,for\,\,{{x}_{6}}(n)}$$','Interpreter','latex')
fig2.LineWidth=1;
fig2.MarkerSize=10;
xlabel('$$k$$','Interpreter','latex')
ylabel('$$\left| {{X}_{16}}(k) \right|$$','Interpreter','latex')

figure(2)
subplot(211);
fig3=stem(0:length(x2)-1,x2,'b.');
% title('x6的波形')
title('$${Discrete\,\,sequence\,\,of\,\,}{{x}_{6}}(n)$$','Interpreter','latex')
fig3.LineWidth=1;
fig3.MarkerSize=10;
xlabel('$$n$$','Interpreter','latex')
ylabel('$${{x}_{6}}(n)$$','Interpreter','latex')

subplot(212);
fig4=stem(0:N2-1,abs(xk2),'b.');
% title('x6的32点FFT离散幅度谱')
title('$${32-point\,\,{\rm FFT}\,\,for\,\,{{x}_{6}}(n)}$$','Interpreter','latex')
fig4.LineWidth=1;
fig4.MarkerSize=10;
xlabel('$$k$$','Interpreter','latex')
ylabel('$$\left| {{X}_{32}}(k) \right|$$','Interpreter','latex')

figure(3)
subplot(211);
fig3=stem(0:length(x3)-1,x3,'b.');
% title('x6的波形')
title('$${Discrete\,\,sequence\,\,of\,\,}{{x}_{6}}(n)$$','Interpreter','latex')
fig3.LineWidth=1;
fig3.MarkerSize=10;
xlabel('$$n$$','Interpreter','latex')
ylabel('$${{x}_{6}}(n)$$','Interpreter','latex')

subplot(212);
fig4=stem(0:N3-1,abs(xk3),'b.');
% title('x6的16点FFT离散幅度谱')
title('$${64-point\,\,{\rm FFT}\,\,for\,\,{{x}_{6}}(n)}$$','Interpreter','latex')
fig4.LineWidth=1;
fig4.MarkerSize=10;
xlabel('$$k$$','Interpreter','latex')
ylabel('$$\left| {{X}_{64}}(k) \right|$$','Interpreter','latex')

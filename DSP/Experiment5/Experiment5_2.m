clear
clc
close all

N=1024;
n=0:26;
xn=(n+1).*(n>=0&n<=13)+(27-n).*(n>=14&n<=26);
figure(1)

subplot(321)%原始波形
fig1=stem(0:length(xn)-1,xn,'.');
fig1.Color='b';
title('$$x(n)$$','Interpreter','latex','FontSize',10);
axis([0,30,0,20])

subplot(322)%连续幅度谱
xk=fft(xn,N);
plot(2*(0:N-1)/N,abs(xk(1:N)),'b');
title('$$\left|{\rm X}({{e}^{j\omega}})\right|$$','Interpreter','latex','FontSize',10);


subplot(324)%32点频域采样
X32k=fft(xn,32);
%stem((0:length(X32k)-1),X32k,'.');
fig2=stem((0:length(X32k)-1),abs(X32k),'.');
fig2.Color='b';
title('$$\left|{\rm X}_{32}({{e}^{j\omega}})\right|$$','Interpreter','latex','FontSize',10);
   
subplot(323);%32点的IDFT
x32n=ifft(X32k,32);
fig3=stem((0:length(x32n)-1),x32n,'.');
fig3.Color='b';
title('$${x}_{32}(n)$$','Interpreter','latex','FontSize',10);
axis([0,30,0,20])

subplot(326)%16点频域采样
X16k=X32k(1:2:length(X32k));
fig4=stem((0:length(X16k)-1),abs(X16k),'.');
fig4.Color='b';
title('$$\left|{\rm X}_{16}({{e}^{j\omega}})\right|$$','Interpreter','latex','FontSize',10);

subplot(325)%16点的IDFT
x16n=ifft(X16k,16);
fig5=stem((0:length(x16n)-1),x16n,'.');
fig5.Color='b';
title('$${x}_{16}(n)$$','Interpreter','latex','FontSize',10);
axis([0,30,0,20])



clc
clear
A=444.128;
a=50*sqrt(2)*pi;
omega=50*sqrt(2)*pi;
t=0:0.001:0.064;
xt=A*exp(-a*t).*sin(omega*t);

subplot(221);
plot(t,xt);
xlabel('t');
ylabel('x(t)');
title('需分析的信号');
grid on;

Tp=0.064;
for fs=1000:-20:200
    N=ceil(Tp*fs);
    n=0:N-1;
    T=1/fs;
    xn=A*exp(-a*n*T).*sin(omega*n*T);
    subplot(223)
    stem(n,xn);
    xlabel('n');
    ylabel('x(n)');
    title(strcat('采样频率fs=',num2str(fs),'Hz时，在64ms观察时间内采样序列'));
    xk=fft(xn,1024)*T;
    k=0:length(xk)-1;
    subplot(222);
    plot(-fs-k*fs/length(xk),abs(xk),'b',-k*fs/length(xk),abs(xk),'b',k*fs/length(xk),abs(xk),'b');
    xlabel('$$f(\rm Hz)$$','Interpreter','latex','FontSize',10)
    ylabel('$$\left|{\rm H}({{e}^{j\omega}}) \right|$$','Interpreter','latex','FontSize',10)
    subplot(224);
    plot(-k*fs/length(xk),-angle(xk),'b',k*fs/length(xk),angle(xk),'b',k*fs/length(xk),angle(xk),'b');
    xlabel('$$f(\rm Hz)$$','Interpreter','latex','FontSize',10)
    ylabel('$$\varphi (\omega)$$','Interpreter','latex','FontSize',10)
    pause(0.1);
end
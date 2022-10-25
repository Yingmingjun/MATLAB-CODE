clear
clc
close all
Tp=0.064;%64ms
for i=1:3
    %初始化信号
    A=444.128;
    a=50*sqrt(2)*pi;
    omega=50*sqrt(2)*pi;
    t=0:0.0001:0.064;
    xt=A*exp(-a*t).*sin(omega*t);

    %根据i选择采样频率1kHz，300Hz，200Hz
    if i==1
        fs=1000;
    elseif i==2
        fs=300;
    elseif i==3
        fs=200;
    end

    N=ceil(Tp*fs);%向上取整
    n=0:N-1;
    T=1/fs;
    xn=A*exp(-a*n*T).*sin(omega*n*T);%采样序列
    Xk=fft(xn,1024)*T;
    size(Xk)
    k=0:length(Xk)-1;

    %绘制需要分析的信号
    figure(i)
    subplot(2,2,1);
    plot(t,xt,'b');
    xlabel('$$t$$','Interpreter','latex','FontSize',10)
    ylabel('$$x(t)$$','Interpreter','latex','FontSize',10)
    title('待分析的信号');
    grid on;

    subplot(2,2,3)
    fig1=stem(n,xn,'.');
    fig1.Color='b';
    xlabel('$$n$$','Interpreter','latex','FontSize',10)
    ylabel('$$x(n)$$','Interpreter','latex','FontSize',10)
    title(strcat('fs=',num2str(fs),'Hz，64ms内的采样序列'));

    subplot(2,2,2)
    plot(k*fs/length(Xk)-fs,abs(Xk),'b',k*fs/length(Xk),abs(Xk),'b',k*fs/length(Xk)+fs,abs(Xk),'b');
    xlabel('$$f(\rm Hz)$$','Interpreter','latex','FontSize',10)
    ylabel('$$\left|{\rm H}({{e}^{j\omega}}) \right|$$','Interpreter','latex','FontSize',10)

    subplot(2,2,4);
    plot(k*fs/length(Xk)-fs,angle(Xk),'b',k*fs/length(Xk),angle(Xk),'b',k*fs/length(Xk)+fs,angle(Xk),'b');
    xlabel('$$f(\rm Hz)$$','Interpreter','latex','FontSize',10)
    ylabel('$$\varphi (\omega)$$','Interpreter','latex','FontSize',10)

end

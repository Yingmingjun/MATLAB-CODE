clear
clc
close all
 
[xn,fs]=audioread('motherland.wav');  
n=1000:2999;  
x=xn(n);  
x=x';     
xk=fft(x,2000); 

subplot(411)  
plot(2*(0:1999)/2000,abs(xk(1:2000)),'b');  
title('连续幅度谱');
xlabel('$$\omega$$','Interpreter','latex','FontSize',10)
ylabel('$$\left|{\rm H}({{e}^{j\omega}}) \right|$$','Interpreter','latex','FontSize',10)
set(gca,'xtick',[0.0, 0.5, 1, 1.5, 2.0]);
set(gca,'XTickLabel',{'0.0','0.5\pi','1.0\pi','1.5\pi','2.0\pi'});

x2=x(1:2:2000);
xk2=fft(x2,2000); 
subplot(412)  
plot(2*(0:1999)/2000,abs(xk2(1:2000)),'b');  
title('连续幅度谱（每2个点抽取1点）');
xlabel('$$\omega$$','Interpreter','latex','FontSize',10)
ylabel('$$\left|{\rm H}({{e}^{j\omega}}) \right|$$','Interpreter','latex','FontSize',10)
set(gca,'xtick',[0.0, 0.5, 1, 1.5, 2.0]);
set(gca,'XTickLabel',{'0.0','0.5\pi','1.0\pi','1.5\pi','2.0\pi'});

x3=x(1:4:2000);
xk3=fft(x3,2000); 
subplot(413)  
plot(2*(0:1999)/2000,abs(xk3(1:2000)),'b');  
title('连续幅度谱（每4个点抽取1点）');
xlabel('$$\omega$$','Interpreter','latex')
ylabel('$$\left|{\rm H}({{e}^{j\omega}}) \right|$$','Interpreter','latex')
set(gca,'xtick',[0.0, 0.5, 1, 1.5, 2.0]);
set(gca,'XTickLabel',{'0.0','0.5\pi','1.0\pi','1.5\pi','2.0\pi'});

x4=x(1:8:2000);
xk4=fft(x4,2000); 
subplot(414)  
plot(2*(0:1999)/2000,abs(xk4(1:2000)),'b');  
title('连续幅度谱（每8个点抽取1点）');
xlabel('$$\omega$$','Interpreter','latex')
ylabel('$$\left|{\rm H}({{e}^{j\omega}}) \right|$$','Interpreter','latex')
set(gca,'xtick',[0.0, 0.5, 1, 1.5, 2.0]);
set(gca,'XTickLabel',{'0.0','0.5\pi','1.0\pi','1.5\pi','2.0\pi'});















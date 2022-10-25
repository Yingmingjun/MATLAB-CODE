clear
clc
close all
 
[xn,fs]=audioread('motherland.wav');  
n=8000:8199;  
x=xn(8000:8199);
% x=x';     
xk=fft(x,512); 

% figure(1) 
subplot(211)  
plot(2*(0:511)/512,abs(xk(1:512)),'b');  
title('连续幅度谱（Continuous amplitude spectrum）');
xlabel('$$\omega$$','Interpreter','latex')
ylabel('$$\left|{\rm H}({{e}^{j\omega}}) \right|$$','Interpreter','latex')
set(gca,'xtick',[0.0, 0.5, 1, 1.5, 2.0]);
set(gca,'XTickLabel',{'0.0','0.5\pi','1.0\pi','1.5\pi','2.0\pi'});


subplot(212)  
plot(2*(0:511)/512,angle(xk(1:512)),'b');  
title('相位谱（Phase spectrum）');  
xlabel('$$\omega$$','Interpreter','latex')
ylabel('$$\varphi (\omega)$$','Interpreter','latex')

set(gca,'xtick',[0.0, 0.5, 1, 1.5, 2.0]);
set(gca,'XTickLabel',{'0.0','0.5\pi','1.0\pi','1.5\pi','2.0\pi'});
clear
clc
close all

%使用函数 fft 分别画出 x、 x1 和 x2 
% 在[0,2π )的连续幅度谱图（提示是序列FT）

x=[1,1,2,2,3,3,2,2,1,1];
x1=[1,2,3,2,1];
x2=[1,0,1,0,2,0,2,0,3,0,3,0,2,0,2,0,1,0,1,0];
N=1:128;
xk=fft(x,128);
xk1=fft(x1,128);
xk2=fft(x2,128);

figure(1)
subplot(311)  
plot(2*(0:127)/128,abs(xk(1:128)),'b',LineWidth=1);
title('x的连续幅度谱');

subplot(312)  
plot(2*(0:127)/128,abs(xk1(1:128)),'b',LineWidth=1);
title('x1的连续幅度谱');

subplot(313)  
plot(2*(0:127)/128,abs(xk2(1:128)),'b',LineWidth=1);
title('x2的连续幅度谱');



% N2=1:32;
% xk3=fft(x,32);
% xk4=fft(x1,32);
% xk5=fft(x2,32);
% figure(2)
% subplot(311)  
% plot(2*(0:31)/32,abs(xk3(1:32)));
% title('x的连续幅度谱');
% 
% subplot(312)  
% plot(2*(0:31)/32,abs(xk4(1:32)));
% title('x1的连续幅度谱');
% 
% subplot(313)  
% plot(2*(0:31)/32,abs(xk5(1:32)));
% title('x2的连续幅度谱');

% N2=1:256;
% xk3=fft(x,256);
% xk4=fft(x1,256);
% xk5=fft(x2,256);
% figure(2)
% subplot(311)  
% plot(2*(0:255)/256,abs(xk3(1:256)));
% title('x的连续幅度谱');
% 
% subplot(312)  
% plot(2*(0:255)/256,abs(xk4(1:256)));
% title('x1的连续幅度谱');
% 
% subplot(313)  
% plot(2*(0:255)/256,abs(xk5(1:256)));
% title('x2的连续幅度谱');



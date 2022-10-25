%x(n)*h(n)
clc
clear
close all
 
nx = -3:3;
x = [3,11,7,0,-1,4,2];
 
nh = -1:4;
h = [2,3,0,-5,2,1];

%Using modified convolution to get the y(n) and its index range
[y,ny]=conv_m(x,nx,h,nh);
 
subplot(3,1,1);
fig1=stem(nx,x,'b.');
fig1.LineWidth=1.2;
fig1.MarkerSize=10;
title('x(n)');
 
subplot(3,1,2);
fig2=stem(nh,h,'b.');
fig2.LineWidth=1.2;
fig2.MarkerSize=10;
title('h(n)');
 
subplot(3,1,3);
fig3=stem(ny, y,'b.');
fig3.LineWidth=1.2;
fig3.MarkerSize=10;
title('y(n)');



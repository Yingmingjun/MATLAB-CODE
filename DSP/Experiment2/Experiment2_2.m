%实验2-2 离散时间系统的零状态响应
clear
clc
close all
%激励信号 x(n)=u(n)-u(n-5)
%单位取样响应 h=0.875.^nh.*(uDT(nh)-uDT(nh-10))

nx=-5:20;
nh=-5:20;

x=uDT(nx)-uDT(nx-5);
h=0.875.^nh.*(uDT(nh)-uDT(nh-10));

y=conv(x,h);


ny1=nx(1)+nh(1);
ny2=nx(end)+nh(end);
ny=ny1:ny2;

subplot(3,1,1)
fig1=stem(nx,x,'b.')
fig1.LineWidth=1.2;
fig1.MarkerSize=10;
grid on
xlabel('n')
title('x(n)')
axis([-6,20,0,5])


subplot(3,1,2)
fig2=stem(nh,h,'b.')
fig2.LineWidth=1.2;
fig2.MarkerSize=10;
grid on
xlabel('n')
title('h(n)')
axis([-6,20,0,5])


subplot(3,1,3)
fig2=stem(ny,y,'b.')
fig2.LineWidth=1.2;
fig2.MarkerSize=10;
grid on
xlabel('n')
title('y(n)')
axis([-6,20,0,5])

























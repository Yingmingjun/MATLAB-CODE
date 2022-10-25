%实验一 MATLAB应用入门和基本信号的产生
clear
clc
%连续信号
%(1) Sa(t)=sin(t)/t;  -10<=t<10
%(2) R4(t);
%(3) 5*exp(0.5*t)*sin(2*pi*t);  0<=t<10
t1=-10:1/100:10;
y1=sin(t1)./t1;

% t2=0;
% y2=heaviside(x+1)-heaviside(x-1);%[1 1 1];

t3=0:1/100:10;
y3=5.*exp(0.5.*t3).*sin(2.*pi.*t3);

subplot(3,1,1)
% figure(1)
fig1=plot(t1,y1,'b-','linewidth',1.2);
hold on
grid on
axis([-10,10,-1,1.5]);
l1=legend({'$Sa(t)$'},'interpreter','latex',Location='best');
set(l1,'FontName','Times New Roman','FontSize',11,'FontWeight','normal');


subplot(3,1,2)
% figure(2)
% fig2=plot(-5:5,y2,'b-','linewidth',1.2);
syms x
fig2=fplot(heaviside(x+1)-heaviside(x-1), [-5, 5],'b-','linewidth',1.2);

l2=legend({'${{R}_{4}}(t)$'},'interpreter','latex',Location='best');
set(l2,'FontName','Times New Roman','FontSize',11,'FontWeight','normal');
axis([-5,5,0,2]);
grid on

subplot(3,1,3)
% figure(3)
fig3=plot(t3,y3,'b-','linewidth',1.2);
grid on
l3=legend({'$5{{e}^{0.5t}}\sin (2\pi t)$'},'interpreter','latex',Location='best');
set(l3,'FontName','Times New Roman','FontSize',11,'FontWeight','normal');



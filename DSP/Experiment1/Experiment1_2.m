%离散信号绘制
%(1) impulse fuction
%(2) R4(k)
%(3) 1.1^k*sin()
clear
clc
% figure(1)
subplot(3,1,1)
k=-3:3;
x=[0 0 0 1 0 0 0];
fig1=stem(k,x);
fig1.LineWidth=1.2;
l1=legend({'$\delta (k)$'},'interpreter','latex',Location='best');
axis([-3,3,0,2])
set(l1,'FontName','Times New Roman','FontSize',11,'FontWeight','normal');


% figure(2)
subplot(3,1,2)
k=0:3;
x=[1 1 1 1];
fig2=stem(k,x);
fig2.LineWidth=1.2;
l2=legend({'${{R}_{4}}(k)$'},'interpreter','latex',Location='best');
axis([0,3,0,2])
set(l2,'FontName','Times New Roman','FontSize',11,'FontWeight','normal');

%figure(3)
subplot(3,1,3)
k=0:60;
x=(1.1.^k).*sin(0.05*pi.*k);
fig3=stem(k,x);
fig3.LineWidth=1.2;
l3=legend({'${{1.1}^{k}}\sin (0.05\pi k)$'},'interpreter','latex',Location='best');
set(l3,'FontName','Times New Roman','FontSize',11,'FontWeight','normal')
axis([0,60,-50,200])













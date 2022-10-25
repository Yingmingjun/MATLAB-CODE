
%本函数用于计算DSP第二章31题

%判断系统稳定
A=[2, -2.98, 0.17, 2.3418, -1.5147];%分母多项式系数
B=[0, 0, 1, 5, -50];%分子多项式系数

%利用极点分布判断系统稳定
% subplot(2,1,1);
zplane(B,A);%绘制零极图
p=roots(A);%求解极点
p_abs=abs(p);

if max(p_abs)<1
    disp('Stable system\n');
else 
    disp('Unsatable system\n');
end
% 
% u=ones(1,500);
% s=filter(B,A,u);

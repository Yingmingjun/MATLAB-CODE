%判断系统函数的滤波器类型及实际功能
clear
clc
close all
b=[1 -2 2];
a=[2 -2 1];


% [Z,P,K]=tf2zp(b,a);

[Z,P,K]=tf2zp(b,a)

%去除零极点中重复点，寻找出存在的极点
C=ones(1,length(P));

for i=1:length(P)
    for j=1:length(Z)
        if P(i)==Z(j)
            C(i)=0;
            Z(j)=[];
        end
    end
end

P(C==0)=[];

%判断系统是否稳定
if max(abs(P))<1
   fprintf("系统稳定！\n")
else
   fprintf("系统不稳定！\n")
end



subplot(2,2,1)
zplane(b,a)
title("零极点分布图")
legend("零点","极点",Location="best")

subplot(2,2,2)
impz(b,a,30)
grid on

[H,w]=freqz(b,a,400,'whole');
Hm=abs(H);
Hp=angle(H);


subplot(2,2,3);
plot(w,Hm,'b-',LineWidth=1)
grid on
hold on
xlabel('\omega(rad/s)')
ylabel('Magnitude')
title('离散系统幅频特性曲线')

subplot(2,2,4)
plot(w,Hp,'b-',LineWidth=1)

grid on
xlabel('\omega(rad/s)')
ylabel('Phase')
title('离散系统相频特性曲线')

























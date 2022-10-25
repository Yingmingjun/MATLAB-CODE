%实验2-1 离散时间系统的单位取样响应，并判断系统的稳定性
clear
clc
close all

% 3y(n) + 4y(n−1) + y(n−2) = x(n) + x(n−1)
subplot(2,1,1)

A1=[3 4 1];
B1=[1 1 0];
impz(B1,A1,30);
grid on

title('系统单位取样响应h(n)')
p1_1=roots(A1);
p1_2=roots(B1);

pm1=abs(p1_1(~ismember(p1_1, p1_2)));
if max(pm1)<1
    fprintf('系统1因果稳定\n');
else
    fprintf('系统1非因果稳定\n')
end

% 2.5y(n) + 6y(n-1) + 10y(n-2) = x(n)
subplot(2,1,2)

A2=[2.5 6 10];
B2=[1];

impz(B2,A2,30);
grid on

title('系统单位取样响应h(n)')

p2_1=roots(A2);
p2_2=roots(B2);
pm2=abs(p2_1(~ismember(p2_1, p2_2)));

if max(pm2)<1
    fprintf('系统2因果稳定\n');
else
    fprintf('系统2非因果稳定\n')
end












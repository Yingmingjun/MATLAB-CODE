clear all;clc;
%读取数据
data=xlsread('data.xlsx');
% x1=data(2:100,1);
% x2=data(2:100,2);
% x3=data(2:100,3);
% x4=data(2:100,4);
% x5=data(2:100,5);
% x6=data(2:100,6);
% x7=data(2:100,7)./710;
% x8=data(2:100,8)./710;
% x9=data(2:100,9);
% x10=data(2:100,10);
% 
% y1=data(2:100,11);

x1=data(2:200,1);
x2=data(2:200,2);
x3=data(2:200,3);
x4=data(2:200,4);
x5=data(2:200,5);
x6=data(2:200,6);
x7=100.*data(2:200,7)/710;
x8=100.*data(2:200,8)/710;
x9=data(2:200,9);
x10=data(2:200,10);

y1=data(2:200,11);
%拟合
beta0=[0 0 0 0 0 0 0 0 0 0 0];                  % b1, b2, b3 Initial values
X=[x1 x2 x3 x4 x5 x6 x7 x8 x9 x10];                        % Independent variable (1 column)
[parameters1,resnorm]=lsqcurvefit(@func,beta0,X,y1)  
%结果展示
y11=func(parameters1,X);
figure;
plot(1:length(y1),y1,'+',1:length(y11),y11,'o');
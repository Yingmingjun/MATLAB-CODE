%实验2-3 离散时间系统的零状态响应用数字图像处理中的 Sobel 算子，
% 调用 conv2 函数对 lena 图像进行滤波。
% 设两个 3×3 的 Sobe 矩阵算子 Gx=[-1 0 1;-2 0 2;-1 0 1]，
% Gy=[1 2 1;0 0 0;-1 -2 -1]。
% （1）读取 lena 图像数据，保存到 B 矩阵中；
% （2）分别采用 Gx 和 Gy 与的 B 进行卷积滤波；
% （3）在一个 figure 中分子图画出原始图像、经过 Gx 滤波后图像
% 和经过 Gy 滤波后图像，观察滤波后的效果。

clear
clc
close all
Gx = [-1  0  1;...
      -2  0  2;...
      -1  0  1];

Gy = [1  2  1;...
      0  0  0;...
     -1 -2 -1];


B=imread('lena.bmp');

C1=conv2(B,Gx);

C2=conv2(B,Gy);



subplot(1,3,1)
imshow(B);
xlabel('原始图像','Fontsize',12,'Color','b');

subplot(1,3,2);

imshow(C1);
xlabel('Gx滤波后图像','Fontsize',12,'Color','r');

subplot(1,3,3);

imshow(C2);
xlabel('Gy滤波后图像','Fontsize',12,'Color','m');


% 编写 Matlab 程序， 分析 lena 图像的二维频谱，
% 调用 fft2 和 fftshift 函数实现。
% 要求： 显示时域原图、二维幅度谱图。
clear
clc
close all
B1=imread('lena.bmp');
FFT2_lena=fft2(B1);% 二维离散傅里叶变换
H_absolute=abs(FFT2_lena);% 取模值

% 把幅度限定在[0,255]
% 假设原图像是8位灰度图像，
% 那么读入的像素矩阵最大值为255，最小值为0
% B1_limit=(B1-min(min(B1)))/(max(max(B1))-min(min(B1)))*255;
B1_limit=(H_absolute-min(min(H_absolute)))/(max(max(H_absolute))-min(min(H_absolute)))*255;
figure(1)
subplot(1,3,1)
imshow(B1);
xlabel('原始图像','Fontsize',8);

subplot(1,3,2)
% figure(2)
imshow(B1_limit);
xlabel('二维幅度谱图','Fontsize',8);

subplot(1,3,3)
% figure(3)
B= fftshift(B1_limit);
%把二维幅度谱图像分为
% 1   2
% 3   4
%fftshift后变为
% 4   3
% 2   1
imshow(B); 
xlabel('移到中心位置的二维频谱图','Fontsize',8);




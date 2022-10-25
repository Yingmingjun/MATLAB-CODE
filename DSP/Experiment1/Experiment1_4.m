close all
clear
clc

X = imread('lena_color.jpg'); %读名字为这个字符串的图片X

I = im2gray(X); %X的RGB图像转化为灰度图片

subplot(1,2,1)

imshow(X)
xlabel('Before transform')

subplot(1,2,2)
imshow(I)
xlabel('After transform')
% 使用不同算子进行边缘提取
clear 
clc
close all
% Roberts算子(交叉微分算法)
Rx=[-1 0; 0 1];
Ry=[0 -1; 1 0];

%Prewitt算子

Px = [-1  0  1;...
      -1  0  1;...
      -1  0  1];
Py = [-1  -1  -1;...
       0   0   0;...
       1   1   1];

%Laplacian算子八邻域
L2 = [-1  -1  -1;...
      -1   8  -1;...
      -1  -1  -1];

B1=imread('lena.bmp');
R1=conv2(B1,Rx);
R2=conv2(B1,Ry);
P1=conv2(B1,Px);
P2=conv2(B1,Py);
C2=conv2(B1,L2);

BW1 = edge(B1,'sobel'); %应用 Sobel 算子进行滤波
BW2 = edge(B1,'roberts'); %应用 Roberts 算子进行滤波
BW3 = edge(B1,'prewitt'); %应用 Prewitt 算子进行滤波
BW4 = edge(B1,'log'); %应用 LOG 算子进行滤波
BW5 = edge(B1,'canny'); %应用 Canny 算子进行滤波
figure(1)
subplot(2,3,1)
imshow(B1);
xlabel('原始图像','Fontsize',12,'Color','b');

subplot(2,3,2);
imshow(R1);
xlabel('Roberts算子Rx滤波','Fontsize',12,'Color','k');

subplot(2,3,3);
imshow(R2);
xlabel('Roberts算子Ry滤波','Fontsize',12,'Color','k');

subplot(2,3,4);
imshow(P1);
xlabel('Prewitt算子Px滤波','Fontsize',12,'Color','k');

subplot(2,3,5);
imshow(P2);
xlabel('Prewitt算子Py滤波','Fontsize',12,'Color','k');

subplot(2,3,6);
imshow(C2);
xlabel('八邻域Laplacian算子滤波','Fontsize',12,'Color','k');

figure(2)
subplot(1,3,1)
imshow(B1);
xlabel('原始图像','Fontsize',26,'Color','b');

subplot(1,3,2)
imshow(R1+R2)
xlabel('Roberts算子滤波','Fontsize',26,'Color','k');

subplot(1,3,3)
imshow(P1+P2)
xlabel('Prewitt算子滤波','Fontsize',26,'Color','k');

% subplot(2,3,2),imshow(BW1),title('Sobel算子边缘检测');
% subplot(2,3,3),imshow(BW2),title('Roberts算子');
% subplot(2,3,4),imshow(BW3),title('Priwitt算子');
% subplot(2,3,5),imshow(BW4),title('LOG算子');
% subplot(2,3,6),imshow(BW5),title('Canny算子');





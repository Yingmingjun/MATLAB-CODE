function classpractice2_5(~)
clear
clc
disp('-----------------------------------------------------------------------------')
disp('-------------------------This is Class Practice 2.5--------------------------')
disp('---------Simulation of (complex) Rayleigh flat fading channels---------')
disp('--------------------By Mingjun Ying at July 25th 2021-------------------')
disp('-----------------------------------------------------------------------------')
fprintf("\n")

%Generate a large number of random samples
alpha=randn(1,1e7)+1i*randn(1,1e7);
figure(1)
%Plot the histograms of the magnitudes and phases
hist(abs(alpha), 100)

figure(2)
%Compute the pdf of a Rayleigh distribution with parameter B = 0.5
x = [0:0.01:10];
p0 = raylpdf(x,0.5);
plot(x,p0,'r-','linewidth',1.2)
hold on
p1 = raylpdf(x,1);
plot(x,p1,'g-','linewidth',1.2)
p2 = raylpdf(x,2);
plot(x,p2,'b-','linewidth',1.2)
p3 = raylpdf(x,3);
plot(x,p3,'m-','linewidth',1.2)
p4 = raylpdf(x,4);
plot(x,p4,'c-','linewidth',1.2)
legend('\sigma = 0.5','\sigma = 1','\sigma = 2','\sigma = 3','\sigma = 4');
hold off

figure(3)
hist (angle(alpha),100)
end
function classpractice2_1(~)
clear
clc
%This function is apply for calculating the Pr/P0 accroading to the distance
%and the shadowing a standard distribution

disp('-----------------------------------------------------------------------------')
disp('This is Class Practice 2.1(shadowing effect)')
disp('--------------------By Mingjun Ying at July 25th 2021--------------------')

disp('-----------------------------------------------------------------------------')


D=input('The range of the distance from 1m:');
alpha=input('Path loss exponent:');
sigma=input('The square root of the power of the shadowing effect (dB):');
Nsample=input('How many samples for each distance?');

delta=D/100;
d=1:delta:D;%Generate the distance martrix
Pr_nor=zeros(length(d),Nsample);%pre-allocation

for n=1:length(d)
    % the shadowing in dB satisfy the standard distribution,
    %to reduce the complexity in calculation
    Psi=randn(1,Nsample)*sigma;
    %It wonn't change with the same distance
    for m=1:Nsample
        %Psi=randn(1,Nsample)*sigma;
        Pr_nor(n,m)=-10*alpha*log10(d(n))+Psi(m);
    end
end

for n=1:length(d)
    semilogx(d(n)*ones(1,Nsample),Pr_nor(n,:),'o');
    % semilogx should input the matrix with same dimension.Thus, we
    % multiply d(n) with ones(1,Nsample) correspond to Pr_P0(n,:)
    hold on
end

grid on
xlabel('Distance (m) in log scale')
ylabel('Normalized received power (dB)')
str=sprintf('Shadowing effect with \\alpha = %g and \\psi  = %g',alpha,sigma);
title(str);

end


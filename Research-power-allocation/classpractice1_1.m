function classpractice1_1( ~ )
clear
clc
%This function is apply for calculate the reuse factor N
%Given (k,l), which can be described as N=k^2+l^2+k*l
disp('-----------------------------------------------------------------------------')
disp('This is Class Practice 1.1')
disp('--------------------By Mingjun Ying at July 18th 2021--------------------')
disp('Given (k,l), get the value of N' )
disp('-----------------------------------------------------------------------------')

fprintf("\n")
K=input('What is the range of k?');
L=input('What is the range of l?');
fprintf("\n")
disp('The outputs are as follows:')
fprintf("\n")

for k=1:K
    for l=1:L
        N(k,l)=k^2+l^2+k*l;
        fprintf('(k,l)=(%d,%d), N=%d\n',k,l,N(k,l));
    end
end
end


function classpractice1_2( ~ )

clear
clc
%This function is apply for calculate the SIR
%Given N, SIR can be described as SIR = sqrt(3N)^Alpha/6
disp('-----------------------------------------------------------------------------')
disp('This is Class Practice 1.2')
disp('--------------------By Mingjun Ying at July 18th 2021--------------------')
disp('Given N, get the value of SIR approximately' )
disp('-----------------------------------------------------------------------------')

fprintf("\n")
% N=input('What is the value of N?');
Alpha=input('What is the value of Alpha?');
N=getN;

fprintf("\n")
disp('The outputs are as follows:')
fprintf("\n")

for i=1:length(N)
%This used for calculating the SIR approximately
SIR_approximate = ((sqrt(3*N(i)))^Alpha)/6.0;

%Transfrom the SIR_approximate to dB
SIR_appdB = 10*log10(SIR_approximate);

%display the value of approximate SIR 
fprintf('The approximate SIR for N = %d is %g = %gdB\n',N(i),SIR_approximate,SIR_appdB);
x(i)=N(i);
y(i)=SIR_appdB;

end
plot(x,y,'-o')
xlabel('The frequency reuse factor N');
ylabel('Approximate SIR in dB');
title('Relation between frequency reuse factor and SIR');
end


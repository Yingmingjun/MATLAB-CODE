function classpractice1_3( ~ )
clear
clc
%This function is apply for calculate the SIR
%Given N(k,l), SIR can be described as SIR = sqrt(3N(k,l))^Alpha/6
disp('-----------------------------------------------------------------------------')
disp('This is Class Practice 1.3')
disp('--------------------By Mingjun Ying at July 18th 2021--------------------')
disp('Given (k,l), get the value of SIR' )
disp('-----------------------------------------------------------------------------')

fprintf("\n")
K=input('What is the range of k?');
L=input('What is the range of l?');
Alpha=input('What is the value of Alpha?');
fprintf("\n")
disp('The outputs are as follows:')
fprintf("\n")  

    for k=1:K
        for l=1:L
            N(k,l)=k^2+l^2+k*l;
            SIR_approximate(k,l) = (sqrt(3*N(k,l))^Alpha)/6.0;
            SIR_app_dB(k,l) = 10*log10(SIR_approximate(k,l));
            %Q = D/R=sqrt(3*N(k,l))
            Q(k,l) = sqrt(3*N(k,l));
            SIR_acc(k,l) = ((Q(k,l)+1)^(-Alpha)+(Q(k,l)+0.5)^(-Alpha)+Q(k,l)^(-Alpha)+2*(Q(k,l)-1)^(-Alpha)+(Q(k,l)-0.5)^(-Alpha))^(-1);
            SIR_acc_dB(k,l) = 10*log10(SIR_acc(k,l));
            fprintf('For (k,l) = (%d,%d), N =%3d, and the approximate SIR is %6g = %gdB£¬  ',k,l,N(k,l),SIR_approximate(k,l),SIR_app_dB(k,l));
            fprintf('the accurate SIR is %6g = %gdB\n',SIR_acc(k,l),SIR_acc_dB(k,l));
        end
    end

end


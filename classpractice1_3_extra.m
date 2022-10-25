function classpractice1_3_extra( ~ )
clc
%This function is apply for calculate the SIR
%Given N(k,l), SIR can be described as SIR = sqrt(3N(k,l))^Alpha/6
disp('-----------------------------------------------------------------------------')
disp('This is Class Practice 1.3 extra')
disp('--------------------By Mingjun Ying at July 18th 2021--------------------')
disp('Given (k,l), get the value of SIR' )
disp('-----------------------------------------------------------------------------')

fprintf("\n")
K=input('What is the range of k?');
L=input('What is the range of l?');

alpha = input('What is the range of the pathloss factor?');
Alpha = 1:alpha;
fprintf("\n");
disp('The outputs are as follows:');
fprintf("\n")

%preallocating a variable or array before entering the loop by using zeros
%  SIR_approximate=zeros(length(Alpha),K,L);
%  SIR_app_dB=zeros(length(Alpha),K,L);
%  SIR_acc=zeros(length(Alpha),K,L);
%  SIR_acc_dB=zeros(length(Alpha),K,L);

for a_index = 1:length(Alpha)
    for k=1:K
        for l=1:L
            N(k,l)=k^2+l^2+k*l;
            SIR_approximate(a_index,k,l) = (sqrt(3*N(k,l))^Alpha(a_index))/6.0;
            SIR_app_dB(a_index,k,l) = 10*log10(SIR_approximate(a_index,k,l));
            
            %Q = D/R=sqrt(3*N(k,l))
            Q(k,l) = sqrt(3*N(k,l));
            
            SIR_acc(a_index,k,l) = ((Q(k,l)+1)^(-Alpha(a_index))+(Q(k,l)+0.5)^(-Alpha(a_index))+Q(k,l)^(-Alpha(a_index))+...
                2*(Q(k,l)-1)^(-Alpha(a_index))+(Q(k,l)-0.5)^(-Alpha(a_index)))^(-1);
            
            SIR_acc_dB(a_index,k,l) = 10*log10(SIR_acc(a_index,k,l));
            

            
            fprintf('For alpha = %g (k,l) = (%d,%d), N =%d, the approximate SIR is %g = %gdB£¬and the accurate SIR is %g = %gdB\n',...
                Alpha(a_index),k,l,N(k,l),SIR_approximate(a_index,k,l),SIR_app_dB(a_index,k,l),SIR_acc(a_index,k,l),SIR_acc_dB(a_index,k,l));
            
        end
    end
    fprintf('\n');
end

end


function error_calculate(~)

%This function is apply for calculate the SIR's relative error

disp('-----------------------------------------------------------------------------')
disp('This is relative error caculator')
disp('--------------------By Mingjun Ying at July 20th 2021--------------------')
disp('Given Alpha and N, get the value of SIR and calculate the relative error' )
disp('-----------------------------------------------------------------------------')

fprintf("\n")

alpha = input('What is the range of the pathloss factor alpha ?');
Alpha = 1:alpha;
N=getN;


%preallocating a variable or array before entering the loop by using zeros
%  SIR_approximate=zeros(a_index,i);
%  SIR_app_dB=zeros(a_index,i);
%  SIR_acc=zeros(a_index,i);
%  SIR_acc_dB=zeros(a_index,i);

fprintf("\n");
disp('The outputs are as follows:');
fprintf("\n")

for a_index = 1:length(Alpha)
    for i=1:length(N)
        
        SIR_approximate(a_index,i) = (sqrt(3*N(i))^Alpha(a_index))/6.0;
        SIR_app_dB(a_index,i) = 10*log10(SIR_approximate(a_index,i));
        
        %Q = D/R=sqrt(3*N(i))
        Q(i) = sqrt(3*N(i));
        
        SIR_acc(a_index,i) = ((Q(i)+1)^(-Alpha(a_index))+(Q(i)+0.5)^(-Alpha(a_index))+Q(i)^(-Alpha(a_index))+...
            2*(Q(i)-1)^(-Alpha(a_index))+(Q(i)-0.5)^(-Alpha(a_index)))^(-1);
        SIR_acc_dB(a_index,i) = 10*log10(SIR_acc(a_index,i));
        
        %calculate relative error between SIR_approximate and SIR_acc in percentage
        error_relative(a_index,i)=(abs((SIR_approximate(a_index,i)-SIR_acc(a_index,i))/SIR_acc(a_index,i)))*100;
        y1=error_relative(a_index,i);
        fprintf('For alpha = %g, N =%d, the approximate SIR is %g = %gdB£¬and the accurate SIR is %g = %gdB, the relative error is %g%%',...
            Alpha(a_index),N(i),SIR_approximate(a_index,i),SIR_app_dB(a_index,i),SIR_acc(a_index,i),SIR_acc_dB(a_index,i),error_relative(a_index,i));
        fprintf('\n');
    end
    fprintf('\n');
end

fprintf('\n');
plot(N,error_relative(1,:), 'r^-',N,error_relative(2,:), 'bo-',N,error_relative(3,:), 'gd-','linewidth',1);
legend('\alpha = 1','\alpha = 2','\alpha = 3');
xlabel('The frequency reuse factor N');
ylabel('Relative error in percentage');
title('The relative error between approximate SIR and accurate SIR in percentage');

end
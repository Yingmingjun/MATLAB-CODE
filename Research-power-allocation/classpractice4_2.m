function classpractice4_2(~)

clear
clc

disp('----------------------------------------------------------------------')
disp('----------------------This is Class Practice 4.2----------------------')
disp('-------------Simultaneous Water-Filling Power Allocation--------------')
disp('--------An M-cell network with one user per cell is considered--------')
disp('-------------------By Mingjun Ying at August 9th, 2021----------------')
disp('----------------------------------------------------------------------')


U=input('Number of cells or users:');
Nf=input('Number of frequency channels:');
Nsim=input('Number of random simulations:');
aveSNRdB=input('The range of average SNR in dB:');
aveSNR=10.^(aveSNRdB/10);
P=1;
sigma=sqrt(P./aveSNR);
disp('----------------------------------------------------------------------')
disp('----------------------------------------------------------------------')

tic
for m=1:length(aveSNR)
    
    for n=1:Nsim
        
        H=(randn(Nf,U,U)+1i*randn(Nf,U,U))/sqrt(2); % H(f,b,u)-channel on frequency f from cell b to user u (in cell u)
        p=sWFpa(H,sigma(m),P);
        
        for u=1:U
            Cap(u)=0;
            
            for f=1:Nf
                I(f)=sigma(m)^2;
                for u_=1:U
                    if u_~=u
                        I(f)=I(f)+p(f,u_)*abs(H(f,u_,u))^2;
                    end
                end
                sinr(f,u)=p(f,u)*abs(H(f,u,u))^2/I(f);
                Cap(u)=Cap(u)+log2(1+sinr(f,u));
            end
            
        end
         
        Net_Cap(m,n)=sum(Cap);
    end
    
    ave_Net_Cap(m)=mean(Net_Cap(m,:));
    fprintf('Average network capacity when SNR=%gdB is %g\n',aveSNRdB(m),ave_Net_Cap(m));

end
disp('----------------------------------------------------------------------')

toc

% Yplot=input('Plot the results(Y=1/N=0)?");
%if Yplot==1
plot(aveSNRdB,ave_Net_Cap,'linewidth',2);
grid on
xlabel('Average SNR in dB');
ylabel('Average network capacity in bps/Hz');
title('Simultaneous Water-Filling Allocation');
%end
end

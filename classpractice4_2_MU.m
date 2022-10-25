function classpractice4_2_MU(~)

clear
clc

disp('----------------------------------------------------------------------')
disp('----------------------This is Class Practice 4.2----------------------')
disp('-------------Simultaneous Water-Filling Power Allocation--------------')
disp('-----An 7-cell network with multiple users per cell is considered-----')
disp('-------------------By Mingjun Ying at August 9th, 2021----------------')
disp('----------------------------------------------------------------------')



Um=input('Average number of users per cell:');
Nf=input('Number of frequency channels:');
Nsim=input('Number of random simulations:');
aveSNRdB=input('The range of average SNR in dB:');
aveSNR=10.^(aveSNRdB/10);
P=1;
sigma=sqrt(P./aveSNR);

t=0.9;%rho is based on the distance
e=0.5774*0.9;
r=0.5000*0.9;
rho=[1  t  t  t  t  t  t;...%1
    t  1  t  e  r  e  t;...%2
    t  t  1  t  e  r  e;...%3
    t  e  t  1  t  e  r;...%4
    t  r  e  t  1  t  e;...%5
    t  e  r  e  t  1  t;...%6
    t  t  e  r  e  t  1];  %7

% Setting the number of active users for all the cells
for nc=1:7
    % the number of user in cell c
    U(nc)=poissrnd(Um);
end
disp('----------------------------------------------------------------------')
disp('----------------------------------------------------------------------')

tic
%SWF
for m=1:length(aveSNR)
    
    for n=1:Nsim
        %initialize all the frequency channel
        
        H=(randn(7,7,max(U),Nf)+1i*randn(7,7,max(U),Nf)/sqrt(2));
        %sizeH=size(H)
        
        %calculate the capacity
        p=sWFpa_MU(H,sigma(m),P,U,Nf);
        for nc=1:7
            for u=1:U(nc)
                %User u in cell c only
                Cap(nc,u)=0;
                
                for f=1:Nf
                    I(f)=sigma(m)^2;
                    for nc_=1:7
                        for u_=1:U(nc_)
                            if nc_~=nc||u_~=u
                                I(f)=I(f)+rho(nc,nc_)*p(f,nc_,u_)*abs(H(nc_,nc,u,f))^2;
                            end
                        end
                    end
                    sinr(f,nc,u)=p(f,nc,u)*abs(H(nc,nc,u,f))^2/I(f);
                    Cap(nc,u)=Cap(nc,u)+log2(1+sinr(f,nc,u));
                end
            end
            if U(nc)>=1
                Cap_cell(nc)= sum(Cap(nc,1:U(nc)));
            else
                Cap_cell(nc)=0;
            end
        end
        Net_Cap(m,n)=sum(Cap_cell);
    end
    ave_Net_Cap(m)=mean(Net_Cap(m,:));
    fprintf('Average network capacity at SNR=%gdB is %g\n',aveSNRdB(m),ave_Net_Cap(m));
    
end
disp('----------------------------------------------------------------------')

toc

% Yplot=input('Plot the results(Y=1/N=0)?");
%if Yplot==1
plot(aveSNRdB,ave_Net_Cap,'linewidth',1.2);
grid on
xlabel('Average SNR in dB');
ylabel('Average network capacity in bps/Hz');
title('Simultaneous Water-Filling Allocation');
% end

end
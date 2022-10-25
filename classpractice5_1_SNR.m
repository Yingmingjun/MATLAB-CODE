function classpractice5_1_SNR(~)
clc
disp('---------------------------------------------------------')
disp('---Class Practice 5.1-Dynamic Frequency Allocation-------')
disp('-----------------Capacity vs SNR-------------------------')
disp('For SWF, please enter 0.');
disp('For tx-ITL with a fixed S, please enter 1.');
disp('For Self-optimizing ex-ITL, please enter 2.');
disp('For FLG, please enter 3.');
% disp('For FFR+IFR3, please enter 4.');
% disp('For FFR+SWF, please enter 5.');
disp('---------------------------------------------------------')

while 1
    mOPTION=input('Please enter the number of your item');
    if mOPTION ==1 || mOPTION ==2||mOPTION==3
        break;
    end
end

OPTIONS(1)=mOPTION;
if mOPTION==1||mOPTION==2
        S=input('What is the transimit interference tempearture limit');
        OPTIONS(2)=S;
        if mOPTION ==2
            beta=input('What is beta？');
            OPTIONS(3)=beta;
        end
    end
B=input('Number of cells or BSs:');
Um=input('The average number of users per cell:');
Nf=input('Number of frequency channels:');
Nsim=input('Number of random simulations:');
aveSNRdB=input('Average SNR per user in dB:');

aveSNR=10.^(aveSNRdB/10);%
P=1;
sigma=P./sqrt(aveSNR);
fprintf('n');

%%%%Nsim random simulations for average capacity%%%
for n=1:Nsim
    %%for each random simulation%%
    %Generate the number of users in each cell
    for b=1:B
        U(b)=poissrnd(Um);
    end
    %gengerate the channels
    for b_=1:B
        for b=1:B
            for u=1:U(b)
                H(b_,b,u,1:Nf)=(randn(1,Nf)+1i*randn(1,Nf))/sqrt(2);
            end
        end
    end
    
    %%%Power allocation according to the chosen methods (key step)%%
    popt=sWF(H,sigma,Nf,B,U,OPTIONS);
    
    %Compute the capacity
    for b=1:B
        for u=1:U(b)
   %compute the capacity of user u in cell b for all the frequencies
   C_users(b,u)=0;
   %Compute the inerference of user u in cell b
   for f=1:Nf
       I(f)=0;
       
       for b_=1:B
           for u_=1:U(b_)
               if ~(b_==b&&u_==u)
                   I(f)=I(f)+popt(b_,u_,f)*abs(H(b,b,u,f))^2;
               end
           end
       end
       C_user(b,u)=C_user(b,u)+log2(1+popt(b,u,f)*abs(H(b,b,u,f))^2/(sigma^2+I(f)));
   end
        end
    %Compute the capacity of cell b
    if U(b)>=1
        C_cell(b)=sum(C_user(b,1:U(b)));
    else
        C_cell(b)=0;
        end
    end
    
    %the network capacity for each random simulation
    C_Net(n)=sum(C_cell);
    if mod(n,10)==0
        fprintf('\n');
        fprintf('%d simulations completed\n',n);
    end
end
%The average network capacity
ave_C_Net=mean(C_Net(m,:));
fprintf('\n');
disp('---------------------------------------------------------')
fprintf('For SNR=%d dB,the average network capacity is %g\n',aveSNRdB(m),ave_C_Net(m));
disp('---------------------------------------------------------')

plot(aveSNRdB,ave_C_Net);
grid on
xlabel('Average SNR in dB');
ylabel('Average network capacity in bps/Hz');
title('Simultaneous Water-Filling Allocation');
end

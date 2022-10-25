function classpractice5_1(~)
clc
disp('---------------------------------------------------------')
disp('---Class Practice 5.1-Dynamic Frequency Allocation-------')
disp('-----------By Mingjun Ying at August 15th, 2021-----------')
disp('---------------------------------------------------------')
disp('(0)--SWF');
disp('(1)--tx-ITL with a fixed S');
disp('(2)--Self-optimizing tx-ITL');
disp('(3)--FLG');
disp('(4)--IFR1 M-cell');
disp('(5)--FFR M-cell');
disp('---------------------------------------------------------')

while 1
    
    mOPTION=input('Choose 0, 1, 2, 3, 4 or 5:');
    if mOPTION==0 || mOPTION==1 || mOPTION==2 || mOPTION==3|| mOPTION==4 || mOPTION==5
        break;
    end
end

disp('---------------------------------------------------------')
OPTIONS(1)=mOPTION;
if mOPTION==1 || mOPTION==2
    S=input('What is the transmit interference temperature limit?');
    
    OPTIONS(2)=S;
    if mOPTION==2
        beta=input('What is the value of beta?');
        OPTIONS(3)=beta;
    end
else
    OPTIONS=0;
end

B=input('Number of cells or BSs:');
Um=input('The average number of users per cell:');
Nf=input('Number of frequency channels:');
Nsim=input('Number of random simulations:');

aveSNRdB=input('Average SNR per user in dB:');
aveSNR=10.^(aveSNRdB/10);
P=1;
sigma=P./sqrt(aveSNR);
fprintf('\n');
for m=1:length(aveSNRdB)
    %Nsim random simulations for average capacity
    for n=1:Nsim
        %for each random simulation%%
        %Generate the number of users in each cell
        for b=1:B
            U(b)=poissrnd(Um);
        end
        %U
        
        %generate the channels
        for b_=1:B
            for b=1:B
                for u=1:U(b)
                    H(b_,b,u,1:Nf)=(randn(1,Nf)+1i*randn(1,Nf))/sqrt(2);
                end
            end
        end
        
        %Power allocation according to the methods
        popt=sWF(H,sigma(m),P,Nf,B,U,OPTIONS);
        
        %calculate the capacity
        for b=1:B
            for u=1:U(b)
                %calculate the capacity of user u in cell b for all the frequencies
                C_users(b,u)=0;
                %calculate the inerference of user u in cell b
                for f=1:Nf
                    I(f)=0;
                    
                    for b_=1:B
                        for u_=1:U(b_)
                            if ~(b_==b&&u_==u)
                                I(f)=I(f)+popt(b_,u_,f)*abs(H(b_,b,u,f))^2;
                                %introduce rho matrix rho(b_,b)
                            end
                        end
                    end
                    C_user(b,u)=C_user(b,u)+log2(1+popt(b,u,f)*abs(H(b,b,u,f))^2/(sigma(m)^2+I(f)));
                %introduce rho matrix rho(b_,b)
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
        C_Net(m,n)=sum(C_cell);

        if mod(n,10)==0
            fprintf('%d simulations completed\n',n);
        end
    end

%The average network capacity
ave_C_Net(m)=mean(C_Net(m,:));
fprintf('\n');
disp('---------------------------------------------------------')
fprintf('For SNR = %d dB, the average network capacity is %g\n',aveSNRdB(m),ave_C_Net(m));
disp('---------------------------------------------------------')
end

plot

end


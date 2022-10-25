function draft(~)
%Assume a 7-cell network
%approximate rho matrix
clear
clc


disp('----------------------------------------------------------------------------')
disp('------------------------This is Class Practice 3.1.1------------------------')
disp('---------Capacity Simulations for Frequency Reuse algorithms----------------')
disp('----------------------By Mingjun Ying at July 31th, 2021--------------------')
disp('(0) - IFR')
disp('(1) - FFR')
disp('(2) - SWF')
disp('(3) - txITL')
disp('-----------------------------------------------------------------------------')
fprintf('\n')

which_method=input('Choose method 0,1,2, or 3:');
fprintf('\n')
switch which_method
    case 0 %IFR
        reuse_factor=input('Please input the reuse factor N: ');
        Nc=20;
        snr_dB=10;
        Number_realizations=1000;
        
        snr=10^(snr_dB/10);
        P=1;
        sigma=sqrt(P/snr);%snr=P/sigma^2;
        fprintf('\n')
        r=0.5;
        if reuse_factor==1 %IFR1
            disp('----------The Capacity Simulations of IFR1----------');
            for c=1:7
                f(c,1:Nc)=1:Nc;
            end
            rho=[1  1  1  1  1  1  1;...
                 1  1  1  r  r  r  1;...
                 1  1  1  1  r  r  r;...
                 1  r  1  1  1  r  r;...
                 1  r  r  1  1  1  r;...
                 1  r  r  r  1  1  1;...
                 1  1  r  r  r  1  1];
            
        elseif reuse_factor==3 % IFR3
            disp('----------The Capacity Simulations of IFR3----------');
            Nc1=round(Nc/reuse_factor);
            Nc2=Nc1;
            Nc3=Nc-Nc1-Nc2;
            f(1,1:Nc1)=1:Nc1;
            f(2,1:Nc2)=Nc1+1:Nc1+Nc2;
            f(3,1:Nc3)=Nc1+Nc2+1:Nc;
            f(4,:)=f(2,:);
            f(5,:)=f(3,:);
            f(6,:)=f(2,:);
            f(7,:)=f(3,:);
            rho=[1  0  0  0  0  0  0;...
                 0  1  0  r  0  r  0;...
                 0  0  1  0  r  0  r;...
                 0  r  0  1  0  r  0;...
                 0  0  r  0  1  0  r;...
                 0  r  0  r  0  1  0;...
                 0  0  r  0  r  0  1];
        end
        for Um=2:2:30
            for n=1:Number_realizations
                % Setting the number of active users for all the cell
                for c=1:7
                    % the number of user in each cell
                    U(c)=poissrnd(Um);
                    Nchannel(c)=length(find(f(c,:)>0));
                    if U(c)>Nchannel(c)
                    end
                end

                for c=1:7
                    for c_=1:7
                        for u=1:min(U(c_),Nchannel(c_))
                            h(c,c_,u)=(randn+1i*randn)/sqrt(2);%from cell c to user u of cell c_
                        end
                    end
                end
                
                %Computing the capacity for each user
                capacity=zeros(7,min(U(c),Nchannel(c)));
                for c=1:7
                    for u=1:min(U(c),Nchannel(c))
                        I(c,u)=0;
                        % Interference calculation
                        for c_=1:7
                            %only consider those cell that share the same frequencies
                            if  c~=c_ && min(U(c_), Nchannel(c_))>=u
                                I(c,u)=I(c,u)+rho(c_,c)*P*abs(h(c_,c,u))^2;
                            end
                            
                        end
                        sinr(c,u)=rho(c,c)*P*abs(h(c,c,u))^2/(I(c,u)+sigma^2);
                        capacity(c,u)=log2(1+sinr(c,u));

                    end
                    cap_cell(c)=sum(capacity(c,:));
                end
                network_cap_total(n)=sum(cap_cell);

            end%end the bumber of realizations
            average_network_cap(Um)=mean(network_cap_total);
            %         fprintf('\n')
            switch reuse_factor
            case 1
                fprintf('Average Network Capacity for 19-cell IFR1 is %g, when average number of user is %d\n',average_network_cap(Um),Um);
            case 3
                fprintf('Average Network Capacity for 19-cell IFR3 is %g, when average number of user is %d\n',average_network_cap(Um),Um);
            end
        end
        Um=2:2:30;
        switch reuse_factor
            case 1
                plot(Um,average_network_cap(Um), 'r^-','linewidth',1.2);
                hold on
            case 3
                plot(Um,average_network_cap(Um), 'bs--','linewidth',1.2);
                
        end
                
        legend('IFR1','IFR3');
        xlabel('Average Number of Users in Each Cell');
        ylabel('Average Network Capacity');
        title('The Network Capacity given approximate \rho matrix');
        
        
end
end

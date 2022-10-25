function classpractice3_1_3(~)
%Consider a 19-cell network
%With accurate rho matrix based on distance
clear
clc


disp('----------------------------------------------------------------------------')
disp('-------------------------This is Class Practice 3.1.3-----------------------')
disp('---------Capacity Simulations for Frequency Reuse algorithms----------------')
disp('----------------------By Mingjun Ying at August 1st, 2021-------------------')
disp('(0) - IFR')
disp('(1) - FFR')
disp('(2) - SWF')
disp('(3) - txITL')
disp('----------------------------------------------------------------------------')
fprintf('\n')

which_method=input('Choose method 0,1,2, or 3:');
fprintf('\n')
switch which_method
    case 0 %IFR
        reuse_factor=input('Frequency reuse factor (1 or 3):');
        Nc=input('Number of frequency channels:');
        snr_dB=input('SNR in dB:');
        Um=input('Average number of users in each cell:');
        Number_realizations=input('Number of realizations:');
        
        snr=10.^(snr_dB./10);
        P=1;% define the transmit power as 1
        sigma=sqrt(P/snr);%snr=P/sigma^2;
        fprintf('\n')
        
        t=0.9000;%rho is based on the distance
        e=0.5774*0.9;
        r=0.5000*0.9;
        a=0.3780*0.9;
        b=0.3333*0.9;
        g=0.2887*0.9;
        i=0.2774*0.9;
        j=0.2500*0.9;
        
        if reuse_factor==1 %IFR1
            disp('----------The Capacity Simulations of IFR1----------');
            for c=1:19
                f(c,1:Nc)=1:Nc;
            end
            
            %1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19
            rho=[1  t  t  t  t  t  t  e  r  e  r  e  r  e  r  e  r  e  r;...%1
                t  1  t  e  r  e  t  t  t  t  e  r  a  a  b  a  a  r  e;...%2
                t  t  1  t  e  r  e  r  e  t  t  t  e  r  a  a  b  a  a;...%3
                t  e  t  1  t  e  r  a  a  r  e  t  t  t  e  r  a  a  b;...%4
                t  r  e  t  1  t  e  a  b  a  a  r  e  t  t  t  e  r  a;...%5
                t  e  r  e  t  1  t  r  a  a  b  a  a  r  e  t  t  t  e;...%6
                t  t  e  r  e  t  1  t  e  r  a  a  b  a  a  r  e  t  t;...%7
                e  t  r  a  a  r  t  1  t  e  a  b  i  g  i  b  a  e  t;...%8
                r  t  e  a  b  a  e  t  1  t  r  a  g  i  j  i  g  a  r;...%9
                e  t  t  r  a  a  r  e  t  1  t  e  a  b  i  g  i  b  a;...%10
                r  e  t  e  a  b  a  a  r  t  1  t  r  a  g  i  j  i  g;...%11
                e  r  t  t  r  a  a  b  a  e  t  1  t  e  a  b  i  g  i;...%12
                r  a  e  t  e  a  b  i  g  a  r  t  1  t  r  a  g  i  j;...%13
                e  a  r  t  t  r  a  g  i  b  a  e  t  1  t  e  a  b  i;...%14
                r  b  a  e  t  e  a  i  j  i  g  a  r  t  1  t  r  a  g;...%15
                e  a  a  r  t  t  r  b  i  g  i  b  a  e  t  1  t  e  a;...%16
                r  a  b  a  e  t  e  a  g  i  j  i  g  a  r  t  1  t  r;...%17
                e  r  a  a  r  t  t  e  a  b  i  g  i  b  a  e  t  1  t;...%18
                r  e  a  b  a  e  t  t  r  a  g  i  j  i  g  a  t  t  1];%19
            
        elseif reuse_factor==3 % IFR3
            disp('----------The Capacity Simulations of IFR3----------');
            Nc1=round(Nc/reuse_factor);
            Nc2=Nc1;
            Nc3=Nc-Nc1-Nc2;
            
            %----------red----------
            f(1,1:max(Nc1,Nc3))=1:max(Nc1,Nc3);
            f(8,:) =f(1,:);
            f(10,:)=f(1,:);
            f(12,:)=f(1,:);
            f(14,:)=f(1,:);
            f(16,:)=f(1,:);
            f(18,:)=f(1,:);
            %----------blue---------
            f(2,1:Nc2)=max(Nc1,Nc3)+1:max(Nc1,Nc3)+Nc2;
            f(4,:) =f(2,:);
            f(6,:) =f(2,:);
            f(11,:)=f(2,:);
            f(15,:)=f(2,:);
            f(19,:)=f(2,:);
            %---------yellow--------
            f(3,1:min(Nc1,Nc3))=max(Nc1,Nc3)+Nc2+1:Nc;
            f(5,:) =f(3,:);
            f(7,:) =f(3,:);
            f(9,:) =f(3,:);
            f(13,:)=f(3,:);
            f(17,:)=f(3,:);
            
            %1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19
            rho=[1  0  0  0  0  0  0  e  0  e  0  e  0  e  0  e  0  e  0;...%1
                0  1  0  e  0  e  0  0  0  0  e  0  0  0  b  0  0  0  e;...%2
                0  0  0  0  e  0  e  0  e  0  0  0  e  0  0  0  b  0  0;...%3
                0  e  0  1  0  e  0  0  0  0  e  0  0  0  e  0  0  0  b;...%4
                0  0  0  0  1  0  e  0  b  0  0  0  e  0  0  0  e  0  0;...%5
                0  e  0  e  0  1  0  0  0  0  b  0  0  0  e  0  0  0  e;...%6
                0  0  0  0  e  0  1  0  e  0  0  0  b  0  0  0  e  0  0;...%7
                e  0  0  0  0  0  0  1  0  e  0  b  0  g  0  b  0  e  0;...%8
                0  0  0  0  b  0  e  0  1  0  0  0  g  0  0  0  g  0  0;...%9
                e  0  0  0  0  0  0  e  0  1  0  e  0  b  0  g  0  b  0;...%10
                0  e  0  e  0  b  0  0  0  0  1  0  0  0  g  0  0  0  g;...%11
                e  0  0  0  0  0  0  b  0  e  0  1  0  e  0  b  0  g  0;...%12
                0  0  0  0  e  0  b  0  g  0  0  0  1  0  0  0  g  0  0;...%13
                e  0  0  0  0  0  0  g  0  b  0  e  0  1  0  e  0  b  0;...%14
                0  b  0  e  0  e  0  0  0  0  g  0  0  0  1  0  0  0  g;...%15
                e  0  0  0  0  0  0  b  0  g  0  b  0  e  0  1  0  e  0;...%16
                0  0  0  0  e  0  e  0  g  0  0  0  g  0  0  0  1  0  0;...%17
                e  0  0  0  0  0  0  e  0  b  0  g  0  b  0  e  0  1  0;...%18
                0  e  0  b  0  e  0  0  0  0  g  0  0  0  g  0  0  0  1];  %19
        end
        
        for n=1:Number_realizations
            % Setting the number of active users for all the cells
            %fprintf('\n')
            %disp('--------------------------------------------------------')
            for c=1:19
                % the number of user in each cell
                U(c)=poissrnd(Um);
                Nchannel(c)=length(find(f(c,:)>0));
                if U(c)>Nchannel(c)
                    %fprintf('Cell %d has too many users (%d) but can only serve %d users\n',c,U(c),Nchannel(c));
                end
            end
            %             disp('--------------------------------------------------------')
            %             fprintf('\n')
            
            % Geberate the channels between the BSs abd users
            for c=1:19
                for c_=1:19
                    for u=1:min(U(c_),Nchannel(c_))
                        h(c,c_,u)=(randn+1i*randn)/sqrt(2);%from cell c to user u of cell c_
                    end
                end
            end
            
            %Computing the capacity for each user
            capacity=zeros(20,min(U(c),Nchannel(c)));
            for c=1:19
                for u=1:min(U(c),Nchannel(c))
                    I(c,u)=0;
                    % Interference calculation
                    for c_=1:19
                        %only consider those cell that share the same frequencies
                        if  c~=c_ && min(U(c_), Nchannel(c_))>=u
                            I(c,u)=I(c,u)+rho(c_,c)*P*abs(h(c_,c,u))^2;
                        end
                        
                    end
                    sinr(c,u)=P*abs(h(c,c,u))^2/(I(c,u)+sigma^2);
                    capacity(c,u)=log2(1+sinr(c,u));
                    %fprintf('(Cell,User) = (%d,%d)  capacity = %g\n',c,u,capacity(c,u))
                end
                cap_cell(c)=sum(capacity(c,:));
            end
            network_cap(n)=sum(cap_cell);
            %fprintf('\n')
            %fprintf('Network Capacity = %g\n',network_cap)
            if mod(n,1000)==0
              fprintf('%d simulations are completed!\n',n);
            end
        end
        average_network_cap=mean(network_cap);
        fprintf('\n')
        switch reuse_factor
            case 1
                fprintf('Average Network Capacity for IFR1 is %g\n',average_network_cap);
            case 3
                fprintf('Average Network Capacity for IFR3 is %g\n',average_network_cap);
        end
    case 1%FFR
    case 2%SWF
end

end


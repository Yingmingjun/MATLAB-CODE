function final_v5_IFRN_FFR(~)

%Assume a 19-cell network
clear
clc


disp('----------------------------------------------------------------------------')
disp('---------------------------This is final project----------------------------')
disp('-----------------------------M-cell IFR-N FFR-------------------------------')
disp('----------------------By Mingjun Ying at August 21th, 2021------------------')
disp('(0) - IFR-N with M-cell')
disp('(1) - FFR')
disp('(2) - SWF')
disp('(3) - txITL')
disp('----------------------------------------------------------------------------')
fprintf('\n')

which_method=input('Choose method 0,1,2, or 3:');
fprintf('\n')
switch which_method
    case 0 %IFR1 or 3 with M-cell network
        M=input('The number of cells: ');
        row=input('Please input the row number of the cluster: ');
        col=input('Please input the column number of the cluster: ');
        reuse_factor=input('Frequency reuse factor 1,3,7,9,...: ');
        Nc=input('Number of frequency channels: ');
        IFR_N=input('The reuse factor: ');
        
        %         snr_dB=input('SNR in dB: ');
        Number_realizations=input('Number of realizations:');
        Um=input('Average number of users in each cell: ');
        
        
        fprintf('\n')
        
        
        fprintf('This is the capacity simulation for a M-cell IFR-%d given different SINR',IFR_N);
        %         for c=1:M
        %             f(c,1:Nc)=1:Nc;
        %         end
        NC(1)=0;
        NC(2)=round(Nc/reuse_factor);
        for n=3:IFR_N-1
            NC(n)=NC(2);
        end
        NC(IFR_N)=Nc-sum(NC);
        for t=1:Nc
            
            f(t,1:NC(t+1))=1+sum(NC(1:t)):sum(NC(1:t+1));
            
            for Row=1:row
                for Col=1:col
                    if Col<=col&&mod(Col-1,reuse_factor)==0
                        if mod(Row,2)==0
                            f((Row-1)*col+Col+1,:)=f(1,:);
                        elseif mod(Row,2)==1
                            f((Row-1)*col+Col,:)=f(1,:);
                        end
                    end
                end
            end
        end
        
        rho=rho_gen_N(M,row,col);
        % Setting the number of active users for all the cells
        fprintf('\n')
        disp('--------------------------------------------------------')
        snr_dB=1:5:100;
        
        for count=1:20
            snr(count)=10^(snr_dB(count)/10);
            P=1;% define the transmit power as 1
            sigma(count)=sqrt(P/snr(count));%snr=P/sigma^2;
            for n=1:Number_realizations
                for c=1:M
                    % the number of user in each cell
                    U(c)=poissrnd(Um);
                    Nchannel(c)=length(find(f(c,:)>0));
                    %                     if U(c)>Nchannel(c)
                    %                         fprintf('Cell %d has too many users (%d) but can only serve %d users\n',c,U(c),Nchannel(c));
                    %                     end
                end
                %                 disp('--------------------------------------------------------')
                %                 fprintf('\n')
                
                % Geberate the channels between the BSs abd users
                for c=1:M
                    for c_=1:M
                        for u=1:min(U(c_),Nchannel(c_))
                            h(c,c_,u)=(randn+1i*randn)/sqrt(2);%from cell c to user u of cell c_
                        end
                    end
                end
                
                %Computing the capacity for each user
                capacity=zeros(M,min(U(c),Nchannel(c)));
                for c=1:M
                    for u=1:min(U(c),Nchannel(c))
                        I(c,u)=0;
                        % Interference calculation
                        for c_=1:M
                            %only consider those cell that share the same frequencies
                            
                            if  c~=c_ && min(U(c_), Nchannel(c_))>=u
                                I(c,u)=I(c,u)+rho(c_,c)*P*abs(h(c_,c,u))^2;
                            end
                            
                        end
                        sinr(c,u)=P*abs(h(c,c,u))^2/(I(c,u)+sigma(count)^2);
                        capacity(c,u)=log2(1+sinr(c,u));
                        %                         fprintf('(Cell,User) = (%d,%d)  capacity = %g\n',c,u,capacity(c,u));
                    end
                    cap_cell(c)=sum(capacity(c,:));
                end
                network_cap(n)=sum(cap_cell);
                %             fprintf('\n')
                %             fprintf('Network Capacity = %g\n',network_cap)
                %                 if mod(n,100)==0
                %                     fprintf('%d simulations are completed!\n',n);
                %                 end
            end
            
            average_network_cap(snr_dB(count))=mean(network_cap);
            %             fprintf('\n')
            
            fprintf('Given SNR = %d (dB), average Network Capacity for a 19-cell IFR-%d is %g\n',snr_dB(count),reuse_factor,average_network_cap(snr_dB(count)));
        end
        switch M
            case 24
                plot(snr_dB,average_network_cap(snr_dB), 'r^-','linewidth',1.2);
                hold on
            case 63
                plot(snr_dB,average_network_cap(snr_dB), 'bs--','linewidth',1.2);
            case 81
                plot(snr_dB,average_network_cap(snr_dB), 'go-','linewidth',1.2);
                
        end
        legend('M=24','M=63','M=81');
        xlabel('The SNR in dB');
        ylabel('Average Network Capacity');
        title('The Network Capacity for M-cell network');
        
        
    case 1%FFR
    case 2%SWF
        
        
end

end


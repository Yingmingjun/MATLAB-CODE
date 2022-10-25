function final_v8_FLG_IFR3(~)
% show

clc
disp('----------------------------------------------------------------------------')
disp('--------------------------This is the Final Project-------------------------')
disp('-------------This code is made for FLG+IFR3 for M-cell network-------------')
disp('--------------------By Mingjun Ying at August 22th, 2021--------------------')
disp('-------------------------------Class ST 3705--------------------------------')
disp('----------------------------------------------------------------------------')


% input
% M=input('What is the number of cells: ');
% row=input('Please input the row number of the cluster: ');
% col=input('Please input the column number of the cluster: ');
% Nsim=input('Number of random simulations: ');
M=24;
row=4;
col=6;
Nsim=10;
% N0=input('Number of frequency channels at the centers: ');
% Nc=input('Number of frequency channels in the center: ');
% Ne=input('Number of frequency channels in the edge: ');
Nc=10;
Ne=6;
% snr_dB=input('The range of average SNR in dB: ');
snr_dB=0:5:20;
snr=10.^(snr_dB/10);

% Um=input('Average number of users per cell: ');
Um=8;% 6  9  12  15

% process
P1=1;%center
P2=0.5;%egde
sigma1=P1./sqrt(snr);
sigma2=P2./sqrt(snr);

% form rho matrix
rho1=rho_gen(M,row,col,1);
rho2=rho_gen(M,row,col,3);
rho1
rho2
% It allow we ignore the path loss exponent for introducing the rho matrix

% Genarate the average capacity%


Ne1=round(Ne/3);
Ne2=Ne1;
Ne3=Ne-Ne1-Ne2;


%----------------------1----------------------
f(1,1:Ne1)=1:Ne1;
for Row=1:row
    for Col=1:col
        if Col<=col&&mod(Row,2)==1&&mod(Col-1,3)==0
            f((Row-1)*col+Col,:)=f(1,:);
        elseif Col<=col&&mod(Row,2)==0&&mod(Col-2,3)==0
            f((Row-1)*col+Col,:)=f(1,:);
        end
    end
end
%----------------------2----------------------
f(2,1:Ne2)=Ne1+1:Ne1+Ne2;
for Row=1:row
    for Col=1:col
        if Col<=col&&mod(Row,2)==1&&mod(Col-2,3)==0
            f((Row-1)*col+Col,:)=f(2,:);
        elseif Col<=col&&mod(Row,2)==0&&mod(Col-3,3)==0
            f((Row-1)*col+Col,:)=f(2,:);
        end
    end
end

%----------------------3----------------------
f(3,1:Ne3)=Ne1+Ne2+1:Ne;
for Row=1:row
    for Col=1:col
        if Col<=col&&mod(Row,2)==1&&mod(Col-3,3)==0
            f((Row-1)*col+Col,:)=f(3,:);
        elseif Col<=col&&mod(Row,2)==0&&mod(Col-4,3)==0
            f((Row-1)*col+Col,:)=f(3,:);
        end
    end
end

f

cap_cell=zeros(1,M);
Nchannel=zeros(1,M);

sinr_edge=zeros(M,Ne);
capacity_edge=zeros(M,Ne);
U=zeros(1,M);
U1=zeros(1,M);
U2=zeros(1,M);
In=zeros(1,Nc);
% user number
for c=1:M
    U(c)=poissrnd(Um);
    U1(c)=round(rand*U(c)); % number of users at cell centers
    U2(c)=U(c)-U1(c);% number of users at cell edges
    Nchannel(c)=length(find(f(c,:)>0));% frequency in a cell edge
end

sinr_center=zeros(M,max(max(U1)),Nc);

capacity_center=zeros(M,max(U1));
for m=1:length(snr_dB)
    for n=1:Nsim%for each sim
        
        % Generate the channel between the BSs and users for cell edge
        for c=1:M
            for c_=1:M
                if U2(c_)>0
                    for u=1:min(Nchannel(c_),U2(c_))
                        h2(c,c_,u)=rho2(c,c_)*(randn+1i*randn)/sqrt(2);
                    end
                end
            end
        end
        
        for b_=1:M
            for b=1:M
                for u=1:U1(b)
                    h1(b_,b,u,1:Nc)=rho1(b,b_)*(randn(1,Nc)+1i*randn(1,Nc))/sqrt(2);
                end
            end
        end
        %         h1=(randn(M,M,max(U1),Nc)+1i*randn(M,M,max(U1),Nc)./sqrt(2));
        p=SWF_cell(h1,sigma1(m),P1,Nc,M,U1,3,rho1);
        
        % Comput the capacity
        for c=1:M
            %for center users
            for u=1:U1(c)
                capacity_center(c,u)=0;
                for f=1:Nc
                    In(f)=0;
                    for c_=1:M
                        
                        for u_=1:U1(c_)
                            if ~(u_~=u&&c~=c_)
                                In(f)=In(f)+rho1(c_,c)*p(c_,u_,f)*abs(h1(c_,c,u,f))^2;
                            end
                        end
                        
                    end
                    %sinr_center(c,u,f)=p(c,u,f)*abs(h1(c,c,u,f))^2/(In(f)+sigma1(m)^2);
                    %Capacity_center(c,u,f)=Capacity_center(c,u,f)+log2(1+sinr_center(c,u,f));
                    capacity_center(c,u)=capacity_center(c,u)+log2(1+p(c,u,f)*abs(h1(c,c,u,f))^2/(In(f)+sigma1(m)^2));
                end
                %capacity_center(c,u)=sum(Capacity_center(c,u,:));
                
            end
            
            % for edge users
            if U2(c)>0
                for u=1:min(Nchannel(c),U2(c))
                    I(c,u)=0;%I define
                    for c_=1:M
                        if rho2(c,c_)~=0 && c~=c_
                            if U1(c_)>=u && Nchannel(c_)>=u
                                I(c,u)=I(c,u)+rho2(c,c_)*P2*abs(h2(c_,c,u))^2;
                            end
                        end
                    end
                    sinr_edge(c,u)=P2*abs(h2(c,c,u))^2/(I(c,u)+sigma2(m)^2);
                    capacity_edge(c,u)=log2(1+sinr_edge(c,u));
                end
            end
            
            if U1(c)>0 && U2(c)>0
                cap_cell(c)=sum(capacity_center(c,1:min(U1(c),Nc)))+sum(capacity_edge(c,1:min(U2(c),Nchannel(c))));
                %cap_cell(c)=sum(capacity_center(c,:))+sum(capacity_edge(c,:));
                
            elseif U1(c)>0 && ~(U2(c)>0)
                cap_cell(c)=sum(capacity_center(c,1:min(U1(c),Nc)));
            elseif ~(U1(c)>0) && U2(c)>0
                cap_cell(c)=sum(capacity_edge(c,1:min(U2(c),Nchannel(c))));
            else
                cap_cell(c)=0;
            end
        end
        cap_net(m,n)=sum(cap_cell);
        %         clear cap_cell
    end
    
    Ave_cap_net(m)=mean(cap_net(m,:));
    
    fprintf('For SNR = %gdB, Average network capacity with FLG(center)+IFR3(edge) is %g\n',snr_dB(m),Ave_cap_net(m));
end


switch M
    case 24
        plot(snr_dB,Ave_cap_net, 'ro-','linewidth',1.2);
        hold on
        grid on
    case 63
        plot(snr_dB,Ave_cap_net, 'bs--','linewidth',1.2);
    case 81
        plot(snr_dB,Ave_cap_net, 'go-','linewidth',1.2);
        
end

% legend('IFR1+IFR3','sWF+IFR3','FLG+IFR3');
% legend('IFR3','IFR1+IFR3','sWF+IFR3','FLG+IFR3','Location','SouthEast');
legend('IFR1','IFR3','IFR1+IFR3','SWF+IFR3','FLG+IFR3','Location','Best');
xlabel('Average SNR in dB');
ylabel('Average Network Capacity (bps/Hz)');
title('Comparison between different methods for a 24-cell network');

% title('A 24-cell network');

end



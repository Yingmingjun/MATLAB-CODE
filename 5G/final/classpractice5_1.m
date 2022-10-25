function classpractice5_1(~)
clc
disp('---------------------------------------------------------------------')
disp('---classpractice 5.1-Dynamic Frequency Allocation (19-cellnetwork)---')
disp('---------------------------------------------------------------------')
disp('(0)- SWF')
disp('(1)- tx-ITL with a fixed S')
disp('(2)- Self-optimizing tx-ITL')
disp('(3)- FLG')
disp('---------------------------------------------------------------------')
% while 1
%     mOPTION=input('Choose 0,1,2 or 3: ');
%     if mOPTION==0||mOPTION==1||mOPTION==2||mOPTION==3
%         break;
%     end
% end
disp('---------------------------------------------------------------------')

mOPTION=0;
while mOPTION<4
            while mOPTION==1||mOPTION==2
                mOPTION=mOPTION+1;
            end
    
    OPTIONS(1)=mOPTION;
    if mOPTION==1||mOPTION==2
        %         S=input('What is the transmit interference temperature limit?');
        S=3;
        OPTIONS(2)=S;
        if mOPTION==2
            %beta=input('What is beta?');
            beta=0.9;
            OPTIONS(3)=beta;
        end
    end
    % B=7;
    B=19; % 19-cell network
    %     Um=input('The average number of users per cell: ');
    %     Nf=input('Number of frequency channels: ');
    %     Nsim=input('Number of random simulations: ');
    %     aveSNRdB=input('The range of average SNR per user in dB: ');
    Um=10;
    Nf=18;
    Nsim=20;
    aveSNRdB=0:30;
    aveSNR=10.^(aveSNRdB/10);
    P=1;
    sigma=P./sqrt(aveSNR);
    
    %     t=0.9000;%rho is based on the distance
    %     e=0.5774*0.9;
    %     r=0.5000*0.9;
    %     a=0.3780*0.9;
    %     b=0.3333*0.9;
    %     g=0.2887*0.9;
    %     i=0.2774*0.9;
    %     j=0.2500*0.9;
    %     %1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19
    %     rho=[1  t  t  t  t  t  t  e  r  e  r  e  r  e  r  e  r  e  r;...%1
    %         t  1  t  e  r  e  t  t  t  t  e  r  a  a  b  a  a  r  e;...%2
    %         t  t  1  t  e  r  e  r  e  t  t  t  e  r  a  a  b  a  a;...%3
    %         t  e  t  1  t  e  r  a  a  r  e  t  t  t  e  r  a  a  b;...%4
    %         t  r  e  t  1  t  e  a  b  a  a  r  e  t  t  t  e  r  a;...%5
    %         t  e  r  e  t  1  t  r  a  a  b  a  a  r  e  t  t  t  e;...%6
    %         t  t  e  r  e  t  1  t  e  r  a  a  b  a  a  r  e  t  t;...%7
    %         e  t  r  a  a  r  t  1  t  e  a  b  i  g  i  b  a  e  t;...%8
    %         r  t  e  a  b  a  e  t  1  t  r  a  g  i  j  i  g  a  r;...%9
    %         e  t  t  r  a  a  r  e  t  1  t  e  a  b  i  g  i  b  a;...%10
    %         r  e  t  e  a  b  a  a  r  t  1  t  r  a  g  i  j  i  g;...%11
    %         e  r  t  t  r  a  a  b  a  e  t  1  t  e  a  b  i  g  i;...%12
    %         r  a  e  t  e  a  b  i  g  a  r  t  1  t  r  a  g  i  j;...%13
    %         e  a  r  t  t  r  a  g  i  b  a  e  t  1  t  e  a  b  i;...%14
    %         r  b  a  e  t  e  a  i  j  i  g  a  r  t  1  t  r  a  g;...%15
    %         e  a  a  r  t  t  r  b  i  g  i  b  a  e  t  1  t  e  a;...%16
    %         r  a  b  a  e  t  e  a  g  i  j  i  g  a  r  t  1  t  r;...%17
    %         e  r  a  a  r  t  t  e  a  b  i  g  i  b  a  e  t  1  t;...%18
    %         r  e  a  b  a  e  t  t  r  a  g  i  j  i  g  a  t  t  1];%19
    t=0.8;% 1-layer: 0.8
    r=0.5;% 2-layer: 0.5
    z=0.3;% 3-layer: 0.3
    q=0.1;% 4-laryer:0.1
    rho=[1 t t t t t t r r r r r r r r r r r r;...
        t 1 t r r r t t t r r z z z z z r r t;...
        t t 1 t r r r r t t t r r z z z z z r;...
        t r t 1 t r r z r r t t t r r z z z z;...
        t r r t 1 t r z z z r r t t t r r z z;...
        t r r r t 1 t z z z z z r r t t t r r;...
        t t r r r t 1 r r z z z z z r r t t t;...
        r t r z z z r 1 t r z q q q q q z r t;...
        r t t r z z r t 1 t r z z q q q z z r;...
        r r t r z z z r t 1 t r z q q q q q z;...
        r r t t r z z z r t 1 t r z z q q q z;...
        r z r t r z z q z r t 1 t r z q q q q;...
        r z r t t r z q z z r t 1 t r z z q q;...
        r z z r t r z q q q z r t 1 t r z q q;...
        r z z r t t r q q q z z r t 1 t r z z;...
        r z z z r t r q q q q q z r t 1 t r z;...
        r r z z r t t z z q q q z z r t 1 t r;...
        r r z z z r t r z q q q q q z r t 1 t;...
        r t r z z r t t r z z q q q z z r t 1];
    
    % rho=rho_gen(19,3,7);
    for m=1:length(aveSNRdB)
        for n=1:Nsim
            for b=1:B
                U(b)=poissrnd(Um);
            end
            for b_=1:B
                for b=1:B
                    for u=1:U(b)
                        H(b_,b,u,1:Nf)=(randn(1,Nf)+1i*randn(1,Nf))/sqrt(2);
                    end
                end
            end
            popt=SWF_cell(H,sigma(m),P,Nf,B,U,OPTIONS,rho);%?
            for b=1:B
                for u=1:U(b)
                    C_user(b,u)=0;
                    for f=1:Nf
                        I(f)=0;
                        for b_=1:B
                            for u_=1:U(b_)
                                if ~(b_==b&&u_==u)
                                    I(f)=I(f)+rho(b_,b)*popt(b_,u_,f)*abs(H(b_,b,u,f))^2;
                                end
                            end
                        end
                        C_user(b,u)=C_user(b,u)+log2(1+rho(b,b)*popt(b,u,f)*abs(H(b,b,u,f))^2/(sigma(m)^2+I(f)));
                    end
                end
                if U(b)>=1
                    C_cell(b)=sum(C_user(b,1:U(b)));
                else
                    C_cell(b)=0;
                end
            end
            C_Net(m,n)=sum(C_cell);
            % display running process
            if mod(n,10)==0
                fprintf('\n');
                fprintf('%d simulations completed\n',n);
            end
        end
        ave_C_Net(m)=mean(C_Net(m,:));
        fprintf('\n');
        disp('---------------------------------------------------------------------')
        fprintf('For SNR = % dB, the average network capacity is %g\n',aveSNRdB(m),ave_C_Net(m));
        disp('---------------------------------------------------------------------')
    end
    switch mOPTION
        case 0
            plot(aveSNRdB,ave_C_Net,'ro-','linewidth',1.2);
            hold on
            grid on
        case 1
            plot(aveSNRdB,ave_C_Net,'bx-','linewidth',1.2);
        case 2
            plot(aveSNRdB,ave_C_Net,'g^-','linewidth',1.2);
        case 3
            plot(aveSNRdB,ave_C_Net,'bx-','linewidth',1.2);
    end
    mOPTION=mOPTION+1;
    
    
    
    xlabel('Average SNR in dB');
    ylabel('Average capacity(bps/Hz)');
    title('Dynamic Frequency Allocation for a 19-cell Network');
    legend('SWF','FLG');
    %     legend('SWF','tx-ITL with fixed S','Self-optimizing tx-ITL','FLG');
end
end

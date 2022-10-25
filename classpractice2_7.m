function BER=classpractice2_7(~)
clear
clc

%Conduct the BER simulations for QPSK/64-QAM in flat fading
disp('-----------------------------------------------------------------------------')
disp('-------------------------This is Class Practice 2.6--------------------------')
disp('BER simulations of QPSK&64-QAM for different SNR(With Flat Fading)')
disp('--------------------By Mingjun Ying at July 26th, 2021--------------------')
disp('(0) - BPSK')
disp('(1) - QPSK')
disp('(2) - 16-QAM')
disp('(3) - 64-QAM')
disp('-----------------------------------------------------------------------------')
fprintf('\n')

% mtype=input('Choose a modulation 0, 1, 2 or 3?');
mtype=0;
% snr_dB_perbit=input('The range of SNR(dB) per bit for simulations:');
snr_dB_perbit=1:10;
% Nsim=input('The number of random simulations:');
% Nch=input('The number of random channels:');
Nsim=100;
Nch=10000;

fprintf('\n')

tic

snr_b=10.^(snr_dB_perbit/10);
%Nofp represents the number of constellation points
switch mtype
    case 0
        Nofp=2;
    case 1
        Nofp=4;
    case 2
        Nofp=16;
    case 3
        Nofp=64;
end
snr=snr_b.*log2(Nofp);
%snr is the SNR per symbol and log2(Nofp) is
%the bumber of bits per symbol/point
L=length(snr_b);

for P=1:3
    
    sigma=sqrt(P./snr);
    
    for m=1:L
        %for each SNR
        Nerror(m)=0;
        for k=1:Nch
            h(k)=(randn+1i*randn)/sqrt(2);
            [s,c]=mod_symbols(Nsim,mtype);
            noise=(randn(1,Nsim)+1i*randn(1,Nsim))/sqrt(2)*sigma(m);
            y=h(k)*s+noise;
            y=y/h(k);%if Re(y(k)/h(k))>0 detect s=+1 in BPSK
            
            if mtype==0% In BPSK, only need to consider the real part
                y=real(y);
            end
            %estimate the BER at the specific SNR
            for n=1:Nsim
                [unused,ind]=min(abs(y(n)-c).^2);
                s_detect(n)=c(ind);
                if s(n)~=s_detect(n)
                    Nerror(m)=Nerror(m)+1;
                end
            end
        end
        ser(m)=Nerror(m)/Nsim/Nch;
        % ser= 1-(1-ber)^M --> ber= 1-(1-ser)^(1/M)
        % if ber is a small number, then (1-ber)^M=1-M*ber
        % therefore ser=1-(1-M*ber)
        % therefore ser= M*ber
        % therefore ber= ser/M
        
        
        ber_app(m)=ser(m)/log2(Nofp);
        
        fprintf('SNR = %gdB, approximate_BER = %g \n'...
            ,snr_dB_perbit(m), ber_app(m));
    end
    switch P
        case 1
    semilogy(snr_dB_perbit,ber_app,'b^-','linewidth',1.2,'markersize',8)
    grid on
    hold on
        case 2
             semilogy(snr_dB_perbit,ber_app,'rs-','linewidth',1.2,'markersize',8)
        case 3
             semilogy(snr_dB_perbit,ber_app,'go-','linewidth',1.2,'markersize',8)
end

BER=ber_app;
%Plot the results



xlabel('SNR per bit in dB')
ylabel('Approximate BER')

string={'BPSK (with flat fading)','QPSK (with flat fading)','16-QAM (with flat fading)'...
    ,'64-QAM (with flat fading)'};
title(string(mtype+1));

%  legend('P_{channel} = 1','P_{channel} = 2','P_{channel} = 3')
legend('P_{noise} = 1','P_{noise} = 2','P_{noise} = 3')

toc
end



function BER=classpractice2_4(~)
clear
clc

%BER simulations of BPSK for different SNR
%plot both the simulation results and the theoretical results
disp('-----------------------------------------------------------------------------')
disp('-------------------------This is Class Practice 2.4--------------------------')
disp('BER simulations of QPSK & 64-QAM for different SNR(No Fading)')
disp('--------------------By Mingjun Ying at July 26th, 2021--------------------')
disp('(0) - BPSK')
disp('(1) - QPSK')
disp('(2) - 16-QAM')
disp('(3) - 64-QAM')
disp('-----------------------------------------------------------------------------')
fprintf('\n')

mtype=input('Choose a modulation 0, 1, 2 or 3?');
snr_dB_perbit=input('The range of SNR(dB) per bit for simulations:');
Nsim=input('The number of random simulations:');
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

P=1;%Normalized the power as 1
sigma=sqrt(P./snr);

for m=1:L
    %for each SNR
    [s,c]=mod_symbols(Nsim,mtype);
    noise=(randn(1,Nsim)+1i*randn(1,Nsim))/sqrt(2)*sigma(m);
    y=s+noise;
    if mtype==0% In BPSK, only need to consider the real part
        y=real(y);
    end
    
    Nerror(m)=0;
    for n=1:Nsim
        [unused,ind]=min(abs(y(n)-c).^2);
        s_detect(n)=c(ind);
        if s(n)~=s_detect(n)
            Nerror(m)=Nerror(m)+1;
        end
    end
    ser(m)=Nerror(m)/Nsim;
    % ser= 1-(1-ber)^M --> ber= 1-(1-ser)^(1/M)
    % if ber is a small number, then (1-ber)^M=1-M*ber
    % therefore ser=1-(1-M*ber)
    % therefore ser= M*ber
    % therefore ber= ser/M
    
    ber_acc(m)=1-(1-ser(m))^(1/log2(Nofp));
    ber_app(m)=ser(m)/log2(Nofp);
    
    fprintf('SNR = %gdB, accurate_BER = %g, approximate_BER = %g \n'...
        ,snr_dB_perbit(m), ber_acc(m), ber_app(m));
end
BER=ber_acc;
semilogy(snr_dB_perbit,ber_acc,'rs-','linewidth',1.2,'markersize',10)
grid on
hold on
semilogy(snr_dB_perbit,ber_app,'b^--','linewidth',1.2,'markersize',8)
xlabel('SNR per bit in dB')
ylabel('BER')

string={'BPSK (without fading)','QPSK (without fading)','16-QAM (without fading)'...
    ,'64-QAM (without fading)'};
title(string(mtype+1));

legend('Accurate BER','Approximate BER');
toc
end



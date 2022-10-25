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
count=0;
for mtype=1:4
    mtype=mtype-1;
    count=count+1;
    snr_dB_perbit=1:10;
    Nsim=10000000;
    fprintf('\n')
    
    
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
    L=length(snr_b);
    P=1;
    sigma=sqrt(P./snr);
    
    for m=1:L
        [s,c]=mod_symbols(Nsim,mtype);
        noise=(randn(1,Nsim)+1i*randn(1,Nsim))/sqrt(2)*sigma(m);
        y=s+noise;
        if mtype==0
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
        ber_acc(m)=1-(1-ser(m))^(1/log2(Nofp));
        fprintf('SNR = %gdB, accurate_BER = %g\n', snr_dB_perbit(m), ber_acc(m));
        
    end
    switch count
        case 1
            semilogy(snr_dB_perbit,ber_acc,'go-','linewidth',1.2,'markersize',10)
            hold on
        case 2
            semilogy(snr_dB_perbit,ber_acc,'rs-','linewidth',1.2,'markersize',10)
        case 3
            semilogy(snr_dB_perbit,ber_acc,'b^-','linewidth',1.2,'markersize',10)
        case 4
            semilogy(snr_dB_perbit,ber_acc,'mx-','linewidth',1.2,'markersize',10)
            legend('BPSK','QPSK','16-QAM','64-QAM')
            xlabel('SNR per bit in dB')
            ylabel('BER')
    end
end


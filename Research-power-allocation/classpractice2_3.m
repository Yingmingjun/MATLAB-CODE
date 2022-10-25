function classpractice2_3(~)
clear
clc
%BER simulations of BPSK for different SNR
%plot both the simulation results and the theoretical results
disp('-----------------------------------------------------------------------------')
disp('-------------------------This is Class Practice 2.3--------------------------')
disp('---------------BER simulations of BPSK for different SNR----------------')
disp('--------------------By Mingjun Ying at July 25th 2021--------------------')
disp('-----------------------------------------------------------------------------')
fprintf("\n")

snr_dB=input('The range of SNR in dB for simulations: ');%0:1:10
snr=10.^(snr_dB/10);%snr_dB=10*log10(snr)
A=1;
sigma=sqrt(A^2/2./snr);
%snr=A^2/(2* sigma^2)
%snr=P/sigma^2 --> sigma= sqrt(P./ snr);
%sigma=sqrt(P./snr) ( P=1)

Nsim=input('The number of random samples/transmissions:');
c=[-1 1];
fprintf('\n')
Nerror=zeros(1,length(snr));
s=zeros(1,Nsim);
noise=zeros(1,Nsim);
y=zeros(1,Nsim);
s_det=zeros(1,Nsim);
BER=zeros(1,length(snr));

tic
for m=1:length(snr)%First loop for each SNR
    Nerror(m)=0;%Set the initial error number as 0
    for n=1:Nsim%for each transmission
        s(n)=c(randi(2));
        noise(n)=randn*sigma(m);
        y(n)=s(n)+noise(n);
        
        s_det(n)=(y(n)>0)*1+(y(n)<=0)*(-1);%detection 
        
        if s(n)~=s_det(n)%calculate the BER or SER, in BPSK BER=SER
            Nerror(m)=Nerror(m)+1;
        end
    end
    
    BER(m)=Nerror(m)/Nsim;
    fprintf('SNR=%g BER=%g done\n',snr_dB(m),BER(m))
end
toc

figure(1)
semilogy(snr_dB,BER,'linewidth',1);
xlabel('SNR in dB');
ylabel('Simulated BER');
title('BPSK BER Simulation');
grid on;

%Calculate the theoretical BER of BPSK
for k=1:length(snr)
BER(m)=erfc(sqrt(snr(m)))/2;
end
BER_anal=BER;

figure(2)
% plot(snr_dB,BER,'-or')
% hold on
% plot(snr_dB,BER_anal,'-bs')
semilogy(snr_dB,BER,'-or','linewidth',1)
hold on
semilogy(snr_dB,BER_anal,'-bs','linewidth',1)
xlabel('SNR in dB');
ylabel('BER');
legend('Simulated BER','Theoretical BER');
title('BPSK BER');
grid on;
end
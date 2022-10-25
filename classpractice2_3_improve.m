function classpractice2_3_improve(~)
clear
clc
%BER simulations of BPSK for different SNR
%plot both the simulation results and the theoretical results
disp('-----------------------------------------------------------------------------')
disp('-------------------------This is Class Practice 2.3(Optimized)--------------------------')
disp('---------------BER simulations of BPSK for different SNR----------------')
disp('--------------------By Mingjun Ying at July 25th 2021--------------------')
disp('-----------------------------------------------------------------------------')
fprintf("\n")

snr_dB=input('The range of SNR in dB for simulations: ');%0:1:10
snr=10.^(snr_dB/10);%snr_dB=10*log10(snr)
A=1;
sigma=sqrt(A^2/2./snr);

total_bits=input('The number of all the random bits:');

fprintf('\n')


s_det=zeros(total_bits,1);
tic
for m=1:length(snr)%First loop for each SNR
    u=rand(total_bits,1);
    s(1:total_bits,1)=1;
    s(find(u<0.5))=-1;
    n=randn(total_bits,1).*sigma(m);
    s_est=A.*s+n;
    s_det(find(s_est>0))=1;
    s_det(find(s_est<=0))=-1;
    BER(m)=length(find(s_det~=s))/total_bits;
    fprintf('Given SNR=%g, BER=%g\n',snr_dB(m),BER(m))
end
toc

figure(1)
semilogy(snr_dB,BER,'linewidth',1);
xlabel('SNR in dB');
ylabel('Simulated BER');
title('BPSK BER Simulation(with optimized method)');
grid on;

% Calculate the theoretical BER of BPSK
for k=1:length(snr)
    BER(m)=erfc(sqrt(snr(m)))/2;
end
BER_anal=BER;

figure(2)
semilogy(snr_dB,BER,'-or','linewidth',1)
hold on
semilogy(snr_dB,BER_anal,'-bs','linewidth',1)
xlabel('SNR in dB');
ylabel('BER');
legend('Simulated BER','Theoretical BER');
title('BPSK BER(with optimized method)');
grid on;

end
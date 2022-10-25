function classpractice4_1(~)
%Consider a 19-cell network
%With accurate rho matrix based on distance
clear
clc


disp('----------------------------------------------------------------------------')
disp('-------------------------This is Class Practice 4.1-------------------------')
disp('---------------Water-Filling Algorithms for Power Allocation----------------')
disp('----------------------By Mingjun Ying at August 8th, 2021-------------------')
disp('----------------------------------------------------------------------------')


Nf=input('Number of frequency channels(>=3): ');
Nsim=input('Number of random simulations: ');

aveSNRdB=input('The range of the average SNR in dB:');
aveSNR=10.^(aveSNRdB/10);
P=1;
sigma=sqrt(P./aveSNR);
Cr=zeros(length(aveSNRdB),Nsim);
Cr_equal=zeros(length(aveSNRdB),Nsim);
Cr_top3=zeros(length(aveSNRdB),Nsim);
Cr_top1=zeros(length(aveSNRdB),Nsim);
disp('----------------------------------------------------------------------------')
disp('----------------------------------------------------------------------------')


tic
for m=1:length(aveSNRdB)
    % for each SNR value
    
    for n=1:Nsim
        % for each random simulation
        
        H=(randn(1,Nf)+1i*randn(1,Nf))/sqrt(2);
        water_level=fzero(@(w) fun_waterlevel(w,sigma(m),H,P), P/5);
        
        for f=1:Nf
            p(f)=max(0, water_level-sigma(m)^2/(abs(H(f))^2));
            %Only one user have no interference
            Cr(m,n)=Cr(m,n)+log2(1+p(f)*abs(H(f))^2/(sigma(m)^2));
            Cr_equal(m,n)=Cr_equal(m,n)+log2(1+(P/Nf)*abs(H(f))^2/(sigma(m)^2));
        end
        %Distributing the power to 1 or 3 channels in average
        Temp=sort(H);
        index_max=length(H);
        Cr_top1(m,n)=Cr_top1(m,n)+log2(1+P*abs(Temp(index_max))^2/(sigma(m)^2));
        for count=1:3
            Cr_top3(m,n)=Cr_top3(m,n)+log2(1+(P/3)*abs(Temp(index_max))^2/(sigma(m)^2));
            index_max=index_max-1;
        end
    end
    
    Cap(m)=mean(Cr(m,:));
    Cap_equal(m)=mean( Cr_equal(m,:));
    Cap_top1(m)=mean( Cr_top1(m,:));
    Cap_top3(m)=mean( Cr_top3(m,:));
    fprintf('The results when SNR equals %g dB are completed\n', aveSNRdB(m));

    
    
end
disp('----------------------------------------------------------------------------')
toc

plot(aveSNRdB,Cap,'b*-','linewidth',1.2,'markersize',8);
hold on;
grid on;
plot(aveSNRdB,Cap_equal,'ro-','linewidth',1.2,'markersize',8);
plot(aveSNRdB,Cap_top1,'g^-','linewidth',1.2,'markersize',8);
plot(aveSNRdB,Cap_top3,'cs-','linewidth',1.2,'markersize',8);
xlabel('$$Average SNR=\mathrm{E}\left[|H[f]|^{2}\right] \frac{P}{\sigma^{2}}(dB)$$'...
    ,'Interpreter','latex');
ylabel('Average capacity (bps/Hz)');
% legend('Water-Filling','Equal Allocation');
legend('Water-Filling','Equal Allocation','Top1 Allocation','Top3 Allocation');


end


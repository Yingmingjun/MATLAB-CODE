function draft4_1(~)
%Consider a 19-cell network
%With accurate rho matrix based on distance
clear
clc


disp('----------------------------------------------------------------------------')
disp('-------------------------This is Class Practice 4.1-------------------------')
disp('---------------Water-Filling Algorithms for Power Allocation----------------')
disp('----------------------By Mingjun Ying at August 8th, 2021-------------------')
disp('----------------------------------------------------------------------------')



Nsim=input('Number of random simulations: ');

aveSNRdB=input('The range of the average SNR in dB:');
aveSNR=10.^(aveSNRdB/10);
P=1;
sigma=sqrt(P./aveSNR);
Cr=zeros(length(aveSNRdB),Nsim);

disp('----------------------------------------------------------------------------')
disp('----------------------------------------------------------------------------')
Nf=10:10:40;

tic
for c=1:4
    for m=1:length(aveSNRdB)
        % for each SNR value
        
        for n=1:Nsim
            % for each random simulation
            
            H=(randn(1,Nf(c))+1i*randn(1,Nf(c)))/sqrt(2);
            water_level=fzero(@(w) fun_waterlevel(w,sigma(m),H,P), P/5);
            
            for f=1:Nf(c)
                p(f)=max(0, water_level-sigma(m)^2/(abs(H(f))^2));
                %Only one user have no interference
                Cr(m,n)=Cr(m,n)+log2(1+p(f)*abs(H(f))^2/(sigma(m)^2));

            end

        end
        
        Cap(c,m)=mean(Cr(m,:));

    end
    fprintf('The result when the number of channel equals %d dB is completed\n', Nf(c));
end
disp('----------------------------------------------------------------------------')
toc

plot(aveSNRdB,Cap(1,:),'b*-','linewidth',1.2,'markersize',8);
hold on;
grid on;
plot(aveSNRdB,Cap(2,:),'ro-','linewidth',1.2,'markersize',8);
plot(aveSNRdB,Cap(3,:),'g^-','linewidth',1.2,'markersize',8);
plot(aveSNRdB,Cap(4,:),'cs-','linewidth',1.2,'markersize',8);
xlabel('$$Average SNR=\mathrm{E}\left[|H[f]|^{2}\right] \frac{P}{\sigma^{2}}(dB)$$'...
    ,'Interpreter','latex');
ylabel('Average capacity (bps/Hz)');
% legend('Water-Filling','Equal Allocation');
legend('Channel Number = 10','Channel Number = 20','Channel Number = 30','Channel Number = 40');
title('Water-Filling Power Allocation');

end


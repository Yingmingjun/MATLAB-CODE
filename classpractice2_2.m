function classpractice2_2(~)
clear
clc
%Simulation of constellation points in the presence of noise of different mod

disp('-----------------------------------------------------------------------------')
disp('-------------------------This is Class Practice 2.2--------------------------')
disp('--------------------By Mingjun Ying at July 25th 2021--------------------')
disp('-----------------------------------------------------------------------------')
fprintf("\n")
disp('0 - BPSK' )
disp('1 - QPSK')
disp('2 - 16-QAM')
disp('3 - 64-QAM' )
disp('4 - 256-QAM' )
fprintf("\n")

Mod= input('Choose 0 to 4: ');
N=input('The number of random samples:' );
snr_dB=input('Average SNR in dB: ');
snr=10^(snr_dB/10);%10*log10(snr)
sigma=sqrt(1/snr);%snr=P/sigma^2-->sigma=sqrt(1/snr)  given P=1

switch Mod
    case 0%BPSK
        c=[-1 1];
        noise=(randn(1,N)+1i*randn(1,N))/sqrt(2)*sigma;
        s=c(randi(2,1,N))+noise;
        plot(s,'x')
        grid on
        str=sprintf('BPSK   SNR = %g (dB)',snr_dB);
        title(str);

    case 1%QPSK
        c=[-1-1i -1+1i 1-1i 1+1i];
        Pav=mean(abs(c).^2);
        c=c/sqrt(Pav) ;%Normalization
        noise=(randn(1,N) +1i*randn(1,N))/sqrt(2)*sigma ;
        s=c(randi(4,1,N)) +noise;
        plot(s,'x')
        grid on
        str=sprintf('QPSK   SNR = %g (dB)',snr_dB);
        title(str);

    case 2%16-QAM
        sI=[-3 -1 1 3];
        sQ=[-3 -1 1 3];
        k=1;
        for m=1:4
            for n=1:4
                c(k)=sI(m)+1i*sQ(n);
                k=k+1;
            end
        end
        Pav=mean(abs(c).^2);
        c=c/sqrt(Pav);
        noise=(randn(1,N)+1i*randn(1,N))/sqrt(2)*sigma;
        s=c(randi(16,1,N) )+noise;
        plot(s,'x')
        grid on
        str=sprintf('16-QAM   SNR = %g (dB)',snr_dB);
        title(str);

    case 3%64-QAM
        sI=[-7 -5 -3 -1 1 3 5 7];
        sQ=[-7 -5 -3 -1 1 3 5 7];
        k=1;
        for m=1:8.
            for n=1:8
                c(k)=sI(m)+1i*sQ(n);
                k=k+1;
            end
        end
        Pav=mean(abs(c).^2);
        c=c/sqrt(Pav) ;
        noise=(randn( 1,N)+1i*randn(1,N) )/sqrt(2)*sigma;
        s=c(randi(64,1,N))+noise;
        plot(s,'x')
        grid on
        str=sprintf('64-QAM   SNR = %g (dB)',snr_dB);
        title(str);
    case 4%256-QAM
        sI=[-15 -13 -11 -9 -7 -5 -3 -1 1 3 5 7 9 11 13 15];
        sQ=[-15 -13 -11 -9 -7 -5 -3 -1 1 3 5 7 9 11 13 15];
        k=1;
        for m=1:16.
            for n=1:16
                c(k)=sI(m)+1i*sQ(n);
                k=k+1;
            end
        end
        Pav=mean(abs(c).^2);
        c=c/sqrt(Pav) ;
        noise=(randn( 1,N)+1i*randn(1,N) )/sqrt(2)*sigma;
        s=c(randi(256,1,N))+noise;
        plot(s,'x')
        grid on
        str=sprintf('256-QAM   SNR = %g (dB)',snr_dB);
        title(str);

end

xlabel('Real part')
ylabel('Imaginary part')

end

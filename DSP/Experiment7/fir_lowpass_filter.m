function h=fir_lowpass_filter(wp,ws,As)
deltaw=abs(ws-wp);% 过渡带宽度
if As<=21
    width=1.8*pi;
    N0=ceil(width/deltaw); % 根据阻带衰减值，选择矩形窗
    N=N0+mod(N0+1,2);  % mod取模运算(这里完成取余运算)
    windows=boxcar(N);
    else if As>21&As<=25
        width=6.1*pi;
        N0=ceil(width/deltaw); % 根据阻带衰减值，选择三角窗
        N=N0+mod(N0+1,2);   % mod取模运算(这里完成取余运算)
        windows=triang(N);
        else if As>25&As<=44
                width=6.2*pi;
                N0=ceil(width/deltaw);% 根据阻带衰减值，选择hanning窗
                N=N0+mod(N0+1,2);% mod取模运算(这里完成取余运算)
                windows=hanning(N);
                else if As>44&As<=53
                        width=6.6*pi;
                        N0=ceil(width/deltaw);% 根据阻带衰减值，选择哈明窗
                        N=N0+mod(N0+1,2);% mod取模运算(这里完成取余运算)
                        windows=hamming(N);
                else
                    width=11*pi;
                    N0=ceil(width/deltaw); % 根据阻带衰减值，选择blackman窗
                    N=N0+mod(N0+1,2)  % mod取模运算(这里完成取余运算)
                    windows=blackman(N);
               end
         end
    end
end
wc=(ws+wp)/(2*pi);  % 计算截止频率
if wp<ws
    h=fir1(N-1,wc,windows);
elseif wp>ws
    h=fir1(N-1,wc,'high',windows);% 设计出滤波器的h(n)
end


[H,w]=freqz(h,1,1000,'whole');
H=(H(1:501))';
w=(w(1:501))';
mag=abs(H);
db=20*log10((mag+eps)/max(mag));
pha=angle(H);
n=0:N-1;
% dw=2*pi/1000;
% Rp=-(min(db(1:wp/dw+1)))
% As=-round(max(db(ws/dw+1:501)))
figure
subplot(2,2,1);
stem(n,h);
title('实际脉冲响应');
xlabel('n');
ylabel('h(n)');
subplot(2,2,2)
plot(w(1:501)/pi,db(1:501));
xlabel('频率（\pi）');
ylabel('(dB)');
title('幅度衰减');
subplot(2,2,3);
plot(w(1:501)/pi,mag(1:501));
title('幅度频率响应');
xlabel('频率(单位:\pi)');
ylabel('H(e^{j\omega})');
subplot(2,2,4);
plot(w(1:501)/pi,pha(1:501));
title('相位频率响应');
xlabel('频率(单位:\pi)');
ylabel('\phi(\omega)');
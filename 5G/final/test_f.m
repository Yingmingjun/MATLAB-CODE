M=24;
row=4;
col=6;


Nc=6;
Ne=9;
% snr_dB=input('The range of average SNR in dB: ');
snr_dB=0:2:20;
snr=10.^(snr_dB/10);

% Um=input('Average number of users per cell: ');
Um=9;% 6  9  12  15

% process
P1=1;%center
P2=0.3;%egde
sigma1=P1./sqrt(snr);
sigma2=P2./sqrt(snr);



% It allow we ignore the path loss exponent for introducing the rho matrix

% Genarate the average capacity%


Ne1=round(Ne/3);
Ne2=Ne1;
Ne3=Ne-Ne1-Ne2;


%----------------------1----------------------
f(1,1:Ne1)=1:Ne1;
for Row=1:row
    for Col=1:col
        if Col<=col&&mod(Row,2)==1&&mod(Col-1,3)==0
            f((Row-1)*col+Col,:)=f(1,:);
        elseif Col<=col&&mod(Row,2)==0&&mod(Col-2,3)==0
            f((Row-1)*col+Col,:)=f(1,:);
        end
    end
end
%----------------------2----------------------
f(2,1:Ne2)=Ne1+1:Ne1+Ne2;
for Row=1:row
    for Col=1:col
        if Col<=col&&mod(Row,2)==1&&mod(Col-2,3)==0
            f((Row-1)*col+Col,:)=f(2,:);
        elseif Col<=col&&mod(Row,2)==0&&mod(Col-3,3)==0
            f((Row-1)*col+Col,:)=f(2,:);
        end
    end
end

%----------------------3----------------------
f(3,1:Ne3)=Ne1+Ne2+1:Ne;
for Row=1:row
    for Col=1:col
        if Col<=col&&mod(Row,2)==1&&mod(Col-3,3)==0
            f((Row-1)*col+Col,:)=f(3,:);
        elseif Col<=col&&mod(Row,2)==0&&mod(Col-4,3)==0
            f((Row-1)*col+Col,:)=f(3,:);
        end
    end
end
f
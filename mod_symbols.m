function [s,c]=mod_symbols(Nsim,mtype)

if mtype==0
    c=[-1 1];
    NofP=2;
elseif mtype==1
    sI=[-1 1];
    sQ=[-1 1];
    NofP=4;
elseif mtype==2
    sI=[-3 -1 1 3];
    sQ=[-3 -1 1 3];
    NofP=16;
elseif mtype==3
    sI=[-7 -5 -3 -1 1 3 5 7];
    sQ=[-7 -5 -3 -1 1 3 5 7];
    NofP=64;
end

if mtype~=0
    k=1;
    for m=1:length(sI)
        for n=1:length(sQ)
            c(k)= sI(m)+1i*sQ(n);
            k=k+1;
        end
    end
    Pav=mean(abs(c).^2);%Normalized
    c=c/sqrt(Pav);
end

s=c(randi(NofP,1, Nsim));

end

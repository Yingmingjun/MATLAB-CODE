function popt=findp_txITL(p,H,sigma,P,Nf,B,U,b0,u0,S)
% S-transmit interference temperature limit
% p(b,uff) - the power allocation for the u-th user in cell b on f requency f
% H(b_ ,b,u,f) - the channel from cell b_ to user u in cell b on frequency f
% B-number of BSsorcells
% U(1),U(2), .... U(B) where U(b) is the number of users in cell b
% Our focus is on finding the optimal power allocation for user u0 in cell b0

%compute I(f)=sum_all other cells b_ to cell b0 and user u0 p(b_,u0,f)*H(b_,b0,u0,f)

for f=1:Nf
    I(f)=0;
    for b=1:B
        for u=1:U(b)
            if~(b==b0&&u==u0)
                I(f)=I(f)+p(b,u,f)*abs(H(b,b0,u0,f))^2;
            end
        end
    end
end

Htmp(1:Nf)=H(b0,b0,u0,1:Nf);
wl=fzero(@(w) fPcon_txITL(w,Htmp,sigma,I,P,S),P/Nf);

for f=1:Nf
    %c(f) is the inverse SINR
    c(f)=(sigma^2+I(f))/abs(H(b0,b0,u0,f))^2;
    if c(f)<=S
        x=wl-c(f);
        popt(f)=max([0 x]);
    else
        popt(f)=0;
    end
end

end


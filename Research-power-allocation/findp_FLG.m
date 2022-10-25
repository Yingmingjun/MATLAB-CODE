function popt=findp_FLG(p,H,sigma,P,Nf,B,U,b0,u0)
%parameter:Nf-信道数量（frequency channel）B-小区数（基站数） U(b)-第b个小区中心用户数    c-Ck[f]
% eta(f)=(c(f)^2+phi(f)*p(b0,u0,f)^2)/(c(f)-phi(f)*p(b0,u0,f)); wl = wk
%function:
%output:P[1:Nf]
for f=1:Nf
    I(f)=0;
    for b=1:B
        for u=1:U(b)
            if~(b==b0&&u==u0)
                I(f)=I(f)+p(b,u,f)*abs(H(b,b0,u0,f))^2;
            end
        end
    end
    c(f)=I(f)+sigma^2/abs(H(b0,b0,u0,f))^2';
    phi(f)=-sqrt(c(f)/(2*c(f)+p(b0,u0,f)));
    eta(f)=(c(f)^2+phi(f)*p(b0,u0,f)^2)/(c(f)-phi(f)*p(b0,u0,f));
end

wl=fzero(@(w) fPcon_FLG(w,eta,P),P/Nf);

for f=1:Nf
    x=wl-eta(f);
    popt(f)=max([0 x]);
end
end


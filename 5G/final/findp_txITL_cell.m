function popt=findp_txITL_cell(p,H,sigma,P,Nf,B,U,b0,u0,S,rho)

for f=1:Nf
    I(f)=0;
    for b=1:B
        for u=1:U(b)
            if ~(b==b0&&u==u0)
                I(f)=I(f)+rho(b,b0)*p(b,u,f)*abs(H(b,b0,u0,f))^2;
            end
        end
    end
end

Htmp(1:Nf)=H(b0,b0,u0,1:Nf);
wl=fzero(@(w) fPcon_txITL(w,Htmp,sigma,I,P,S),P/Nf);

for f=1:Nf
    c(f)=(sigma^2+I(f))/abs(H(b0,b0,u0,f))^2;
    if c(f)<=S
        % frequency f is good enough
        x=wl-c(f);
        popt(f)=max([0 x]);
    else
        % frequency f is not good enough
        popt(f)=0;
    end
end
end

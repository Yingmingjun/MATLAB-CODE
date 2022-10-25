function popt=findp_wl(p,H,sigma,P,Nf,B,U,b0,u0)

for f=1:Nf
    I(f)=0;
    for b=1:B
        for u=1:U(b)
            if ~(b==b0 && u==u0)
                I(f)=I(f)+p(b,u,f)*abs(H(b,b0,u0,f))^2;
            end
        end
    end
end

Htmp(1:Nf)=H(b0,b0,u0,1:Nf);

wl=fzero(@(w) fPcon_wl(w,Htmp,sigma,I,P),P/Nf); 
for f=1:Nf
    x=wl-(sigma^2+I(f))/abs(H(b0,b0,u0,f))^2;
    popt(f)=max([0 x]);
end

end


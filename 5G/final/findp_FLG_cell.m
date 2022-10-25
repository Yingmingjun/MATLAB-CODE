function popt=findp_FLG_cell(p,H,sigma,P,Nf,B,U,b0,u0,rho)
for f=1:Nf
    I(f)=0;
    for b=1:B
        for u=1:U(b)
            if ~(b==b0&&u==u0)
                I(f)=I(f)+rho(b,b0)*p(b,u,f)*abs(H(b,b0,u0,f))^2;
            end
        end
    end
    c(f)=(I(f)+sigma^2)/abs(H(b0,b0,u0,f))^2;
    phi(f)=-sqrt(c(f)/(2*c(f)+p(b0,u0,f)));% original

%     phi(f)=-(c(f)/(4*c(f)+p(b0,u0,f)));
    eta(f)=(c(f)^2+phi(f)*p(b0,u0,f)^2)/(c(f)-phi(f)*p(b0,u0,f));
end
wl=fzero(@(w)fPcon_FLG(w,eta,P),P/Nf);
for f=1:Nf
    x=wl-eta(f);
    popt(f)=max([0 x]); % new power allocation
end
end

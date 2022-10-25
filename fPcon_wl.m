function fval=fPcon_wl(w,H,sigma,I,P)

Nf=length(H);
fval=0;

for f=1:Nf
    x=w-(sigma^2+I(f))/abs(H(f))^2;
    fval=fval+max([0 x]);
end

fval=fval-P;

end


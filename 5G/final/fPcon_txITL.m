function fval=fPcon_txITL(w,H,sigma,I,P,S)
Nf=length(H);
fval=0;
for f=1:Nf
    c(f)=(sigma^2+I(f))/abs(H(f))^2;
    if c(f)<=S
        x=w-c(f);
        fval=fval+max([0 x]);
    end
    fval=fval-P;
end


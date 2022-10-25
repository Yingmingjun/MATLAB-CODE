function fval=fPcon_FLG(w,eta,P)
Nf=length(eta);
fval=0;
for f=1:Nf
    x=w-eta(f);
    fval=fval+max([0 x]);
end
fval=fval-P;
end
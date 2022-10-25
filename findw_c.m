function fval=findw_c(w,c,P)

Nf=length(c);
fval=0;

for f=1:Nf
    fval=fval+max(0,w-c(f));
end

fval=fval-P;

end
function fval=fun_waterlevel(w,sigma,H,P)

%water_level = w, i.e. ,(1/lambda), is the solution such that
%fun_waterlevel(2,sigma,H,P) = 0

Nf=length(H);
fval=0;

for f=1:Nf
    fval=fval+max([0 w-sigma^2/(abs(H(f))^2)]);
    
end

fval=fval-P;

end


function fval=fPcon_txITL_beta(w,H,sigma,I,P,S,beta,p,u0,b0,rho)
Nf=length(H);
fval=0;
Ave_I=0;
N_p=0;

for f=1:Nf
    if p(b0,u0,f)>0
        Ave_I=Ave_I+I(f);
        N_p=N_p+1;
    end
end

Ave_I=Ave_I/N_p;
Ave_I_check=mean(I(find(p(b0,u0,:)>0)));
N_p_check=length(find(p(b0,u0,:)>0));
S_=max(S,beta*Ave_I);

for f=1:Nf
    c(f)=(sigma^2+I(f))/abs(H(f))^2;
    if c(f)<=S_
        x=w-c(f);
        fval=fval+max([0 x]);
    end
end
fval=fval-P;
end

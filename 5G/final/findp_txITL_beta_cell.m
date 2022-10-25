function popt=findp_txITL_beta_cell(p,H,sigma,P,Nf,B,U,b0,u0,S,beta,rho)
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
wl=fzero(@(w)fPcon_txITL_beta(w,Htmp,sigma,I,P,S,beta,p,u0,b0),P/Nf);
Ave_I=0;% average interference
N_p=0;% number of active frequency channels (with positive power)
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
    c(f)=(sigma^2+I(f))/abs(H(b0,b0,u0,f))^2;
    if c(f)<=S_
        x=wl-c(f);
        popt(f)=max([0 x]);
    else
        popt(f)=0;
    end
end
end


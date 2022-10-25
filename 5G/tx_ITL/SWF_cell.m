function popt=SWF_cell(H,sigma,P,Nf,B,U,OPTIONS,rho)

if OPTIONS(1)==0
    mOPTION=0;
elseif OPTIONS(1)==1
    mOPTION=1;
    S=OPTIONS(2);
elseif OPTIONS(1)==2
    mOPTION=2;
    S=OPTIONS(2);
    beta=OPTIONS(3);
elseif OPTIONS(1)==3
    mOPTION=3;
end
MaxIter=200; % the maximum number of iterations
delta=1e-4; % the difference threshold in the update
% initializing the power allocation
for b=1:B
    for u=1:U(b)
        ptmp=rand(1,Nf);
        ptmp=P*ptmp/sum(ptmp);
        p(b,u,1:Nf)=ptmp;
        clear ptmp;
    end
end
n_iter=1;
while 1
    p_old=p;
    for b=1:B
        for u=1:U(b)
            if mOPTION==0 %SWF
                ptmp=findp_wI_cell(p,H,sigma,P,Nf,B,U,b,u,rho);
            elseif mOPTION==1 %txITL with fixed S
                ptmp=findp_txITL_cell(p,H,sigma,P,Nf,B,U,b,u,S,rho);
            elseif mOPTION==2 %txITL with S and beta
                ptmp=findp_txITL_beta_cell(p,H,sigma,P,Nf,B,U,b,u,S,beta,rho);
            elseif mOPTION==3 %FLG
                ptmp=findp_FLG_cell(p,H,sigma,P,Nf,B,U,b,u,rho);
            end
            p(b,u,1:Nf)=ptmp;
            clear ptmp;
        end
    end
    p_new=p;
    n_iter=n_iter+1;
    if n_iter>MaxIter||sum(sum(sum((p_new-p_old).^2)))<delta
        break;
    end
end
popt=p;
end

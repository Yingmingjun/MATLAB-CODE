function popt=sWF(H,sigma,P,Nf,B,U,OPTIONS)

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

MaxIter=200;%the maximum number of iterations
delta=1e-4;% the difference threshold in the update

%initializing the power allocation
% for b=1:B
%     for u=1:U(b)
%         ptmp=rand(1,Nf);
%         ptmp=P*ptmp/sum(ptmp);
%         p(b,u,1:Nf)=ptmp;
%         clear ptmp;
%     end  
%     p(b,:,:)=p(b,:,:)./sum(sum(p(b,:,:)));
% end
%each user have the Power budget as 1
for b=1:B
    for u=1:U(b)
        ptmp=rand(1,Nf);
        ptmp=P*ptmp/sum(ptmp); %ptmp=ptmp/sum(ptmp);
        p(b,u,1:Nf)=ptmp;
        clear ptmp;
    end
end

n_iter=1;
while 1
    p_old=p;
    for b=1:B
        for u=1:U(b)
            %we are focusing a particular user (b,u)
            if mOPTION==0 %sWF
                ptmp=findp_wl(p,H,sigma,P,Nf,B,U,b,u);
            elseif mOPTION==1 %tx-ITL with fixed S
                ptmp=findp_txITL(p,H,sigma,P,Nf,B,U,b,u,S);
            elseif mOPTION==2 %tx-ITL with S and beta
                ptmp=findp_txITL_beta(p,H,sigma,P,Nf,B,U,b,u,S,beta);
            elseif mOPTION==3 %FLG
                ptmp=findp_FLG(p,H,sigma,P,Nf,B,U,b,u);
            end
            P(b,u,1:Nf)=ptmp;
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


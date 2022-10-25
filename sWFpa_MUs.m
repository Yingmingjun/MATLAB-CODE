function p=sWFpa_MUs(H,sigma,P,U,Nc,rho,M)
%p(1:Nf,1:U)kh


Niter_max=1000; %the maximum number of iterations
d_threshold=1e-4;%1e-6;%the threshold between p_new and p_old
Nrun=1;


p=rand(Nc,M,max(U));%Number of cell = M
p_old=p;
%This could limit each basestation's power to 1
% for n=1:max(U)
%     tempt1=sum(p(:,:,n));
% 
%     for m=1:M
%         p(:,m,n)=p(:,m,n)/tempt1(m)/M;
%     end
%     clear tempt1;
% end

for b=1:M
    for u=1:U(b)
        ptmp=rand(1,Nc);
        ptmp=P.*ptmp./sum(ptmp); %ptmp=ptmp/sum(ptmp);
        p(1:Nc,b,u)=ptmp;
        clear ptmp;
    end
end



while 1
    for nc=1:M
        for u=1:U(nc)
            % User u in cell c only
            for f=1:Nc
                Inter(f)=sigma^2;
                for nc_=1:M
                    for u_=1:U(nc_)
                        if nc_~=nc||u_~=u
                            Inter(f)=Inter(f)+rho(nc,nc_)*p(f,nc_,u_)*abs(H(nc_,nc,u,f))^2;
                        end
                    end
                end
                c(f)=Inter(f)/abs(H(nc,nc,u,f))^2;
            end
            ptmp=wfpa_c(c,P);
            p(:,nc,u)=ptmp';
            clear ptmp;
        end
    end
    
    Nrun=Nrun+1;
    p_new=p;

    if sum(sum(sum(abs(p_new-p_old).^2)))<d_threshold || Nrun>Niter_max
        return;
    end
    p_old=p_new;
end
end


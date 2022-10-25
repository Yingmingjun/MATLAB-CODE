function p=sWFpa_MU(H,sigma,P,U,Nf)
%p(1:Nf,1:U)kh


Niter_max=1e3; %the maximum number of iterations
d_threshold=1e-3;%1e-6;%the threshold between p_new and p_old
Nrun=1;
t=0.9000;%rho is based on the distance
e=0.5774*0.9;
r=0.5000*0.9;
rho=[1  t  t  t  t  t  t;...%1
     t  1  t  e  r  e  t;...%2
     t  t  1  t  e  r  e;...%3
     t  e  t  1  t  e  r;...%4
     t  r  e  t  1  t  e;...%5
     t  e  r  e  t  1  t;...%6
     t  t  e  r  e  t  1];  %7

p=rand(Nf,7,max(U));%Number of cell = 7
p_old=p;

for n=1:max(U)
    tempt1=sum(p(:,:,n));

    for m=1:7
        p(:,m,n)=p(:,m,n)/tempt1(m)/7;
    end
    clear tempt1;
end

while 1
    for nc=1:7
        for u=1:U(nc)
            % User u in cell c only
            for f=1:Nf
                I(f)=sigma^2;
                for nc_=1:7
                    for u_=1:U(nc_)
                        if nc_~=nc||u_~=u
                            I(f)=I(f)+rho(nc,nc_)*p(f,nc_,u_)*abs(H(nc_,nc,u,f))^2;
                        end
                    end
                end
                c(f)=I(f)/abs(H(nc,nc,u,f))^2;
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


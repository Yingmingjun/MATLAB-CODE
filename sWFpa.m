function p=sWFpa(H,sigma,P)
%p(1:Nf,1:U)

[Nf,U,unused]=size(H); 
Niter_max=1e2; %the maximum number of iterations
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

p=rand(Nf,U)*P/Nf;
p_old=p;
tempt=sum(p);
for n=1:U
    p(:,n)=p(:,n)/tempt(n);
end

while 1
    for u=1:U
        % focus on user u ONLY
        
        for f=1:Nf
            I(f)=sigma^2;
            for u_=1:U
                if u_~=u
%                     I(f)=I(f)+p(f,u_)*abs(H(f,u_,u))^2;
                    I(f)=I(f)+rho(u,u_)*p(f,u_)*abs(H(f,u_,u))^2;
                end
            end
            c(f)=I(f)/abs(H(f,u,u))^2;
        end
        
        ptmp=wfpa_c(c,P);
        p(:,u)=ptmp';
        clear ptmp;
    end
    
    Nrun=Nrun+1;
    p_new=p;
    
    if sum(sum(abs(p_new-p_old).^2))<d_threshold | Nrun>Niter_max
        return;
    end
    p_old=p_new;
end
B=7;
P=1;
for i=1:B
    U(i)=poissrnd(3);
end
Nf=10;
for b=1:B
    for u=1:U(b)
        ptmp=rand(1,Nf);
        ptmp=P*ptmp/sum(ptmp);
        p(b,u,1:Nf)=ptmp;
        clear ptmp;
    end  
    p(b,:,:)=p(b,:,:)./sum(sum(p(b,:,:)));
    
end
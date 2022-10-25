M=3;
Um=5;
Nc=6;

for c=1:M
    U(c)=poissrnd(Um);
end

for b=1:M
    for u=1:U(b)
        ptmp=rand(1,Nc);
        ptmp=1.*ptmp./sum(ptmp); %ptmp=ptmp/sum(ptmp);
        p(1:Nc,b,u)=ptmp;
        clear ptmp;
    end
end

sum(p(:,1,1))

% P(1,2,:)./sum(P(1,2,:))
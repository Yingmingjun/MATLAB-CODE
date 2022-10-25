function f=dynamic_fa(M,N,f)

    j=1;
    l=N;
for i=N+1:M
    

    if mod(i,3)==0
        f(i,:)=f(j,:);
        if j<l-1
            j=j+1;
        else 
            j=1;
        end
    else
        f(i,:)=f(l,:);
        if l>j+1
            l=l-1;
        else
            l=N;
        end
    end
        
    
    
end
























end
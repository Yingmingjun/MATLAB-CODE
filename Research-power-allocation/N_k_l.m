function [K,L]=N_k_l(N)

for k=1:10
    for l=1:10
        if (k-1)^2+(l-1)^2+(k-1)*(l-1)==N
            K=k-1;
            L=l-1;
            return;
        end
    end
end



end
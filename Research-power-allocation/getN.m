function N_mat=getN(~)
%This function is for generating the frequency reuse factor N

max=20;

N_mat=[];
cir=0;

for k=1:max
    for l=1:max
        k=k-1;
       
        N=k^2+l^2+k*l;
        cir= cir +1;
        N_mat(cir) = N;
        
    end
end

N_mat=sort(unique(N_mat));
end
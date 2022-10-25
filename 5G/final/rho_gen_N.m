function [F,rho_matrix]=rho_gen_N(M,row,col,f,N,Nc)
%This function is used for generating the hexagon central axis point
%and to get the distance of each central point.
% row=input('Please input the row number of the cluster:');
% col=input('Please input the column number of the cluster:');
% r=input('Please input the size(rdadius) of a single hexagon:');
r=1;


if ~(find(N==getN))
    N=input('Your input number is illegal, please input the reuse factor again as 1,3,4,7,9,12,13...');
end

[k,l]=N_k_l(N);
x_n=round(M/col);
y_n=round(M/row);


%%Using for loop and the mathmatic relation to generate
%the hexagon's central coordinate
for x=1:x_n%row
    for y=1:y_n%col
        
        %If the row is a even numeber
        if(mod(x,2)==0)
            Coor_X(x,y)=(sqrt(3)*(y-1)+0.5*sqrt(3))*r;
            Coor_Y(x,y)=(1.5*(x-1))*r;
            
            %If the row is a odd numeber
        elseif(mod(x,2)==1)
            Coor_X(x,y)=(sqrt(3)*(y-1))*r;
            Coor_Y(x,y)=(1.5*(x-1))*r;
        end
    end
end


%%Using to get the distance between each central point
for x1=1:x_n%row
    for y1=1:y_n%col
        for x2=1:x_n
            for y2=1:1:y_n
                dist(x1,y1,x2,y2)=sqrt((Coor_X(x1,y1)-Coor_X(x2,y2))^2+(Coor_Y(x1,y1)-Coor_Y(x2,y2))^2);
            end
        end
    end
end


%%change the index into 1,2,3,...,max_number_of_cells
Dist=zeros(M,M);
i=1;
for x1=1:x_n%row
    for y1=1:y_n%line
        j=1;
        for x2=1:x_n
            for y2=1:1:y_n
                if j<=M
                    Dist(i,j)=dist(x1,y1,x2,y2);
                    j=j+1;
                end
            end
        end
        if i<M
            i=i+1;
        end
    end
end

save Dist
D=sqrt((k*sqrt(3)*r)^2+(l*sqrt(3)*r)^2+k*l*3*r^2);

save D


% frequency allocation for each cell

f=f_alloc(N,Dist,D,f,M,Nc);

% for start_point=1:N
%     while find(start_point==result_point)
%         start_point=start_point+1;
%     end
%     result_point=F_allocate(start_point,D,Dist);
%     for i=1:length(result_point)
%         f(result_point(i),:)=f(start_point,:);
%     end
% end
%%Generating the rho matrix
%assuming that rho =1 when distance between two cell is sqrt(3)

for i=1:M
    for j=1:M
        if ~(i==j)
            rho(i,j)=0.9*sqrt(3)*r/Dist(i,j);
        else
            rho(i,j)=1;
        end
    end
end

if ~(N==1)
    D=sqrt(3*(k^2+l^2+k*l)*r^2);
    for i=1:M
        for j=1:M
            if ~(Dist(i,j)==D)
                rho(i,j)=0;
            end
        end
    end
end

%%return the rho matrix

rho_matrix=rho;
F=f;

end

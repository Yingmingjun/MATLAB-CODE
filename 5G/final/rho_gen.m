function rho_matrix=rho_gen(number_of_cells,row,col,N)
%This function is used for generating the hexagon central axis point
%and to get the distance of each central point.
% row=input('Please input the row number of the cluster:');
% col=input('Please input the column number of the cluster:');
% r=input('Please input the size(rdadius) of a single hexagon:');
r=100;
if ~(find(N==getN))
    N=input('Your input number is illegal, please input the reuse factor again as 1,3,4,7,9,12,13...');
end
% alpha=input('The value of pathloss exponent:');%pathloss exponent
alpha=4;
[k,l]=N_k_l(N);
x_n=round(number_of_cells/col);
y_n=round(number_of_cells/row);


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
Dist=zeros(number_of_cells,number_of_cells);
i=1;
for x1=1:x_n%row
    for y1=1:y_n%line
        j=1;
        for x2=1:x_n
            for y2=1:1:y_n
                if j<=number_of_cells
                    Dist(i,j)=dist(x1,y1,x2,y2);
                    j=j+1;
                end
            end
        end
        if i<number_of_cells
            i=i+1;
        end
    end
end


%%Generating the rho matrix
%assuming that rho =1 when distance between two cell is sqrt(3)

for i=1:number_of_cells
    for j=1:number_of_cells
        if ~(i==j)
            rho(i,j)=sqrt(3)*r/Dist(i,j);
%             rho(i,j)=Dist(i,j)^(-alpha);
        else
            rho(i,j)=0.9;
        end
    end
end

if ~(N==1)
    D=sqrt(3*(k^2+l^2+k*l)*r^2);
    for i=1:number_of_cells
        for j=1:number_of_cells
            if ~(Dist(i,j)==D)&&~(i==j)
                rho(i,j)=0;
            end
        end
    end
end
    
%%return the rho matrix

rho_matrix=rho;


end

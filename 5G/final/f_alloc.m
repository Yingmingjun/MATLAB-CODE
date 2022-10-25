function f=f_alloc(IFR_N,Dist,D,Fre,M,Nc)

D=vpa(D,5);
% start_point: Set the initial point
% D: set the distance used for looking the same bunch of cells
% Dist: A distance matrix have all the information between two cells

f=zeros(M,round(Nc/IFR_N));
for start_point=1:IFR_N

    %defenition of a group of cells have the same features
    result_point=[];
    
    %Calculate all the cell that should be searched
    
    N = size(Dist,1);
    
    %Use another matrix to replace the original one, to avoid the unnesseary change
    Dist_mat = Dist;
    
    Dist_mat=vpa(Dist_mat,5);
%     D=num2str(D);
%     Dist_mat=num2str(Dist_mat);
    
    %Adjust Dist_mat's 0 to inf
    Dist_mat(Dist_mat == 0)=inf;
    
    %Define the matrix that which should be searched
    temple_search_mat = [start_point];
    charge = size(temple_search_mat);
    
    cir = 0;
    
    while (charge ~= 0)
        cir= cir+1;

        Dist_mat(:,result_point)=inf; %Avoid searching again save time
        [m,n]=find(Dist_mat(:,temple_search_mat)==D);
        result_point = unique([result_point;temple_search_mat]);
        
%             disp('result_point');
            result_point';
        
        temple_search_mat = m;
        
%             disp('temple_search_mat');
            temple_search_mat';
        
        charge = size(temple_search_mat);
        if length(result_point)>M/IFR_N+10
            break
        end
    end

    
    disp('These cell belongs to a same group:')
    result_point'
    %Frequency Allocation
%     for index=1:length(result_point)
%         f(result_point(index),:)=F(start_point,:);
%     end
    %Frequency Allocation
%     disp('length(result_point)')
    for index=1:length(result_point)
        f(result_point(index),1:length(Fre(start_point,:)))=Fre(start_point,:);
%         f(result_point(index),:)=Fre(start_point,:);
    end
    clear result_point

end
end




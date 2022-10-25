clear
clc
load('Dist.mat')
load D
D=roundn(D,-4)
% start_point: 设置初始点
% D：设定传入的D数值
% Dist: 可直接调用的Dist矩阵

start_point = 1;


%定义满足条件的节点集合
result_point=[];

%计算待搜索节点总数
%ATTENTION：我不确定N是不是等于number_of_cells
N = size(Dist,1);

%先定义一个用作计算的Dist替代矩阵，避免改变原始值
Dist_mat = Dist;

Dist_mat=roundn(Dist_mat,-4)

%将Dist_mat矩阵中为0的值调整为inf
Dist_mat(Dist_mat == 0)=inf;

%定义需要搜索的节点集合
temple_search_mat = [start_point];
charge = size(temple_search_mat);

cir = 0;

while(charge ~= 0)
    cir= cir+1;
    cir
    Dist_mat(:,result_point)=inf; %将已在结果集合内的节点互相间的距离设置为inf,避免重复获取
    [m,n]=find(  Dist_mat(:,temple_search_mat)== D );
    result_point = unique([result_point;temple_search_mat]);
    
    disp('result_point')
    result_point'
    
    temple_search_mat = m;
    
    disp('temple_search_mat')
    temple_search_mat'
    
    charge = size(temple_search_mat);
end

%输出结果矩阵
disp('最终结果')
result_point
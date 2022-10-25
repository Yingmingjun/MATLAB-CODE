
function yhat=func(beta0,X)
a1=beta0(1);
a2=beta0(2);
a3=beta0(3);
a4=beta0(4);
a5=beta0(5);
a6=beta0(6);
a7=beta0(7);
a8=beta0(8);
a9=beta0(9);
a10=beta0(10);
a11=beta0(11);


x1=X(:,1);
x2=X(:,2);
x3=X(:,3);
x4=X(:,4);
x5=X(:,5);
x6=X(:,6);
x7=X(:,7);
x8=X(:,8);
x9=X(:,9);
x10=X(:,10);

yhat=a1+x1.^a2+x2.^a3+x3.^a4+x4.^a5+x5.^a6+x6.^a7+...
    x7.^a8+x8.^a9+x9.^a10+x10.^a11; %指数运算 乘除运算均为元素之间的，所以要用"."
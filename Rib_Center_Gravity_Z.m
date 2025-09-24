function Ans=Rib_Center_Gravity_Z(A,B,Y,Z_UP,Density)% 计算肋骨重心在Z轴上的位置
X=sqrt((Z_UP-B.*Y.^2)./A);% 计算变量X的值
M=Rib_Quality(A,B,Y,Z_UP,Density);% 调用Rib_Quality函数计算每个肋骨的质量%函数跳转6
Ans=zeros(1,5,'double');% 使用零值初始化Ans和a数组
a=zeros(1,5,'double');
for i=1:5% 循环执行i=1:5的迭代
    Z_min=@(x)A.*x.^2+B.*Y(i).^2;% 匿名函数Z_min，带有参数x，表示积分下限
    f1=@(x,z)x.*0+Density.*z;% 匿名函数f1，带有参数x和z，返回x和z的乘积的和
    a(i)=integral2(f1,-X(i),X(i),Z_min,Z_UP);% 计算f1在积分区域内的双重积分。积分区域由-X(i)到X(i)表示x范围，由Z_min到Z_UP表示z范围。% 将结果赋值给a数组的第i个元素
end
Ans=a./M;% 计算重心位置，即a数组的每个元素除以对应的质量M，结果存储在Ans数组中
end
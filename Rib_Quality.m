function Ans=Rib_Quality(A,B,Y,H,Density)%计算肋骨质量的函数
X=sqrt((H-B.*Y.^2)./A);%计算变量X的值
Ans=zeros(1,5,'double');% 使用零值初始化Ans数组
for i=1:5
    f2=@(x,z)Density+x.*0+z.*0;% 匿名函数f2，带有参数x和z，常数项为Density
    Z_min=@(x)A.*x.^2+B.*Y(i).^2; % 匿名函数Z_min，带有参数x，表示积分下限
    Ans(i)=integral2(f2,-X(i),X(i),Z_min,H);%计算f2在-x(i)到x(i)的x范围和Z_min到H的z范围上的双重积分，并将结果赋值给Ans(i)%跳转回Boat_Quality
end
end%函数跳回1Boat_Quality
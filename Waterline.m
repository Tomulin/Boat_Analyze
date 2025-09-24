function Ans=Waterline(A,B,H,Water_density,M)%计算平吃水线高度
%二分法
low=0;%设置查找的底部
Accuracy=0.000001;
top=H-Accuracy;%设置查找的顶部
while low<=top
    high=(low+top)./2;
    Y_max=sqrt(high./B);% 计算Y的最大值
    X_max=@(y,x,z)sqrt((high-B.*y.^2)./A);% 定义匿名函数X_max，带有参数y、x和z，用于计算X的上限
    X_min=@(y,x,z)-sqrt((high-B.*y.^2)./A);% 定义匿名函数X_min，带有参数y、x和z，用于计算X的下限
    Z_min=@(y,x,z)A.*x.^2+B.*y.^2;% 定义匿名函数Z_min，带有参数y、x和z，用于计算Z的下限
    f=@(y,x,z)1+x.*0+y.*0+z.*0; % 定义匿名函数f，带有参数y、x和z，返回常数1
    V=integral3(f,-Y_max,Y_max,X_min,X_max,Z_min,high);%排开水的体积
    F=V*Water_density;% 计算排开水的质量
    if(abs(M-F)<=0.001)%找到最后一个满足精度的结果
        Ans=high;
    end
    if(M<F)
        top=high-Accuracy;% 更新查找的顶部
    end
    if M>F
        low=high+Accuracy;% 更新查找的底部
    end
end
end
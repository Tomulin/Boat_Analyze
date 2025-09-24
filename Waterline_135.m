function Ans=Waterline_135(A,B,H,X_MAX,M,Angle)%计算135度吃水线的高度
K=tan(Angle./180.*pi);%计算角度的正切值
C=[H+K.*X_MAX H-K.*X_MAX];% 计算C的范围，作为二分法查找的初始区间
low=C(1); % 二分法查找的底部
Accuracy=0.000001;% 精度
high=C(2)-Accuracy;% 二分法查找的顶部
Ans=-5;% 初始化Ans为-5
while low<=high
    c=(low+high)./2;% 二分法查找的中点
    syms x
    t=zeros(1,2,'double');
    f=A.*x.^2-x.*K-c==0;% 方程 A*x^2 - x*K - c = 0
    T=double(solve(f));% 求解方程的根
    for i=1:2
        if isreal(T(i))
            t(i)=T(i);% 将实数根保存在数组t中
        end
    end
    X=sort(t);% 对根进行排序
    %对区域1积分
    f=@(x,y,z)z.*0+1;X_min=X(2);
    X_max=X_MAX;
    Y_min=@(x,y,z)-sqrt((H-A.*x.^2)./B);
    Y_max=@(x,y,z)sqrt((H-A.*x.^2)./B);
    Z_min=@(x,y,z)A.*x.^2+B.*y.^2;
    Z_max=@(x,y,z)x.*0+H;
    a=integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
    %对区域二积分
    f=@(x,y,z)z.*0+1;
    X_max=X(2);
    X_min=(H-c)./K;
    Y_min=@(x,y,z)sqrt((x.*K+c-A.*x.^2)./B);
    Y_max=@(x,y,z)sqrt((H-A.*x.^2)./B);
    Z_min=@(x,y,z)A.*x.^2+B.*y.^2;
    Z_max=@(x,y,z)x.*0+H;
    a=a+2.*integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
    %对区域三积分
    f=@(x,y,z)z.*0+1;
    X_max=X(2);
    X_min=(H-c)./K;
    Y_min=@(x,y,z)-sqrt((x.*K+c-A.*x.^2)./B);
    Y_max=@(x,y,z)sqrt((x.*K+c-A.*x.^2)./B);
    Z_min=@(x,y,z)x.*K+c;
    Z_max=@(x,y,z)x.*0+H;
    a=a+integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
    F=a*1000;% 计算质量
    if(abs(M-F)<=0.001)
        Ans=c;% 找到满足精度要求的高度
    end
    if M>F
        high=c-Accuracy;% 质量过大，调整查找区间的顶部
    end
    if M<F
        low=c+Accuracy;% 质量过小，调整查找区间的底部
    end
end
if Ans==-5
    low=0;% 重新设置查找的底部和顶部
    Accuracy=0.000001;
    high=C(1)-Accuracy;
    while low<=high
        c=(low+high)./2;% 二分法查找的中点
        syms x
        f=A.*x.^2-x.*K-c==0;% 方程 A*x^2 - x*K - c = 0
        T=double(solve(f));% 求解方程的根
        X=zeros(1,2,'double');
        for i=1:2
            if isreal(T(i))
                X(i)=T(i);% 将实数根保存在数组X中
            end
        end
        X=sort(X);% 对根进行排序
        %对区域1积分
        f=@(x,y,z)z.*0+1;
        X_min=X(2);
        X_max=X_MAX;
        Y_min=@(x,y,z)-sqrt((H-A.*x.^2)./B);
        Y_max=@(x,y,z)sqrt((H-A.*x.^2)./B);
        Z_min=@(x,y,z)A.*x.^2+B.*y.^2;
        Z_max=@(x,y,z)x.*0+H;
        t=integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        %对区域2积分
        f=@(x,y,z)z.*0+1;
        X_max=X(2);
        X_min=X(1);
        Y_min=@(x,y,z)sqrt((x.*K+c-A.*x.^2)./B);
        Y_max=@(x,y,z)sqrt((H-A.*x.^2)./B);
        Z_min=@(x,y,z)A.*x.^2+B.*y.^2;
        Z_max=@(x,y,z)x.*0+H;
        t=t+2.*integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        %对区域3积分
        f=@(x,y,z)z.*0+1;
        X_max=X(2);
        X_min=X(1);
        Y_min=@(x,y,z)-sqrt((x.*K+c-A.*x.^2)./B);
        Y_max=@(x,y,z)sqrt((x.*K+c-A.*x.^2)./B);
        Z_min=@(x,y,z)x.*K+c;
        Z_max=@(x,y,z)x.*0+H;
        t=t+integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        %对区域4积分
        f=@(x,y,z)z.*0+1;
        X_min=-X_MAX;
        X_max=X(1);
        Y_min=@(x,y,z)-sqrt((H-A.*x.^2)./B);
        Y_max=@(x,y,z)sqrt((H-A.*x.^2)./B);
        Z_min=@(x,y,z)A.*x.^2+B.*y.^2;
        Z_max=@(x,y,z)x.*0+H;
        t=t+integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        F=t*1000;% 计算质量
        if(abs(M-F)<=0.1)
            Ans=c;% 找到满足精度要求的高度
        end
        if M>F
            high=c-Accuracy;% 质量过大，调整查找区间的顶部
        end
        if M<F
            low=c+Accuracy;% 质量过小，调整查找区间的底部
        end
    end
end
end

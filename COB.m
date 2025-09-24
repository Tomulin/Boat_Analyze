function Ans=COB(A,B,H,X_MAX,c,Angle)
K=tan(Angle./180.*pi);%对应角度吃水线方程斜率
C=H+K.*X_MAX;%第一种积分情况与第二种积分情况的分界
if c>=C %第一种积分情况
syms x v_com
%double v_com
t=zeros(1,2,'double');
f=A.*x.^2-x.*K-c==0;
T=double(solve(f));
for i=1:2
 if isreal(T(i))
  t(i)=T(i);
 end
end
X=sort(t);
f=@(x,y,z)z.*0+1;
f1=@(x,y,z)z.*0+x;
f2=@(x,y,z)z.*0+z;
%积分区域1-------------------------------------------------------------
X_min=X(2);
X_max=X_MAX;
Y_min=@(x,y,z)-sqrt((H-A.*x.^2)./B);
Y_max=@(x,y,z)sqrt((H-A.*x.^2)./B);
Z_min=@(x,y,z)A.*x.^2+B.*y.^2;
Z_max=@(x,y,z)x.*0+H;
v_com=integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
x_com=integral3(f1,X_min,X_max,Y_min,Y_max,Z_min,Z_max);%求积分区1的浮心的x轴坐标
z_com=integral3(f2,X_min,X_max,Y_min,Y_max,Z_min,Z_max);%求积分区1的浮心的z轴坐标
%积分区域2-------------------------------------------------------------
X_max=X(2);
X_min=(H-c)./K;%135吃水线与甲板的交线
Y_min=@(x,y,z)sqrt((x.*K+c-A.*x.^2)./B);%甲板投影135吃水面相交形成的曲线
Y_max=@(x,y,z)sqrt((H-A.*x.^2)./B);
Z_min=@(x,y,z)A.*x.^2+B.*y.^2;
Z_max=@(x,y,z)x.*0+H;
v_com=v_com+2.*integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
x_com=x_com+2.*integral3(f1,X_min,X_max,Y_min,Y_max,Z_min,Z_max);%求积分区2的浮心的x轴坐标
z_com=z_com+2.*integral3(f2,X_min,X_max,Y_min,Y_max,Z_min,Z_max);%求积分区2的浮心的z轴坐标
%积分区域3-------------------------------------------------------------
X_max=X(2);
X_min=(H-c)./K;%135吃水线与甲板的交线
Y_min=@(x,y,z)-sqrt((x.*K+c-A.*x.^2)./B);%甲板投影135吃水面相交形成的曲线
Y_max=@(x,y,z)sqrt((x.*K+c-A.*x.^2)./B);
Z_min=@(x,y,z)x.*K+c;
Z_max=@(x,y,z)x.*0+H;
v_com=v_com+integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
x_com=x_com+integral3(f1,X_min,X_max,Y_min,Y_max,Z_min,Z_max);%求积分区3的浮心的x轴坐标
z_com=z_com+integral3(f2,X_min,X_max,Y_min,Y_max,Z_min,Z_max);%求积分区3的浮心的z轴坐标
%-------------------------------------------------------------
Ans=[x_com./v_com 0 z_com./v_com];%求出浮心
else
syms x
f=A.*x.^2-x.*K-c==0;%龙骨135吃水线交线
T=double(solve(f));
X=zeros(1,2,'double');
for i=1:2
    if isreal(T(i))
        X(i)=T(i);
    end
end
X=sort(X);
f=@(x,y,z)z.*0+1;
f1=@(x,y,z)z.*0+x;
f2=@(x,y,z)z.*0+z;
%积分区域1-----------------------------------------------------------------------
X_min=X(2);
X_max=X_MAX;
Y_min=@(x,y,z)-sqrt((H-A.*x.^2)./B);
Y_max=@(x,y,z)sqrt((H-A.*x.^2)./B);
Z_min=@(x,y,z)A.*x.^2+B.*y.^2;
Z_max=@(x,y,z)x.*0+H;
v_com=integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
x_com=integral3(f1,X_min,X_max,Y_min,Y_max,Z_min,Z_max);%求积分区1的浮心的x轴坐坐标
z_com=integral3(f2,X_min,X_max,Y_min,Y_max,Z_min,Z_max);%求积分区1的浮心的z轴坐坐标
%积分区域2-----------------------------------------------------------------------
X_max=X(2);
X_min=X(1);
Y_min=@(x,y,z)sqrt((x.*K+c-A.*x.^2)./B);
Y_max=@(x,y,z)sqrt((H-A.*x.^2)./B);
Z_min=@(x,y,z)A.*x.^2+B.*y.^2;
Z_max=@(x,y,z)x.*0+H;
v_com=v_com+2.*integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
x_com=x_com+2.*integral3(f1,X_min,X_max,Y_min,Y_max,Z_min,Z_max);%求积分区2的浮心的x轴坐坐标
z_com=z_com+2.*integral3(f2,X_min,X_max,Y_min,Y_max,Z_min,Z_max);%求积分区2的浮心的z轴坐坐标
%积分区域3-----------------------------------------------------------------------
X_max=X(2);
X_min=X(1);
Y_min=@(x,y,z)-sqrt((x.*K+c-A.*x.^2)./B);
Y_max=@(x,y,z)sqrt((x.*K+c-A.*x.^2)./B);
Z_min=@(x,y,z)x.*K+c;
Z_max=@(x,y,z)x.*0+H;
v_com=v_com+integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
x_com=x_com+integral3(f1,X_min,X_max,Y_min,Y_max,Z_min,Z_max);%求积分区3的浮心的x轴坐标
z_com=z_com+integral3(f2,X_min,X_max,Y_min,Y_max,Z_min,Z_max);%求积分区3的浮心的z轴坐标
%积分区域4-----------------------------------------------------------------------
X_min=-X_MAX;
X_max=X(1);
Y_min=@(x,y,z)-sqrt((H-A.*x.^2)./B);
Y_max=@(x,y,z)sqrt((H-A.*x.^2)./B);
Z_min=@(x,y,z)A.*x.^2+B.*y.^2;Z_max=@(x,y,z)x.*0+H;
v_com=v_com+integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
x_com=x_com+integral3(f1,X_min,X_max,Y_min,Y_max,Z_min,Z_max);%求积分区4的浮心的x轴坐标
z_com=z_com+integral3(f2,X_min,X_max,Y_min,Y_max,Z_min,Z_max);%求积分区4的浮心的z轴坐标
Ans=[x_com./v_com 0 z_com./v_com];%求出浮心
end
end
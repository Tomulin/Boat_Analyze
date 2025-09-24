function Ans=Keel_Center_Gravity(Y_MAX,Z_UP,B,Density)%计算龙骨的重心
keel_Z=@(y)B.*y.^2;%Z积分下限
f1=@(y,z)y.*0+Density.*z;
M=Keel_Quality(Y_MAX,Z_UP,B,Density);%质量
a=integral2(f1,-Y_MAX,Y_MAX,keel_Z,Z_UP);
Ans=a./M;
end
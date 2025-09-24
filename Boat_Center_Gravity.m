function Ans=Boat_Center_Gravity(Z,M)%整船的重心
m=0;
z_m=0;
for i=1:length(Z)
    z_m=z_m+M(i).*Z(i);%质量乘以重心的坐标
    m=m+M(i);%计算累加的质量
end
    Ans=z_m./m;%计算小船重心
end
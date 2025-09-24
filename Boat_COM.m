function Ans=Boat_COM(A,B,H,Density)%船重心
Y_MAX=sqrt(H./B);%y轴上的最大
Y3=0;%3肋骨y轴坐
Y4=Y_MAX./3;%4肋骨y轴坐
Y5=Y_MAX.*2./3;%5肋骨y轴坐
Y=[-Y5 -Y4 Y3 Y4 Y5];
Z_center_gravity=Rib_Center_Gravity_Z(A,B,Y,H,Density);%求出五块肋骨的重心在z轴的坐标 返回数组 %函数调转5
M=Rib_Quality(A,B,Y,H,Density);%求出五块肋骨重量返回数组
Z_center_gravity(end+1)=Keel_Center_Gravity(Y_MAX,H,B,Density);%求出龙骨面板的重心
M(end+1)=Keel_Quality(Y_MAX,H,B,Density);%求出龙骨面板的质量
Z_center_gravity(end+1)=0.31;%桅杆的重心
M(end+1)=0.1111;%桅杆的质量
Z_center_gravity(end+1)=0.04;%重物的重心
M(end+1)=0.7664;%重物的质量
Ans=Boat_Center_Gravity(Z_center_gravity,M);%船的重心
end
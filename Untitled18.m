A=22.5;
B=3.8;
H=0.12;
Density=1.6;% 密度
Y_MAX=sqrt(H./B);% y轴的最大值
Y3=0;% 第3个肋骨y轴坐标
Y4=Y_MAX./3;% 第4个肋骨y轴坐标
Y5=Y_MAX.*2./3;% 第5个肋骨y轴坐标
Y=[-Y5 -Y4 Y3 Y4 Y5];   % 肋骨的y轴坐标数组
X=[];
Ans=[];
for m=0:0.01:1.3
    Z_center_gravity=Rib_Center_Gravity_Z(A,B,Y,H,Density); % 计算肋骨的重心
    M=Rib_Quality(A,B,Y,H,Density); % 计算肋骨的质量
    Z_center_gravity(end+1)=Keel_Center_Gravity(Y_MAX,H,B,Density); % 添加桅杆的重心
    M(end+1)=Keel_Quality(Y_MAX,H,B,Density);%计算桅杆的质量
    Z_center_gravity(end+1)=0.3075;%添加桅杆的重心
    M(end+1)=0.1058;%添加桅杆的质量
    Z_center_gravity(end+1)=0.04;%添加重物的重心
    M(end+1)=m;% 添加重物的质量
    COM=Boat_Center_Gravity(Z_center_gravity,M)% 计算船体的重心
    X(end+1)=m;% 添加重物的质量
    Ans(end+1)=COM;% 将船体重心加入到数组中
end
title('船体质量变化对重心的影响');% 图表标题
xlabel('质量kg'); % x轴标签
ylabel('重心的z坐标');% y轴标签
hold on % 在同一图表中绘制多个曲线
plot(X,Ans); % 绘制X和Ans的曲线
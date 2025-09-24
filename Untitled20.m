Density=1.6;%面密度
RT=[];
Angle=[];
for H=0.12
    for A=22.5
        for B=3.8
            
            Y_MAX=sqrt(H./B);%y轴的最大值
            
            X_MAX=sqrt(H./A);%x轴的最大值
            
            M=Boat_Quality(A,B,H,Density);%求出船体质量
           
            center_gravity=Boat_COM(A,B,H,Density); %求出重心
           
            Water_density=1000;%水的密度
            waterline=Waterline(A,B,H,Water_density,M);%计算吃水线
            
            for angle=0:1:180
                disp(["角度：",num2str(angle)]);% 显示当前角度
                
                c=Waterline_135(A,B,H,X_MAX,M,angle);%计算135度吃水线
                if c==-5
                    continue;% 如果c等于-5，跳过当前循环
                end
               
                cob=COB(A,B,H,X_MAX,c,angle);%计算浮心
                
                com=[0 0 center_gravity];%小船的重心

                RT(end+1)=Recovery_Torque(com,cob,angle,9.8,M);%计算复原力矩

                Angle(end+1)=angle;% 将当前角度angle添加到Angle数组末尾
                
                
            end
        end
    end
end
title('翻转角度与复原力矩的关系?');
xlabel('翻转角度°');
ylabel('复原力矩N-m');
grid on;
hold on;
plot(Angle,RT);
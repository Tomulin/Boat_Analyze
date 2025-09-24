Density=1.6;%面密度
HEIGHT=[];%高度数组
R_T=[];%复原力矩数组
for H=0:0.005:0.12
    for A=22.5
        for B=3.8
            
            Y_MAX=sqrt(H./B);% y轴的最大值
            
            X_MAX=sqrt(H./A);% x轴的最大值
            
            M=Boat_Quality(A,B,H,Density);
            %求出质量
            center_gravity=Boat_COM(A,B,H,Density);
            %求出重心
            c=Waterline_135(A,B,H,X_MAX,M,135);% 计算吃水线
            if c==-5
                continue;
            end
            
            cob=COB(A,B,H,X_MAX,c,135);%计算浮心
           
            com=[ 0 0 center_gravity];% 船体的重心坐标
            
            RT=Recovery_Torque(com,cob,135,9.8,M);%计算复原力矩
            HEIGHT(end+1)=H; % 将当前高度H添加到HEIGHT数组末尾
            R_T(end+1)=RT; % 将当前复原力矩RT添加到R_T数组末尾
        end
    end
end
title('高与复原力矩的关系图');% 图表标题
xlabel('高m');% x轴标签
ylabel('复原力矩N-m');% y轴标签
hold on % 在同一图表中绘制多个曲线
plot(HEIGHT,R_T);% 绘制高度与复原力矩的关系曲线

boat.A=zeros(1,2000,'double');%函数的A
boat.B=zeros(1,2000,'double');%函数的B
boat.H=zeros(1,2000,'double');%函数Z=H

boat.Boat_quality=zeros(1,2000,'double');%船体质量
boat.waterline=zeros(1,2000,'double');%平 吃水线
boat.Boat_com=zeros(1,2000,'double');%船体重心
boat.Recovery_torque=zeros(1,2000,'double');%复原力矩
boat.Resistance_section=zeros(1,2000,'double');%水下阻力截面面积
boat.Boat_Length=zeros(1,2000,'double');%船长
boat.Boat_Width=zeros(1,2000,'double');%船宽

count=1;
Density=1.6;%密度

for H=0.11:0.01:0.13%将高度从x到y，间隔为z进行遍历
    disp(['working on :h ',num2str(H)]);%显示字符串和高度
    for A=16:0.1:24%将A从x到y，间隔为z进行遍历
        for B=2:0.1:4%将B从x到y，间隔为z进行遍历
            disp(['working on :A ',num2str(A),' B ',num2str(B)]);%显示字符串和A与B
            Y_MAX=sqrt(H./B);%计算y轴的最大值船长
            %对数据进行初步筛选------------------------------------
            if 2*Y_MAX>0.45%长度太长的情况
                continue;
            end 
            if 2*Y_MAX<0.3%长度太短的情况
                continue;
            end
            X_MAX=sqrt(H./A);%船宽
            if 2*X_MAX>0.2%宽度太大的情况删
                continue;
            end
            if 2*X_MAX<0.1%宽度太小的情况删
                continue;
            end
            if(Y_MAX/X_MAX)<1.8%长宽比太小的情况删去
                continue;
            end 
            if(Y_MAX/X_MAX)>2.5%长宽比太大的情况删去
                continue;
            end%船体质量
            
            %数据初步筛选结束------------------------------
            M=Boat_Quality(A,B,H,Density);%船体重心%函数调用跳转1
            center_gravity=Boat_COM(A,B,H,Density);%函数跳转4
            if center_gravity>(H*0.88)%重心太高的情况删
                continue;
            end%平吃水线
            Water_density=1000;
            waterline=Waterline(A,B,H,Water_density,M);
            if(waterline>(H*0.88))%吃水线太高的跳过
                continue;
            end
            if(waterline<(0.5*H))%吃水线太低的跳过
                continue;
            end
            if(waterline<center_gravity)%吃水线低于重心
                continue;
            end%135吃水
            c = Waterline_135(A,B,H,X_MAX,M,135);
            if c==-5%如果没求出结果 135吃水线的c跳过
                continue;
            end
            cob=COB(A,B,H,X_MAX,c,135);%浮心
            com=[0 0 center_gravity];%重心
            RS=Resistance_Section(A,waterline);%水下阻力截面面积
            RT=Recovery_Torque(com,cob,135,9.8,M);%复原力矩
% v_com=2;
%fprintf('%s ',RT);

%v_com=double(v_com);
            RT = sqrt(sum(RT.^2));%取正
            if abs(RT)<0.002 
                boat.A(count)=A;
                boat.B(count)=B;
                boat.H(count)=H;
                boat.Boat_quality(count)=M;%船体质量
                boat.waterline(count)=waterline;%平吃水线
                boat.Boat_com(count)=com(3);%船体重心
                boat.Recovery_torque(count)=RT;%复原力矩
                boat.Resistance_section(count)=RS;%水下阻力截面面积
                boat.Boat_Length(count)=2.*Y_MAX;%船长
                boat.Boat_Width(count)=2.*X_MAX;%船宽
                count=count+1;
                disp(['count ',num2str(count)]);
            end 
        end
    end
end %写入excel

Varname= {'A','B','H','整船质量','平吃水线','整船重心','复原力矩','水下阻力截面面积','船长','船宽'}; 
T = table(boat.A',boat.B',boat.H',boat.Boat_quality',boat.waterline',boat.Boat_com',boat.Recovery_torque',boat.Resistance_section',boat.Boat_Length',boat.Boat_Width','VariableNames',Varname);
writetable(T,'NEWData.xlsx'); 
type 'NEWData.xlsx';
Density=1.6;%���ܶ�
RT=[];
Angle=[];
for H=0.12
    for A=22.5
        for B=3.8
            
            Y_MAX=sqrt(H./B);%y������ֵ
            
            X_MAX=sqrt(H./A);%x������ֵ
            
            M=Boat_Quality(A,B,H,Density);%�����������
           
            center_gravity=Boat_COM(A,B,H,Density); %�������
           
            Water_density=1000;%ˮ���ܶ�
            waterline=Waterline(A,B,H,Water_density,M);%�����ˮ��
            
            for angle=0:1:180
                disp(["�Ƕȣ�",num2str(angle)]);% ��ʾ��ǰ�Ƕ�
                
                c=Waterline_135(A,B,H,X_MAX,M,angle);%����135�ȳ�ˮ��
                if c==-5
                    continue;% ���c����-5��������ǰѭ��
                end
               
                cob=COB(A,B,H,X_MAX,c,angle);%���㸡��
                
                com=[0 0 center_gravity];%С��������

                RT(end+1)=Recovery_Torque(com,cob,angle,9.8,M);%���㸴ԭ����

                Angle(end+1)=angle;% ����ǰ�Ƕ�angle��ӵ�Angle����ĩβ
                
                
            end
        end
    end
end
title('��ת�Ƕ��븴ԭ���صĹ�ϵ?');
xlabel('��ת�Ƕȡ�');
ylabel('��ԭ����N-m');
grid on;
hold on;
plot(Angle,RT);
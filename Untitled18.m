A=22.5;
B=3.8;
H=0.12;
Density=1.6;% �ܶ�
Y_MAX=sqrt(H./B);% y������ֵ
Y3=0;% ��3���߹�y������
Y4=Y_MAX./3;% ��4���߹�y������
Y5=Y_MAX.*2./3;% ��5���߹�y������
Y=[-Y5 -Y4 Y3 Y4 Y5];   % �߹ǵ�y����������
X=[];
Ans=[];
for m=0:0.01:1.3
    Z_center_gravity=Rib_Center_Gravity_Z(A,B,Y,H,Density); % �����߹ǵ�����
    M=Rib_Quality(A,B,Y,H,Density); % �����߹ǵ�����
    Z_center_gravity(end+1)=Keel_Center_Gravity(Y_MAX,H,B,Density); % ���Φ�˵�����
    M(end+1)=Keel_Quality(Y_MAX,H,B,Density);%����Φ�˵�����
    Z_center_gravity(end+1)=0.3075;%���Φ�˵�����
    M(end+1)=0.1058;%���Φ�˵�����
    Z_center_gravity(end+1)=0.04;%������������
    M(end+1)=m;% ������������
    COM=Boat_Center_Gravity(Z_center_gravity,M)% ���㴬�������
    X(end+1)=m;% ������������
    Ans(end+1)=COM;% ���������ļ��뵽������
end
title('���������仯�����ĵ�Ӱ��');% ͼ�����
xlabel('����kg'); % x���ǩ
ylabel('���ĵ�z����');% y���ǩ
hold on % ��ͬһͼ���л��ƶ������
plot(X,Ans); % ����X��Ans������
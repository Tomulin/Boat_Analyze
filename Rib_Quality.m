function Ans=Rib_Quality(A,B,Y,H,Density)%�����߹������ĺ���
X=sqrt((H-B.*Y.^2)./A);%�������X��ֵ
Ans=zeros(1,5,'double');% ʹ����ֵ��ʼ��Ans����
for i=1:5
    f2=@(x,z)Density+x.*0+z.*0;% ��������f2�����в���x��z��������ΪDensity
    Z_min=@(x)A.*x.^2+B.*Y(i).^2; % ��������Z_min�����в���x����ʾ��������
    Ans(i)=integral2(f2,-X(i),X(i),Z_min,H);%����f2��-x(i)��x(i)��x��Χ��Z_min��H��z��Χ�ϵ�˫�ػ��֣����������ֵ��Ans(i)%��ת��Boat_Quality
end
end%��������1Boat_Quality
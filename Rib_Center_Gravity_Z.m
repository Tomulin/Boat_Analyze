function Ans=Rib_Center_Gravity_Z(A,B,Y,Z_UP,Density)% �����߹�������Z���ϵ�λ��
X=sqrt((Z_UP-B.*Y.^2)./A);% �������X��ֵ
M=Rib_Quality(A,B,Y,Z_UP,Density);% ����Rib_Quality��������ÿ���߹ǵ�����%������ת6
Ans=zeros(1,5,'double');% ʹ����ֵ��ʼ��Ans��a����
a=zeros(1,5,'double');
for i=1:5% ѭ��ִ��i=1:5�ĵ���
    Z_min=@(x)A.*x.^2+B.*Y(i).^2;% ��������Z_min�����в���x����ʾ��������
    f1=@(x,z)x.*0+Density.*z;% ��������f1�����в���x��z������x��z�ĳ˻��ĺ�
    a(i)=integral2(f1,-X(i),X(i),Z_min,Z_UP);% ����f1�ڻ��������ڵ�˫�ػ��֡�����������-X(i)��X(i)��ʾx��Χ����Z_min��Z_UP��ʾz��Χ��% �������ֵ��a����ĵ�i��Ԫ��
end
Ans=a./M;% ��������λ�ã���a�����ÿ��Ԫ�س��Զ�Ӧ������M������洢��Ans������
end
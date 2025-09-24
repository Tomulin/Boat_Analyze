function Ans=Waterline_135(A,B,H,X_MAX,M,Angle)%����135�ȳ�ˮ�ߵĸ߶�
K=tan(Angle./180.*pi);%����Ƕȵ�����ֵ
C=[H+K.*X_MAX H-K.*X_MAX];% ����C�ķ�Χ����Ϊ���ַ����ҵĳ�ʼ����
low=C(1); % ���ַ����ҵĵײ�
Accuracy=0.000001;% ����
high=C(2)-Accuracy;% ���ַ����ҵĶ���
Ans=-5;% ��ʼ��AnsΪ-5
while low<=high
    c=(low+high)./2;% ���ַ����ҵ��е�
    syms x
    t=zeros(1,2,'double');
    f=A.*x.^2-x.*K-c==0;% ���� A*x^2 - x*K - c = 0
    T=double(solve(f));% ��ⷽ�̵ĸ�
    for i=1:2
        if isreal(T(i))
            t(i)=T(i);% ��ʵ��������������t��
        end
    end
    X=sort(t);% �Ը���������
    %������1����
    f=@(x,y,z)z.*0+1;X_min=X(2);
    X_max=X_MAX;
    Y_min=@(x,y,z)-sqrt((H-A.*x.^2)./B);
    Y_max=@(x,y,z)sqrt((H-A.*x.^2)./B);
    Z_min=@(x,y,z)A.*x.^2+B.*y.^2;
    Z_max=@(x,y,z)x.*0+H;
    a=integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
    %�����������
    f=@(x,y,z)z.*0+1;
    X_max=X(2);
    X_min=(H-c)./K;
    Y_min=@(x,y,z)sqrt((x.*K+c-A.*x.^2)./B);
    Y_max=@(x,y,z)sqrt((H-A.*x.^2)./B);
    Z_min=@(x,y,z)A.*x.^2+B.*y.^2;
    Z_max=@(x,y,z)x.*0+H;
    a=a+2.*integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
    %������������
    f=@(x,y,z)z.*0+1;
    X_max=X(2);
    X_min=(H-c)./K;
    Y_min=@(x,y,z)-sqrt((x.*K+c-A.*x.^2)./B);
    Y_max=@(x,y,z)sqrt((x.*K+c-A.*x.^2)./B);
    Z_min=@(x,y,z)x.*K+c;
    Z_max=@(x,y,z)x.*0+H;
    a=a+integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
    F=a*1000;% ��������
    if(abs(M-F)<=0.001)
        Ans=c;% �ҵ����㾫��Ҫ��ĸ߶�
    end
    if M>F
        high=c-Accuracy;% �������󣬵�����������Ķ���
    end
    if M<F
        low=c+Accuracy;% ������С��������������ĵײ�
    end
end
if Ans==-5
    low=0;% �������ò��ҵĵײ��Ͷ���
    Accuracy=0.000001;
    high=C(1)-Accuracy;
    while low<=high
        c=(low+high)./2;% ���ַ����ҵ��е�
        syms x
        f=A.*x.^2-x.*K-c==0;% ���� A*x^2 - x*K - c = 0
        T=double(solve(f));% ��ⷽ�̵ĸ�
        X=zeros(1,2,'double');
        for i=1:2
            if isreal(T(i))
                X(i)=T(i);% ��ʵ��������������X��
            end
        end
        X=sort(X);% �Ը���������
        %������1����
        f=@(x,y,z)z.*0+1;
        X_min=X(2);
        X_max=X_MAX;
        Y_min=@(x,y,z)-sqrt((H-A.*x.^2)./B);
        Y_max=@(x,y,z)sqrt((H-A.*x.^2)./B);
        Z_min=@(x,y,z)A.*x.^2+B.*y.^2;
        Z_max=@(x,y,z)x.*0+H;
        t=integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        %������2����
        f=@(x,y,z)z.*0+1;
        X_max=X(2);
        X_min=X(1);
        Y_min=@(x,y,z)sqrt((x.*K+c-A.*x.^2)./B);
        Y_max=@(x,y,z)sqrt((H-A.*x.^2)./B);
        Z_min=@(x,y,z)A.*x.^2+B.*y.^2;
        Z_max=@(x,y,z)x.*0+H;
        t=t+2.*integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        %������3����
        f=@(x,y,z)z.*0+1;
        X_max=X(2);
        X_min=X(1);
        Y_min=@(x,y,z)-sqrt((x.*K+c-A.*x.^2)./B);
        Y_max=@(x,y,z)sqrt((x.*K+c-A.*x.^2)./B);
        Z_min=@(x,y,z)x.*K+c;
        Z_max=@(x,y,z)x.*0+H;
        t=t+integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        %������4����
        f=@(x,y,z)z.*0+1;
        X_min=-X_MAX;
        X_max=X(1);
        Y_min=@(x,y,z)-sqrt((H-A.*x.^2)./B);
        Y_max=@(x,y,z)sqrt((H-A.*x.^2)./B);
        Z_min=@(x,y,z)A.*x.^2+B.*y.^2;
        Z_max=@(x,y,z)x.*0+H;
        t=t+integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        F=t*1000;% ��������
        if(abs(M-F)<=0.1)
            Ans=c;% �ҵ����㾫��Ҫ��ĸ߶�
        end
        if M>F
            high=c-Accuracy;% �������󣬵�����������Ķ���
        end
        if M<F
            low=c+Accuracy;% ������С��������������ĵײ�
        end
    end
end
end

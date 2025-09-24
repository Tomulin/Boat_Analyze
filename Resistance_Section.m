function Ans=Resistance_Section(A,Waterline)%计算水下阻力截面面积
X_MAX=sqrt(Waterline./A);%x的上限
X_MIN=-sqrt(Waterline./A);%x的下限
Z_MIN=@(x)A.*x.^2;%z的下限
f=@(x,z)x.*0+1;
Ans=integral2(f,X_MIN,X_MAX,Z_MIN,Waterline);
end
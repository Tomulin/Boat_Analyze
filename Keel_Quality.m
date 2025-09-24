function Ans=Keel_Quality(Y_MAX,H,B,Density)%龙骨质量
keel_Z=@(y)B.*y.^2;%龙骨在 z 轴方向的下限函数
f2=@(y,z)Density+y.*0+z.*0;%被积函数
Ans=integral2(f2,-Y_MAX,Y_MAX,keel_Z,H);%使用 integral2 对被积函数进行二重积分计算，积分范围是 y 从 -Y_MAX 到 Y_MAX，z 的下限是由 keel_Z 函数给出，H 是龙骨的高度，Ans为龙骨质量%跳转回Boat_Quality
end%返回Boat_Quality 1
function Ans = Recovery_Torque(COM,COB,Angle,g,M)
angle=(Angle-270)./180.*pi;% 将角度Angle转换为弧度并调整为所需的方向
F = [g.*M.*cos(angle) 0 g.*M.*sin(angle)];% 计算力向量F在x、y和z方向上的分量
RT = cross(COB - COM,F);%计算向量(COB - COM)和力向量F的叉乘，得到复原力矩向量RT
Ans = RT(2);
end
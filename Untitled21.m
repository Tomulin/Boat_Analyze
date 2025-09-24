WATERLINE=[];%吃水线数组
QUALITY=[];%重物质量数组
H=0.12;%高度
A=22.5;%函数A的值
B=3.8;%函数B的值
%平吃水线----------------------------------------------------------------------------------------------
Water_density=1000;%水密度
for quality=0:0.01:1.3
    QUALITY(end+1)=quality;% 将当前重物质量quality添加到QUALITY数组末尾
    WATERLINE(end+1)=Waterline(A,B,H,Water_density,0.2294+quality); % 计算当前重物质量quality对应的吃水线，并将其添加到WATERLINE数组末尾
end
title('重物质量与吃水线的关系图');% 图表标题
xlabel('重物质量kg'); % x轴标签
ylabel('吃水线m'); % y轴标签
hold on% 在同一图表中绘制多个曲线
plot(QUALITY,WATERLINE);% 绘制重物质量与吃水线的关系曲线
function  h = circle(x,y,r,totcolr,lw)
% x: x axis
% y: y axis
% r: radius
% totcolr: facecolor
% lw: linewidth
d = r*2;
px = x-r;
py = y-r;
h = rectangle('Position',[px py d d],'Curvature',[1,1],'FaceColor',totcolr,'EdgeColor',[1  1  1],...
        'LineWidth',lw);
daspect([1,1,1])
end


function  f_mapscore(S,varname,tlt, dir_fig)

vec = [      100;       84;       67;       50;       33;       17;        0];
hex = ['#00ff00';'#7bff00';'#ccff00';'#ffff00';'#ffb300';'#ff8000';'#ff0000'];
raw = sscanf(hex','#%2x%2x%2x',[3,size(hex,1)]).' / 255;
N = 100;
%N = size(get(gcf,'colormap'),1) % size of the current colormap
map = interp1(vec,raw,linspace(0,100,N),'pchip');
mapn = nan(101,3);
mapn(1,:) = [1 1 1];
mapn(2:101,:) = map;

colormap(mapn)
figure('units','normalized','outerposition',[0 0 1 1],'Color','White');
set(gca,'xcolor','none','ycolor','none')

title(tlt,'FontSize', 30)
faceColors = makesymbolspec('Polygon', ...
  {varname,[-1 100],'FaceColor',mapn,'EdgeColor', [0.25 0.25 0.25]});
mapshow(S,'SymbolSpec', faceColors);

colormap(map)
c = colorbar;
c.TickLabels = [0 10 20 30 40 50 60 70 80 90 100];
c.FontSize = 16;

print([dir_fig varname],'-dpng','-r200')
end


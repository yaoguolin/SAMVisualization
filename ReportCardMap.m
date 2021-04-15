clear;

dir = 'C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model\';
dir_A = 'C:\Users\gyao\Google Drive\SAM_CMT\Inputs\';
dir_gis = 'C:\Users\gyao\Google Drive\ArcGIS\';
dir_fig = 'C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model\map\';


load([dir 'SAM_Data_Outputs\SAM_Patchplot Scores\patchplot_score_02232021.mat'])
load([dir_A 'basic_FAO_SAM.mat'])
load('SAMscoreoverall.mat')


shapefile = [dir_gis 'world countries\update_SAM2.shp'];
S = shaperead(shapefile);

lenS = length(fieldnames(S));
map_name = fieldnames(S);
map_names = map_name(11:lenS);

var_name = {"a. Overall Scores","b. Environmental Scores","c. Economic Scores","d. Social Scores",...
    "Labor Productivity","Finance Access","Price Volatility","Government Support","Trade Openness","Food Loss",...
    "Water Consumption", "N Surplus","P Surplus","Land Use Change","Greenhouse Gas","Soil Erosion",...
    "Crop Diversity","Food Affordability","Under-nourishment","Rural Poverty","Gender Gap","Land Right"};

map_names = {'Overall','Environmen','Economic','Social','AGDP','A2F','PVOL','AEXP','TROP','FLS','SUSI','Nsur','Psur','LCC','GHG','SER','RSH','RSE','UDN','RPV','GGG','LRS'};




for i = 2:1:22
    close all
    var_name1 = map_names{i};
    f_mapscore(S, var_name1, var_name{i}, dir_fig);
end




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
S = shaperead(shapefile);
figure('units','normalized','outerposition',[0 0 1 1],'Color','White');
set(gca,'xcolor','none','ycolor','none')

title('Social','FontSize', 30)
faceColors = makesymbolspec('Polygon', ...
  {'Social',[-1 100],'FaceColor',mapn,'EdgeColor', [0.25 0.25 0.25]});
mapshow(S,'SymbolSpec', faceColors);

colormap(map)
c = colorbar;
c.TickLabels = [0 10 20 30 40 50 60 70 80 90 100];
c.FontSize = 16;

print([dir_fig 'Economic'],'-dpng','-r200')









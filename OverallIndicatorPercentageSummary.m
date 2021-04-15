
clear;

dir = 'C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model\';
dir_A = 'C:\Users\gyao\Google Drive\SAM_CMT\Inputs\';
dir_fig = 'C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model\Overall\';

load([dir 'SAM_Data_Outputs\SAM_Patchplot Scores\patchplot_score_02232021.mat'])
load([dir_A 'basic_FAO_SAM.mat'])
load([dir,'SAM_country_group.mat'])
load([dir, 'Correlations\Inputs\114CountryGroup.mat'])
load([dir, 'Correlations\Inputs\projectIndexDefinitions.mat']) 

load([dir 'SAM_Data_Outputs\SAM_Indicators\Environment_SAM_12012019.mat'])
load([dir 'SAM_Data_Outputs\SAM_Indicators\Economic_SAM_12012019.mat'])
load([dir 'SAM_Data_Outputs\SAM_Indicators\Social_SAM_12012019.mat'])
load('C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model\SAM_Data\Economics\SAM_population.mat')

env_n = numel(fieldnames(Env));
econ_n = numel(fieldnames(Econ));
soc_n = numel(fieldnames(Social));


dim_n = 3;
var_n = env_n + econ_n + soc_n;

dimlabels = ["Econ.","Env.","Soc."]; 
env_names = transpose(string(fieldnames(Env)));
econ_names = transpose(string(fieldnames(Econ)));
soc_names = transpose(string(fieldnames(Social)));

VarName = fieldnames(AllScoreB);
var_n = length(VarName);

yrstart = 2010; %***
yrend = 2014;   %***
%bchmrk = [25 75]; %***

uniyrstart = find(uniYrs == yrstart);
uniyrend = find(uniYrs == yrend);

AreaH_FAO_sum = squeeze(nansum(AreaH_FAO,2));
AreaH_FAO_mean = nanmean(AreaH_FAO_sum,2);
AreaH_FAO_GT1000 = find(AreaH_FAO_mean>1000);

Co_ID_group0=Co_ID_group_X(1:113);
Co_ID_group = intersect(Co_ID_group0,AreaH_FAO_GT1000);
Co_group_names0 = Co_group_names;
clear Co_group_names;
Co_group_names = FAOSTAT_CoName_FAO(Co_ID_group);

Co_ID_group = intersect(Co_ID_group0,AreaH_FAO_GT1000);



VarScore = nan(218,56,var_n);
for i = 1:1:env_n
    VarScore(:,:,i) = AllScoreB.(env_names{i});
end

for i = 1:1:econ_n
    VarScore(:,:,econ_n + i) = AllScoreB.(econ_names{i});
end

for i = 1:1:soc_n
    VarScore(:,:,env_n + econ_n + i) = AllScoreB.(soc_names{i});
end

VarScore_avg = squeeze(nanmean(VarScore(:,uniyrstart:uniyrend,:),2));
VarScore_colr = nan(size(VarScore_avg));

for i = 1:1:var_n
    VarScore_colr(VarScore_avg(:,i)<= 100/3,i) = 3;
    VarScore_colr(VarScore_avg(:,i)>= 200/3,i)= 1;
    VarScore_colr(VarScore_avg(:,i)> 100/3 & VarScore_avg(:,i)< 200/3,i)= 2;
end

VarScore_colr(isnan(VarScore_avg)) = 4;

var_color_percentage = nan(4,18);

for i = 1:1:18
    for cl = 1:1:4
        var_color_countries{cl,i} = find(VarScore_colr(Co_ID_group,i) == cl);
        var_color_percentage(cl, i) = length(var_color_countries{cl,i})/length(Co_ID_group) * 100;
    end
end

%% country number percentage

f_overall_percentage_horizontal(var_color_percentage)
print(strcat(dir_fig, 'version1-country_percentage_summary'), '-djpeg');

var_color_percentage_nonan = zeros(4,18);
var_color_percentage_nonan(1:3,:) = var_color_percentage(1:3, :)./nansum(var_color_percentage(1:3, :),1) .* 100;
f_overall_percentage_horizontal(var_color_percentage_nonan)
print(strcat(dir_fig, 'version3-country_percentage_summary_nogray'), '-djpeg');

%% population
var_color_percentage_pop = nan(4,18);
pop_avg = nanmean(POP_SAM(Co_ID_group, uniYrs == yrstart),2);
pop_total = nansum(pop_avg);
x = 0;
for i = 1:1:18
    for cl = 1:1:4
        co_idx = var_color_countries{cl,i};
        % x = x + nansum(pop_avg(co_idx))
        var_color_percentage_pop(cl, i) = nansum(pop_avg(co_idx))./pop_total .*100;
    end
end

f_overall_percentage_horizontal(var_color_percentage_pop)
print(strcat(dir_fig, 'version2-population_percentage_summary'), '-djpeg');

var_color_percentage_pop_nonan = zeros(4,18);
var_color_percentage_pop_nonan(1:3,:) = var_color_percentage_pop(1:3, :)./nansum(var_color_percentage_pop(1:3, :),1) .* 100;
f_overall_percentage_horizontal(var_color_percentage_pop_nonan)
print(strcat(dir_fig, 'version3-population_percentage_summary_nogray'), '-djpeg');

%%

c = [0 1 0; 
     1 1 0;
     1 0 0
     0.8 0.8 0.8];
 
var_name = {"Water Consumption", "N Surplus","P Surplus","Land Use Change","Greenhouse Gas","Soil Erosion",...
    "Labor Productivity","Finance Access","Price Volatility","Government Support","Trade Openness","Food Loss",...
    "Crop Diversity","Food Affordability","Under-nourishment","Rural Poverty","Gender Gap","Land Right"};

figure('units','normalized','outerposition',[0 0 0.5 1]);
h1 = axes;

b = barh(transpose(var_color_percentage),'stacked','BarWidth', 1,'EdgeColor', [0.75 0.75 0.75]);
ylim([0.5, 18.5])
xlim([-28,100])
xlabel('Percentage (%)', 'FontSize', 16)
set(h1, 'Ydir', 'reverse')
set(h1,'TickLength',[0 .01])
xticks([0:10:100])
xticklabels({[0:10:100]})
set(h1, 'ytick',[])
set(h1, 'ycolor','none')
set(h1,'XTickLabel',[0 10 20 30 40 50 60 70 80 90 100],'fontsize',16)
%set(h1,'YTickLabel',var_name,'fontsize',16)

 for k=1:4
  set(b(k),'facecolor',c(k,:))
 end

 for i = 1:1:18
    text(-20, i,var_name{i},'FontSize',14);
 end

text(-24,(env_n*4.7/5),'Environmental','FontSize',16,'FontWeight','bold','Rotation',90)
text(-24,(env_n + econ_n*4/5),'Economic','FontSize',16,'FontWeight','bold','Rotation',90)
text(-24,(env_n + econ_n + soc_n*3/5),'Social','FontSize',16,'FontWeight','bold','Rotation',90)













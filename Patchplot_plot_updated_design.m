clear;

dir = 'C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model\';
dir_A = 'C:\Users\gyao\Google Drive\SAM_CMT\Inputs\';
dir_fig = [dir 'NewPatchPlots\03182021\All\'];



load([dir 'SAM_Data_Outputs\SAM_Patchplot Scores\patchplot_score_02232021.mat'])
load([dir_A 'basic_FAO_SAM.mat'])

load([dir 'SAM_Data_Outputs\SAM_Indicators\Environment_SAM_12012019.mat'])
load([dir 'SAM_Data_Outputs\SAM_Indicators\Economic_SAM_12012019.mat'])
load([dir 'SAM_Data_Outputs\SAM_Indicators\Social_SAM_12012019.mat'])

Yrs = 1961:2016;

load([dir,'SAM_country_group.mat'])
load([dir, 'Correlations\Inputs\114CountryGroup.mat'])
load([dir, 'Correlations\Inputs\projectIndexDefinitions.mat']) 

AreaH_FAO_sum = squeeze(nansum(AreaH_FAO,2));
AreaH_FAO_mean = nanmean(AreaH_FAO_sum,2);
AreaH_FAO_GT1000 = find(AreaH_FAO_mean>1000);

Co_ID_group0=Co_ID_group_X(1:113);
Co_ID_group = intersect(Co_ID_group0,AreaH_FAO_GT1000);
Co_group_names0 = Co_group_names;
clear Co_group_names;
Co_group_names = FAOSTAT_CoName_FAO(Co_ID_group);

Co_ID_group = intersect(Co_ID_group0,AreaH_FAO_GT1000);

var_name = {"Water Consumption", "N Surplus","P Surplus","Land Use Change","Greenhouse Gas","Soil Erosion",...
    "Labor Productivity","Finance Access","Price Volatility","Government Support","Trade Openness","Food Loss",...
    "Crop Diversity","Food Affordability","Under-nourishment","Rural Poverty","Gender Gap","Land Right"};

%FAOSTAT_CoName_FAO2 = FAOSTAT_CoName_FAO;
%FAOSTAT_CoName_FAO2(207) = {'USA'};
%FAOSTAT_CoName_FAO(204) = {'UK'};
FAOSTAT_CoName_FAO(51) = {'Cote dIvoire'};
FAOSTAT_CoName_FAO(160) = {'Reunion'};

len = length(Co_ID_group);

for cn = 1:1:218
    close all
    %cn = Co_ID_group(idx);
    f_patchtime(AllScoreB, Env,Econ,Social,Yrs,cn,FAOSTAT_CoName_FAO(cn),var_name, 10)
    print(strcat(dir_fig, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');
end

%Yrs = 1991:2016;
Yrs = 1961:2016;


% Australia
cn = 9;
f_patchtime(AllScoreB, Env,Econ,Social,Yrs,cn,FAOSTAT_CoName_FAO(cn),var_name,10);
print(strcat(dir_fig, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');

% United States
cn = 207;
f_patchtime(AllScoreB, Env,Econ,Social,Yrs,cn,"United States of America",var_name, 10)
print(strcat(dir_fig, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');

% Brazil
cn = 26;
f_patchtime(AllScoreB, Env,Econ,Social,Yrs,cn,FAOSTAT_CoName_FAO(cn),var_name, 10)
print(strcat(dir_fig, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');

% China
cn = 40;
f_patchtime(AllScoreB, Env,Econ,Social,Yrs,cn,FAOSTAT_CoName_FAO(cn),var_name, 10)
print(strcat(dir_fig, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');

% India
cn = 89;
f_patchtime(AllScoreB, Env,Econ,Social,Yrs,cn,FAOSTAT_CoName_FAO(cn),var_name, 10)
print(strcat(dir_fig, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');


%Ukarine
cn = 202;
f_patchtime(AllScoreB, Env,Econ,Social,Yrs,cn,FAOSTAT_CoName_FAO(cn),var_name, 10)
print(strcat(dir_fig, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');


%Ethiopia
cn = 64;
f_patchtime(AllScoreB, Env,Econ,Social,Yrs,cn,FAOSTAT_CoName_FAO(cn),var_name, 10)
print(strcat(dir_fig, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');

% Tajikstan
cn = 188;
f_patchtime(AllScoreB, Env,Econ,Social,Yrs,cn,FAOSTAT_CoName_FAO(cn),var_name, 10)
print(strcat(dir_fig, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');




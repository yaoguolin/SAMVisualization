clear;

dir = 'C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model\';
dir_A = 'C:\Users\gyao\Google Drive\SAM_CMT\Inputs\';
dir_fig_2 = [dir 'ReportCard\12012019\TwoLayer\'];
%dir_fig_3 = [dir 'ReportCard\12012019\ThreeLayer\']
dir_fig_3 = [dir 'ReportCard\12222020\ThreeLayer'];
dir_fig_4 = [dir 'ReportCard\12222020\ThreeLayer\All112\'];


load([dir 'SAM_Data_Outputs\SAM_Patchplot Scores\patchplot_score_02232021.mat'])
load([dir_A 'basic_FAO_SAM.mat'])

load([dir 'SAM_Data_Outputs\SAM_Indicators\Environment_SAM_12012019.mat'])
load([dir 'SAM_Data_Outputs\SAM_Indicators\Economic_SAM_12012019.mat'])
load([dir 'SAM_Data_Outputs\SAM_Indicators\Social_SAM_12012019.mat'])

%% Get the average of each dimension

%Env_D.Wat.GWD = Env_S.GWD;    
%{
Env_D.Wat.SUSI = Env_S.SUSI;
Env_D.Pol.Nsur = Env_S.Nsur;
Env_D.Pol.Psur = Env_S.Psur;
Env_D.LoB.LCC = Env_S.LCC;
Env_D.Clm.GHG = Env_S.GHG;
Env_D.Sol.SER = Env_S.SER;
%}

Env_D.Wat.SUSI = AllScoreB.SUSI;
Env_D.Pol.Nsur = AllScoreB.Nsur;
Env_D.Pol.Psur = AllScoreB.Psur;
Env_D.LoB.LCC = AllScoreB.LCC;
Env_D.Clm.GHG = AllScoreB.GHG;
Env_D.Sol.SER = AllScoreB.SER;

%{
Econ_D.ALP.AGDP = Econ_S.AGDP;
Econ_D.ASP.AEXP = Econ_S.AEXP;
Econ_D.GMA.TROP = Econ_S.TROP;
Econ_D.CRD.A2F = Econ_S.A2F;
Econ_D.RSK.PVOL = Econ_S.PVOL;
%}

Econ_D.ALP.AGDP = AllScoreB.AGDP;
Econ_D.ASP.AEXP = AllScoreB.AEXP;
Econ_D.GMA.TROP = AllScoreB.TROP;
Econ_D.CRD.A2F = AllScoreB.A2F;
Econ_D.RSK.PVOL = AllScoreB.PVOL;
Econ_D.EFC.FLS = AllScoreB.FLS;


%{
Soc_D.RES.RSH = Social_S.RSH;
Soc_D.RES.RSE = Social_S.RSE;
%Soc_D.RES.SSR = Social_S.SSR;
Soc_D.HLT.UND = Social_S.UDN;
%Soc_D.HLT.OBR = Social_S.OBR;
%Soc_D.HLT.POA = Social_S.POA;
Soc_D.PVT.RPV = Social_S.RPV;
Soc_D.REQ.GGG = Social_S.GGG;
Soc_D.REQ.LRS = Social_S.LRS;
%}

Soc_D.RES.RSH = AllScoreB.RSH;
Soc_D.RES.RSE = AllScoreB.RSE;
Soc_D.HLT.UND = AllScoreB.UDN;
Soc_D.PVT.RPV = AllScoreB.RPV;
Soc_D.EQT.GGG = AllScoreB.GGG;
Soc_D.RGT.LRS = AllScoreB.LRS;

[EnvScore,EnvBA] = DimScore_f(Env_D);
[EconScore,EconBA] = DimScore_f(Econ_D);
[SocScore,SocBA] = DimScore_f(Soc_D);

RegScore_tot = nan(218,56,3);

RegScore_tot(:,:,1) = EconScore;
RegScore_tot(:,:,2) = EnvScore;
RegScore_tot(:,:,3) = SocScore;

RegScore = squeeze(nanmean(RegScore_tot,3));

yrstart = 2010; %***
yrend = 2014;   %***
%bchmrk = [25 75]; %***

uniyrstart = find(uniYrs == yrstart);
uniyrend = find(uniYrs == yrend);

%%% Organize data
RegScore_tott = nan(218,56,4);
RegScore_tott(:,:,1:3) = RegScore_tot;
RegScore_tott(:,:,4) = RegScore;

%% Signs for each dimension and overall signs
RegScore_sign = nan(218,4);
for i = 1:1:4
    RegScore_sign(:,i) = pattern_f(RegScore_tott(:,:,i),yrstart,yrend);
end

env_n = numel(fieldnames(Env));
econ_n = numel(fieldnames(Econ));
soc_n = numel(fieldnames(Social));


dim_n = 3;
var_n = env_n + econ_n + soc_n;

dimlabels = ["Econ.","Env.","Soc."]; 
env_names = transpose(string(fieldnames(Env)));
econ_names = transpose(string(fieldnames(Econ)));
soc_names = transpose(string(fieldnames(Social)));
varlabels = [env_names, econ_names, soc_names];

%% Get the benchmark and colorcode for each dimension
% 1 = green 2 = yellow 3 = red
% get the average of past 5 yrs
RegScore_avg = nan(218,4);
RegScore_avg = squeeze(nanmean(RegScore_tott(:,uniyrstart:uniyrend,:),2));

RegScore_sign(isnan(RegScore_avg)) = nan;

RegScore_colr = nan(218,4);
for i = 1:1:4
    RegScore_colr(RegScore_avg(:,i)<= 100/3,i) = 3;
    RegScore_colr(RegScore_avg(:,i)>= 200/3,i)= 1;
    RegScore_colr(RegScore_avg(:,i)> 100/3 & RegScore_avg(:,i)< 200/3,i)= 2;
end

RegScore_colr(isnan(RegScore_avg)) = 4;

% 


FAOSTAT_CoName_FAO2 = FAOSTAT_CoName_FAO;
FAOSTAT_CoName_FAO2(207) = {'USA'};
FAOSTAT_CoName_FAO2(204) = {'UK'};
FAOSTAT_CoName_FAO2(51) = {'Cote dIvoire'};
FAOSTAT_CoName_FAO2(160) = {'Reunion'};

for cn = 160:1:160
    reportcard_f(cn,RegScore_colr,RegScore_sign)
    title(FAOSTAT_CoName_FAO2(cn),'fontSize',28)
    print(strcat(dir_fig_2, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg');
end
 
% 40 China
reportcard_gradient_f(40,RegScore_avg,RegScore_sign)
title(FAOSTAT_CoName_FAO(40),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)

reportcard_gradient_f(207,RegScore_avg,RegScore_sign)
title("United States",'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)



% 158 Russia
reportcard_gradient_f(158,RegScore_avg,RegScore_sign)
title('Russia','Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)


% 34 Canada
reportcard_gradient_f(34,RegScore__avg,RegScore_sign)
title(FAOSTAT_CoName_FAO(34),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)


%26 Brazil
reportcard_f(26,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(26),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)


%9 Australia
reportcard_f(9,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(9),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)


%89 India
reportcard_f(89,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(89),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)


%123 Mexico
reportcard_f(123,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(123),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)


%204 UK
reportcard_f(204,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(204),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)


%114 Malawi
reportcard_f(114,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(114),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)


%69 France
reportcard_f(69,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(69),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)


%97 Japan
reportcard_f(97,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(97),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)

%201 Uganda
reportcard_f(201,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(201),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)

%217 Zambia
reportcard_f(217,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(217),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)


%7 Argentina
reportcard_f(7,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(7),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)

%136 New Zealand
reportcard_f(136,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(136),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)

%139 Nigeria
reportcard_f(139,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(139),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)


%1 Afghanistan
reportcard_f(1,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(1),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)


%115 Malaysia
reportcard_f(115,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(115),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)

%99 {'Kazakhstan'}
reportcard_f(99,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(99),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)

% 168 'Saudi Arabia'}
reportcard_f(168,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(168),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)

% 3 Algeria
reportcard_f(3,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(3),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)

% 109 Libya
reportcard_f(109,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(109),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)

% 59 Egypt
reportcard_f(59,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(59),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)

% 182 Sudan
reportcard_f(182,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(182),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)

% 180 Spain
reportcard_f(180,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(180),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)

% 23 Bolivia
reportcard_f(23,RegScore_colr,RegScore_sign)
title('Bolivia','Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)

%91 {'Iran'}
reportcard_f(91,RegScore_colr,RegScore_sign)
title('Iran','Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)

%90 {'Indonesia'}
reportcard_f(90,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(90),'Units', 'normalized', 'Position', [0.5, 0.95, 0],'fontSize',48)

%% Three-layer report cards
% dimensional color

VarName = fieldnames(AllScoreB);
VarScore = nan(218,56,var_n);


for i = 1:1:econ_n
    VarScore(:,:,i) = AllScoreB.(econ_names{i});
    VarName2{1,i} = econ_names{i};
end

for i = 1:1:env_n
    VarScore(:,:,econ_n + i) = AllScoreB.(env_names{i});
    VarName2{1,econ_n + i} = env_names{i};
end

for i = 1:1:soc_n
    VarScore(:,:,econ_n + env_n + i) = AllScoreB.(soc_names{i});
    VarName2{1,econ_n + env_n + i} = soc_names{i};
end

VarScore_avg = squeeze(nanmean(VarScore(:,uniyrstart:uniyrend,:),2));

VarScore_colr = nan(size(VarScore_avg));

for i = 1:1:var_n
    VarScore_colr(VarScore_avg(:,i)<= 100/3,i) = 3;
    VarScore_colr(VarScore_avg(:,i)>= 200/3,i)= 1;
    VarScore_colr(VarScore_avg(:,i)> 100/3 & VarScore_avg(:,i)< 200/3,i)= 2;
end

VarScore_colr(isnan(VarScore_avg)) = 4;

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

VarName = {"Water Consumption", "N Surplus","P Surplus","Land Use Change","Greenhouse Gas","Soil Erosion",...
    "Labor Productivity","Finance Access","Price Volatility","Government Support","Trade Openness","Food Loss",...
    "Crop Diversity","Food Affordability","Under-nourishment","Rural Poverty","Gender Gap","Land Right"};

%FAOSTAT_CoName_FAO2 = FAOSTAT_CoName_FAO;
%FAOSTAT_CoName_FAO2(207) = {'USA'};
%FAOSTAT_CoName_FAO(204) = {'UK'};
FAOSTAT_CoName_FAO(51) = {'Cote dIvoire'};
FAOSTAT_CoName_FAO(160) = {'Reunion'};

len = length(Co_ID_group);

RegScore_avg2 = RegScore_avg;
RegScore_avg2(isnan(RegScore_avg2)) = 101;
RegScore_avg2(RegScore_avg2 == 0) = 1;

for cn = 1:1:218
    close all
    %cn = Co_ID_group(idx);
    f_reportcard_threeLayersLong_gradient(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_avg2,dimlabels,RegScore_sign,VarScore_colr,VarName)
    title(string(FAOSTAT_CoName_FAO(cn)),'FontSize',24)
    print(strcat(dir_fig_4, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');
end

cn = 9;
f_reportcard_threeLayersLong_sample(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_avg,dimlabels,RegScore_sign,VarScore_colr,VarName)
    

% Australia
cn = 9;
f_reportcard_threeLayersLong_gradient(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_avg,dimlabels,RegScore_sign,VarScore_colr,VarName)
title(string(FAOSTAT_CoName_FAO2(cn)),'FontSize',24)
print(strcat(dir_fig_3, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg');



%USA
cn = 207;
f_reportcard_threeLayersLong_gradient(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_avg,dimlabels,RegScore_sign,VarScore_colr,VarName)
title('United States of America','FontSize',24)
print(strcat(dir_fig_3, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg');


%Brazil
cn = 26;
f_reportcard_threeLayersLong_gradient(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_avg,dimlabels,RegScore_sign,VarScore_colr,VarName)
title(string(FAOSTAT_CoName_FAO2(cn)),'FontSize',24)
print(strcat(dir_fig_3, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg');


%China
cn = 40;
f_reportcard_threeLayersLong_gradient(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_avg,dimlabels,RegScore_sign,VarScore_colr,VarName)
title(string(FAOSTAT_CoName_FAO2(cn)),'FontSize',24)
print(strcat(dir_fig_3, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg');


%India
cn = 89;
f_reportcard_threeLayersLong_gradient(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_avg,dimlabels,RegScore_sign,VarScore_colr,VarName)
title(string(FAOSTAT_CoName_FAO2(cn)),'FontSize',24)
print(strcat(dir_fig_3, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg')

%Ukarine
cn = 202;
f_reportcard_threeLayersLong_gradient(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_avg,dimlabels,RegScore_sign,VarScore_colr,VarName)
title(string(FAOSTAT_CoName_FAO2(cn)),'FontSize',24)
print(strcat(dir_fig_3, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg')

%Ethiopia
cn = 64;
f_reportcard_threeLayersLong_gradient(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_avg,dimlabels,RegScore_sign,VarScore_colr,VarName)
title(string(FAOSTAT_CoName_FAO2(cn)),'FontSize',24)
print(strcat(dir_fig_3, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg')

% Tajikstan
cn = 188;
f_reportcard_threeLayersLong_gradient(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_avg,dimlabels,RegScore_sign,VarScore_colr,VarName)
title(string(FAOSTAT_CoName_FAO2(cn)),'FontSize',24)
print(strcat(dir_fig_3, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg')












%% Three Layer five color
%Env_D.Wat.GWD = Env_S.GWD;    
%{
Env_D.Wat.SUSI = Env_S.SUSI;
Env_D.Pol.Nsur = Env_S.Nsur;
Env_D.Pol.Psur = Env_S.Psur;
Env_D.LoB.LCC = Env_S.LCC;
Env_D.Clm.GHG = Env_S.GHG;
Env_D.Sol.SER = Env_S.SER;
%}

Env_D2.Wat.SUSI = AllScore.SUSI;
Env_D2.Pol.Nsur = AllScore.Nsur;
Env_D2.Pol.Psur = AllScore.Psur;
Env_D2.LoB.LCC = AllScore.LCC;
Env_D2.Clm.GHG = AllScore.GHG;
Env_D2.Sol.SER = AllScore.SER;

%{
Econ_D.ALP.AGDP = Econ_S.AGDP;
Econ_D.ASP.AEXP = Econ_S.AEXP;
Econ_D.GMA.TROP = Econ_S.TROP;
Econ_D.CRD.A2F = Econ_S.A2F;
Econ_D.RSK.PVOL = Econ_S.PVOL;
%}

Econ_D2.ALP.AGDP = AllScore.AGDP;
Econ_D2.ASP.AEXP = AllScore.AEXP;
Econ_D2.GMA.TROP = AllScore.TROP;
Econ_D2.CRD.A2F = AllScore.A2F;
Econ_D2.RSK.PVOL = AllScore.PVOL;

%{
Soc_D.RES.RSH = Social_S.RSH;
Soc_D.RES.RSE = Social_S.RSE;
%Soc_D.RES.SSR = Social_S.SSR;
Soc_D.HLT.UND = Social_S.UDN;
%Soc_D.HLT.OBR = Social_S.OBR;
%Soc_D.HLT.POA = Social_S.POA;
Soc_D.PVT.RPV = Social_S.RPV;
Soc_D.REQ.GGG = Social_S.GGG;
Soc_D.REQ.LRS = Social_S.LRS;
%}

Soc_D2.RES.RSH = AllScore.RSH;
Soc_D2.RES.RSE = AllScore.RSE;
Soc_D2.HLT.UND = AllScore.UDN;
Soc_D2.PVT.RPV = AllScore.RPV;
Soc_D2.REQ.GGG = AllScore.GGG;
Soc_D2.REQ.LRS = AllScore.LRS;

[EnvScore2,EnvBA2] = DimScore_f(Env_D2);
[EconScore2,EconBA2] = DimScore_f(Econ_D2);
[SocScore2,SocBA2] = DimScore_f(Soc_D2);

RegScore_tot2 = nan(218,56,3);

RegScore_tot2(:,:,1) = EconScore2;
RegScore_tot2(:,:,2) = EnvScore2;
RegScore_tot2(:,:,3) = SocScore2;

RegScore2 = squeeze(nanmean(RegScore_tot2,3));

yrstart = 2010; %***
yrend = 2014;   %***
%bchmrk = [25 75]; %***

uniyrstart = find(uniYrs == yrstart);
uniyrend = find(uniYrs == yrend);

%%% Organize data
RegScore_tott2 = nan(218,56,4);
RegScore_tott2(:,:,1:3) = RegScore_tot2;
RegScore_tott2(:,:,4) = RegScore2;

% dimensional color
RegScore_avg2 = nan(218,6);
RegScore_avg2 = squeeze(nanmean(RegScore_tott2(:,uniyrstart:uniyrend,:),2));

RegScore_sign2(isnan(RegScore_avg2)) = nan;

RegScore_colr2 = nan(218,4);
for i = 1:1:4
    RegScore_colr2(RegScore_avg2(:,i)> 100,i)= 1;
    RegScore_colr2(RegScore_avg2(:,i)>= 200/3 & RegScore_avg2(:,i)<= 100,i)= 2;
    RegScore_colr2(RegScore_avg2(:,i)>= 100/3 & RegScore_avg2(:,i)< 200/3,i)= 3;
    RegScore_colr2(RegScore_avg2(:,i)< 100/3 & RegScore_avg2(:,i)>= 0,i) = 4;
    RegScore_colr2(RegScore_avg2(:,i)< 0,i) = 5;
end

RegScore_colr2(isnan(RegScore_avg2)) = 6;

VarScore2 = nan(218,56,var_n);

for i = 1:1:econ_n
    VarScore2(:,:,i) = AllScore.(econ_names{i});
    VarName2{1,i} = econ_names{i};
end

for i = 1:1:env_n
    VarScore2(:,:,econ_n + i) = AllScore.(env_names{i});
    VarName2{1,econ_n + i} = env_names{i};
end

for i = 1:1:soc_n
    VarScore2(:,:,econ_n + env_n + i) = AllScore.(soc_names{i});
    VarName2{1,econ_n + env_n + i} = soc_names{i};
end

VarScore_avg2 = squeeze(nanmean(VarScore2(:,uniyrstart:uniyrend,:),2));

VarScore_colr2 = nan(size(VarScore_avg2));

for i = 1:1:var_n
    VarScore_colr2(VarScore_avg2(:,i)> 100,i)= 1;
    VarScore_colr2(VarScore_avg2(:,i)>= 200/3 & VarScore_avg2(:,i)<= 100,i)= 2;
    VarScore_colr2(VarScore_avg2(:,i)>= 100/3 & VarScore_avg2(:,i)< 200/3,i)= 3;
    VarScore_colr2(VarScore_avg2(:,i)< 100/3 & VarScore_avg2(:,i)>= 0,i) = 4;
    VarScore_colr2(VarScore_avg2(:,i)< 0,i) = 5;
end

VarScore_colr2(isnan(VarScore_avg2)) = 6;


for cn = 160:1:160
    f_reportcard_threeLayers(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_colr,dimlabels,RegScore_sign,VarScore_colr,VarName)
    title(FAOSTAT_CoName_FAO2(cn),'fontSize',26)
    print(strcat(dir_fig_3, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg');
end
 
%Australia
cn = 9;
f_reportcard_threeLayers_5color(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_colr2,dimlabels,VarScore_colr2,VarName,FAOSTAT_CoName_FAO2(cn))
print(strcat(dir_fig_3, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg');


%USA
cn = 207;
f_reportcard_threeLayers_5color(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_colr2,dimlabels,VarScore_colr2,VarName,"United States")
print(strcat(dir_fig_3, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg');


%Brazil
cn = 26;
f_reportcard_threeLayers_5color(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_colr2,dimlabels,VarScore_colr2,VarName,FAOSTAT_CoName_FAO2(cn))
print(strcat(dir_fig_3, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg');


%China
cn = 40;
f_reportcard_threeLayers_5color(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_colr2,dimlabels,VarScore_colr2,VarName,FAOSTAT_CoName_FAO2(cn))
print(strcat(dir_fig_3, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg');


%India
cn = 89;
f_reportcard_threeLayers_5color(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_colr2,dimlabels,VarScore_colr2,VarName,FAOSTAT_CoName_FAO2(cn))
print(strcat(dir_fig_3, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg');

%Ukarine
cn = 202;
f_reportcard_threeLayers_5color(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_colr2,dimlabels,VarScore_colr2,VarName,FAOSTAT_CoName_FAO2(cn))
print(strcat(dir_fig_3, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg');

%Ethiopia
cn = 64;
f_reportcard_threeLayers_5color(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_colr2,dimlabels,VarScore_colr2,VarName,FAOSTAT_CoName_FAO2(cn))
print(strcat(dir_fig_3, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg');

% Tajikstan
cn = 188;
f_reportcard_threeLayers_5color(cn,env_n,econ_n,soc_n,dim_n,var_n,RegScore_colr2,dimlabels,VarScore_colr2,VarName,FAOSTAT_CoName_FAO2(cn))
print(strcat(dir_fig_3, string(FAOSTAT_CoName_FAO2(cn))), '-djpeg');


%% Percentage of countries
%%% dimensional
% 1st dimension: income countries 
% 2nd dimension: econ, env, social, total

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


% Guolin: for country income groups
%%% high-income groups
high_inc = find(IncGroups == 'High income');
high_inc0 = intersect(high_inc,Co_ID_group);
%%% upper middle income
upmid_inc = find(IncGroups == 'Upper middle income');
upmid_inc0 = intersect(upmid_inc,Co_ID_group);
%%% lower middle income
lowmid_inc = find(IncGroups == 'Lower middle income');
lowmid_inc0 = intersect(lowmid_inc,Co_ID_group);
%%% low income
low_inc = find(IncGroups == 'Low income');
low_inc0 = intersect(low_inc,Co_ID_group);

YrSet=1:56; % if all years, corr result is nan, Since 1991 (33-55: 1993-2015)
%YrSet=48:54; % if all years, corr result is nan, Since 2008
% change Co_ID_group to the corresponding income group
%Co_ID_group = high_inc0;
%Co_ID_group = upmid_inc0;
%Co_ID_group = lowmid_inc0;
Co_ID_group = low_inc0;


coN=length(Co_ID_group);
yrN=length(YrSet);

for i = 1:1:4
    green_portion_high{:,i} = find(RegScore_colr(high_inc0,i) == 1);
    yellow_portion_high{:,i} = find(RegScore_colr(high_inc0,i) == 2);
    red_portion_high{:,i} = find(RegScore_colr(high_inc0,i) == 3);
end

for i = 1:1:4
    green_portion_upmid{:,i} = find(RegScore_colr(upmid_inc0,i) == 1);
    yellow_portion_upmid{:,i} = find(RegScore_colr(upmid_inc0,i) == 2);
    red_portion_upmid{:,i} = find(RegScore_colr(upmid_inc0,i) == 3);
end

for i = 1:1:4
    green_portion_lowmid{:,i} = find(RegScore_colr(lowmid_inc0,i) == 1);
    yellow_portion_lowmid{:,i} = find(RegScore_colr(lowmid_inc0,i) == 2);
    red_portion_lowmid{:,i} = find(RegScore_colr(lowmid_inc0,i) == 3);
end

for i = 1:1:4
    green_portion_low{:,i} = find(RegScore_colr(low_inc0,i) == 1);
    yellow_portion_low{:,i} = find(RegScore_colr(low_inc0,i) == 2);
    red_portion_low{:,i} = find(RegScore_colr(low_inc0,i) == 3);
end
% first diemsnion = income groups
% second dimension = econ, env, social, total

dimen_total_share = nan(4,3,4);
% first dimension = income groups
% second diemsnions = green yellow red
% third dimenion = econ, env, social, total

%% 4: high-income, 3: upper middle income, 2: lower-middle-income, 1: low-income countries
green_share = nan(4,4);
yellow_share = nan(4,4);
red_share = nan(4,4);
for i = 1:1:4
	green_share(4,i) = length(green_portion_high{1,i})/length(high_inc0);
    yellow_share(4,i) = length(yellow_portion_high{1,i})/length(high_inc0);
    red_share(4,i) = length(red_portion_high{1,i})/length(high_inc0);    
end

red_share(4,1) = 1- green_share(4,1) - yellow_share(4,1);

%%% the order of income levels here
dimen_total_share(4,3,:) = green_share(4,:);
dimen_total_share(4,2,:) = yellow_share(4,:);
dimen_total_share(4,1,:) = red_share(4,:);


for i = 1:1:4
	green_share(3,i) = length(green_portion_upmid{1,i})/length(upmid_inc0);
    yellow_share(3,i) = length(yellow_portion_upmid{1,i})/length(upmid_inc0);
    red_share(3,i) = length(red_portion_upmid{1,i})/length(upmid_inc0);    
end
red_share(3,1) = 1- green_share(3,1) - yellow_share(3,1);
dimen_total_share(3,3,:) = green_share(3,:);
dimen_total_share(3,2,:) = yellow_share(3,:);
dimen_total_share(3,1,:) = red_share(3,:);

for i = 1:1:4
	green_share(2,i) = length(green_portion_lowmid{1,i})/length(lowmid_inc0);
    yellow_share(2,i) = length(yellow_portion_lowmid{1,i})/length(lowmid_inc0);
    red_share(2,i) = length(red_portion_lowmid{1,i})/length(lowmid_inc0);    
end

dimen_total_share(2,3,:) = green_share(2,:);
dimen_total_share(2,2,:) = yellow_share(2,:);
dimen_total_share(2,1,:) = red_share(2,:);

for i = 1:1:4
	green_share(1,i) = length(green_portion_low{1,i})/length(low_inc0);
    yellow_share(1,i) = length(yellow_portion_low{1,i})/length(low_inc0);
    red_share(1,i) = length(red_portion_low{1,i})/length(low_inc0);    
end

dimen_total_share(1,3,:) = green_share(1,:);
dimen_total_share(1,2,:) = yellow_share(1,:);
dimen_total_share(1,1,:) = red_share(1,:);

figure('units','normalized','outerposition',[0 0 1 1]);
[ha, pos] = tight_subplot(2,2,[0.1 0.05],[.15 .05],[.05 .01]); 
x = transpose(1:4);

c = ['r' 'y' 'g']
 axes(ha(1))
 bb_1 = bar(x,dimen_total_share(:,:,4),'stacked','EdgeColor', 'None');
title('a. Overall','fontSize',20);
%xticklabels(['High income', 'Upper Middle Income', 'Lower Middle Income','Low Income']);
set(gca,'XTickLabel',{'Low', 'Lower Middle', 'Upper Middle','High'},'fontSize',14,'fontWeight','bold');
%xlabel('Income Groups','fontSize',14,'fontWeight','bold');


  axes(ha(2))
 bb_3 = bar(dimen_total_share(:,:,2),'stacked','EdgeColor', 'None');
title('b. Environmental','fontSize',20);
set(gca,'XTickLabel',{'Low', 'Lower Middle', 'Upper Middle','High'},'fontSize',14,'fontWeight','bold');
%xlabel('Income Groups','fontSize',14,'fontWeight','bold');
%set(gca,'XTickLabel',{'Low', 'Lower Middle', 'Upper Middle','High'},'fontSize',14,'fontWeight','bold');
%xlabel('Income Groups','fontSize',14,'fontWeight','bold');

 axes(ha(3))
 bb_2 = bar(dimen_total_share(:,:,1),'stacked','EdgeColor', 'None');
title('c. Economic','fontSize',20);
set(gca,'XTickLabel',{'Low', 'Lower Middle', 'Upper Middle','High'},'fontSize',14,'fontWeight','bold');
%xlabel('Income Groups','fontSize',14,'fontWeight','bold');

  axes(ha(4))
 bb_4 = bar(dimen_total_share(:,:,3),'stacked','EdgeColor', 'None');
title('d. Social','fontSize',20);
set(gca,'XTickLabel',{'Low', 'Lower Middle', 'Upper Middle','High'},'fontSize',14,'fontWeight','bold');
%xlabel('Income Groups','fontSize',14,'fontWeight','bold');


 for k=1:3
  set(bb_1(k),'facecolor',c(k))
  set(bb_2(k),'facecolor',c(k))
  set(bb_3(k),'facecolor',c(k))
  set(bb_4(k),'facecolor',c(k))
 end

dir_fig_inc = 'C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model\Aggregation\';
print([dir_fig_inc, 'Income aggregation'], '-djpeg');

%% Variable color
% first diemsnion = income groups
% second diemsnions = green yellow red grey
% third dimenion = 17 indicators

VarName = {"Water Consumption", "N Surplus","P Surplus","Land Use Change","Greenhouse Gas","Soil Erosion",...
    "Labor Productivity","Finance Access","Price Volatility","Government Support","Trade Openness","Food Loss",...
    "Crop Diversity","Food Affordability","Under-nourishment","Rural Poverty","Gender Gap","Land Right"};

for i = 1:1:18
    for cl = 1:1:3
        var_color_countries{4,4-cl,i} = find(VarScore_colr(high_inc0,i) == cl);
        var_color_countries{3,4-cl,i} = find(VarScore_colr(upmid_inc0,i) == cl);  
        var_color_countries{2,4-cl,i} = find(VarScore_colr(lowmid_inc0,i) == cl);  
        var_color_countries{1,4-cl,i} = find(VarScore_colr(low_inc0,i) == cl);  
    end
end

for i = 1:1:18
    for cl = 4:1:4
        var_color_countries{4,cl,i} = find(VarScore_colr(high_inc0,i) == cl);
        var_color_countries{3,cl,i} = find(VarScore_colr(upmid_inc0,i) == cl);  
        var_color_countries{2,cl,i} = find(VarScore_colr(lowmid_inc0,i) == cl);  
        var_color_countries{1,cl,i} = find(VarScore_colr(low_inc0,i) == cl);  
    end
end

%%% calculate percentage
var_color_percentage = nan(4,4,18);

% first diemsnion = income groups
% second diemsnions = green yellow red grey
% third dimenion = 18 indicators

for i = 1:1:18
    for cl = 1:1:4
        var_color_percentage(4,cl,i) = length(var_color_countries{4,cl,i})/length(high_inc0);
        var_color_percentage(3,cl,i) = length(var_color_countries{3,cl,i})/length(upmid_inc0);  
        var_color_percentage(2,cl,i) = length(var_color_countries{2,cl,i})/length(lowmid_inc0);  
        var_color_percentage(1,cl,i) = length(var_color_countries{1,cl,i})/length(low_inc0);  
    end
end



figure('units','normalized','outerposition',[0 0 1 1]);
[ha, pos] = tight_subplot(3,6,[0.1 0.05],[.15 .05],[.05 .01]); 
x = transpose(1:4);

c = [
    1 0 0
    1 1 0 
    0 1 0
    0.8 0.8 0.8];
 
for i = 1:1:6
 axes(ha(i))
 bb_n(i,:) = bar(x,var_color_percentage(:,:,6+i),'stacked','EdgeColor', 'None');
title(VarName{i},'fontSize',16);
%xticklabels(['High income', 'Upper Middle Income', 'Lower Middle Income','Low Income']);
set(gca,'XTickLabel',{'Low', 'LMid', 'UMid','High'});
xlabel('Income Groups','fontSize',12);

     for k=1:4
      set(bb_n(i,k),'facecolor',c(k,:))
     end
end

for i = 7:1:12
 axes(ha(i))
 bb_n(i,:) = bar(x,var_color_percentage(:,:,i-6),'stacked','EdgeColor', 'None');
title(VarName{i},'fontSize',16);
%xticklabels(['High income', 'Upper Middle Income', 'Lower Middle Income','Low Income']);
set(gca,'XTickLabel',{'Low', 'LMid', 'UMid','High'});
xlabel('Income Groups','fontSize',12);

     for k=1:4
      set(bb_n(i,k),'facecolor',c(k,:))
     end
end

for i = 13:1:18
 axes(ha(i))
 bb_n(i,:) = bar(x,var_color_percentage(:,:,i),'stacked','EdgeColor', 'None');
title(VarName{i},'fontSize',16);
%xticklabels(['High income', 'Upper Middle Income', 'Lower Middle Income','Low Income']);
set(gca,'XTickLabel',{'Low', 'LMid', 'UMid','High'});
xlabel('Income Groups','fontSize',12);

     for k=1:4
      set(bb_n(i,k),'facecolor',c(k,:))
     end
end

print([dir_fig_inc, 'Income aggregation-indicator3'], '-djpeg');


%{
axes(ha(6))
set(ha(6), 'visible','off')

for i = 7:1:18
 axes(ha(i))
 bb_n(i-1,:) = bar(x,var_color_percentage(:,:,i-1),'stacked','EdgeColor', 'None');
title(VarName2(i-1),'fontSize',16);
%xticklabels(['High income', 'Upper Middle Income', 'Lower Middle Income','Low Income']);
set(gca,'XTickLabel',{'Low', 'LMid', 'UMid','High'});
xlabel('Income Groups','fontSize',12);

     for k=1:4
      set(bb_n(i-1,k),'facecolor',c(k,:))
     end
end
%}
%% Region aggregation


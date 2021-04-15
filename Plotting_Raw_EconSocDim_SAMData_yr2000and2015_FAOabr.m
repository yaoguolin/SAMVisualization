clear; clc;
%%% Initialization (e.g. directory)
global DIR 
global DIR_s
global FigureRes ; FigureRes='-r300'
global FName_CropNameList;


DIR='C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model\'
DIR_s='\'

load([DIR 'SAM_Data' DIR_s 'NDatabase_Zhang' DIR_s 'dataN_partA1_fullWorkSpace.mat'])  %%%load Nitrogen database 

%Update input data from Matt. The trade info applied the conversion ratio
%for major products of crops e.g. flours.

%load([DIR 'SAM_Data' DIR_s 'TradeMatrix' DIR_s 'TradeNetImportMatrices_17-Nov-2017.mat'])  %%%load trade matrix data (netImTrdLand, netImTrdNCont,netImTrdNSur,netImTrdNSurNeed,netImTrdPCont,netImTrdPSur,netImTrdPSurNeed,netImTrdQnt,netImTrdVal)
load([DIR 'basic_FAO_SAM.mat'])
%load('C:\Users\svishwakarma\Documents\Research_Work\NitrogenBudgetData\FAOSTAT_CoABR_ISO.mat')
load([DIR 'EPI_Regions.mat']) 
load([DIR 'GDP_per_capita_2010dollar.mat']) 

load([DIR 'SAM_Data_Outputs' DIR_s 'SAM_Indicators' DIR_s 'Environment_SAM_12012019.mat'])
load([DIR 'SAM_Data_Outputs' DIR_s 'SAM_Indicators' DIR_s 'Economic_SAM_12012019.mat'])
load([DIR 'SAM_Data_Outputs' DIR_s 'SAM_Indicators' DIR_s 'Social_SAM_12012019.mat'])

%AreaH_FAO(:,170,55:56) = [AreaH_FAO(:,170,54) AreaH_FAO(:,170,54)]; %km2
%AreaH_c = reshape(nansum(AreaH_FAO(:,1:167,:),2),218,56);
%clear areaAg; areaAg = AgriArea_FAOSTAT.*1000; % 1000 ha to ha
fig_caption={'a','b'};
Yr=1961:2016;


%% AGDP

%minV = floor(nanmin(nanmin(GDP_P_2010_SAM(:,[40 55]))));
minV = 100;

%maxV = ceil(nanmax(nanmax(GDP_P_2010_SAM(:,[40 55]))));
maxV = 108000;
xlb = 'GDP per Capita (2010US$)';

ylb = 'Ag GDP per Ag Worker (2011US$PPP)';

dir_f = [DIR 'SuppFig' DIR_s 'Econ' DIR_s];
%minVy = floor(nanmin(nanmin(Econ.AGDP(:,[40 55]))));
minVy = 50;
%maxVy = ceil(nanmax(nanmax(Econ.AGDP(:,[40 55]))));
maxVy = 1000000;

f_IndicatorDis_SUPPLLog_1yr(Econ.AGDP,GDP_P_2010_SAM,'AGDP',460,7946,minV,maxV,minVy,maxVy,ylb, xlb,[40], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,1)
f_IndicatorDis_SUPPLLog_1yr(Econ.AGDP,GDP_P_2010_SAM,'AGDP',460,7946,minV,maxV,minVy,maxVy,ylb, xlb,[55], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,2)

%f_IndicatorDis_SUPPL_yr(Econ.AGDP,GDP_P_2010_SAM,'AGDP',460,7946,minV,maxV,minVy,maxVy,ylb, xlb,[40 55],dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName)

%% AEXP
ylb = 'Ag Expenditure per Ag Worker (2011US$PPP)';

dir_f = [DIR 'SuppFig' DIR_s 'Econ' DIR_s];
%minVy = floor(nanmin(nanmin(Econ.AEXP(:,[40 55]))));
minVy = 0.01;
%maxVy = ceil(nanmax(nanmax(Econ.AEXP(:,[40 55]))));
maxVy = 100000;

%f_IndicatorDis_SUPPL_yr(Econ.AEXP,GDP_P_2010_SAM,'AEXP',25,2405,minV,maxV,minVy,maxVy,ylb, xlb,[40 55],dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName)

f_IndicatorDis_SUPPLLog_1yr(Econ.AEXP,GDP_P_2010_SAM,'AEXP',25,2405,minV,maxV,minVy,maxVy,ylb, xlb,[40], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,1)
f_IndicatorDis_SUPPLLog_1yr(Econ.AEXP,GDP_P_2010_SAM,'AEXP',25,2405,minV,maxV,minVy,maxVy,ylb, xlb,[55], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,2)

%% TROP
ylb = 'Ag Export Revenues/Ag GDP (%)';

dir_f = [DIR 'SuppFig' DIR_s 'Econ' DIR_s];
%minVy = floor(nanmin(nanmin(Econ.TROP(:,[40 55]))));
minVy = 0.1;
%maxVy = ceil(nanmax(nanmax(Econ.TROP(:,[40 55]))));
maxVy = 10000;

%f_IndicatorDis_SUPPL(Econ.TROP,GDP_P_2010_SAM,'TROP',0.17,0.71,minV,maxV,minVy,maxVy,ylb, xlb,dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName)

f_IndicatorDis_SUPPLLog_1yr(Econ.TROP,GDP_P_2010_SAM,'TROP',17,71,minV,maxV,minVy,maxVy,ylb, xlb,[40], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,1)
f_IndicatorDis_SUPPLLog_1yr(Econ.TROP,GDP_P_2010_SAM,'TROP',17,71,minV,maxV,minVy,maxVy,ylb, xlb,[55], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,2)

%% A2F
ylb = 'Access to Financing for Farmers (Index)';

dir_f = [DIR 'SuppFig' DIR_s 'Econ' DIR_s];
%minVy = floor(nanmin(nanmin(Econ.A2F(:,[40 55]))));
minVy = 0;
%maxVy = ceil(nanmax(nanmax(Econ.A2F(:,[40 55]))));
maxVy = 100;

%f_IndicatorDis_SUPPLNoLog_yr(Econ.A2F,GDP_P_2010_SAM,'A2F',25,100,minV,maxV,minVy,maxVy,ylb, xlb,[52 56], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName)

f_IndicatorDis_SUPPLNoLog_1yr_A2F(Econ.A2F,GDP_P_2010_SAM,'A2F',25,100,minV,maxV,minVy,maxVy,ylb, xlb,[52], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,1)
f_IndicatorDis_SUPPLNoLog_1yr_A2F(Econ.A2F,GDP_P_2010_SAM,'A2F',25,100,minV,maxV,minVy,maxVy,ylb, xlb,[56], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,2)

%% PVOL
ylb = 'Crop Price Volatility';

dir_f = [DIR 'SuppFig' DIR_s 'Econ' DIR_s];
%minVy = floor(nanmin(nanmin(Econ.PVOL(:,[50 56]))));
minVy = 0.01;
%maxVy = ceil(nanmax(nanmax(Econ.PVOL(:,[50 56]))));
maxVy = 1;

%f_IndicatorDis_SUPPL_yr(Econ.PVOL,GDP_P_2010_SAM,'PVOL',0.23,0.1,minV,maxV,minVy,maxVy,ylb, xlb,[50 56],dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName)

f_IndicatorDis_SUPPLLog_1yr(Econ.PVOL,GDP_P_2010_SAM,'PVOL',0.23,0.1,minV,maxV,minVy,maxVy,ylb, xlb,[50], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,1)
f_IndicatorDis_SUPPLLog_1yr(Econ.PVOL,GDP_P_2010_SAM,'PVOL',0.23,0.1,minV,maxV,minVy,maxVy,ylb, xlb,[56], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,2)

%% FLS
ylb = 'Food Loss Percentage';

dir_f = [DIR 'SuppFig' DIR_s 'Econ' DIR_s];
%minVy = floor(nanmin(nanmin(Econ.PVOL(:,[50 56]))));
minVy = 0;
%maxVy = ceil(nanmax(nanmax(Econ.PVOL(:,[50 56]))));
maxVy = 35;

%f_IndicatorDis_SUPPL_yr(Econ.PVOL,GDP_P_2010_SAM,'PVOL',0.23,0.1,minV,maxV,minVy,maxVy,ylb, xlb,[50 56],dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName)

f_IndicatorDis_SUPPLNoLog_1yr(Econ.FLS,GDP_P_2010_SAM,'FLS',6.6,2.2,minV,maxV,minVy,maxVy,ylb, xlb,[52], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,1)
f_IndicatorDis_SUPPLNoLog_1yr(Econ.FLS,GDP_P_2010_SAM,'FLS',6.6,2.2,minV,maxV,minVy,maxVy,ylb, xlb,[56], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,2)

%% Social
%% RPV
ylb = 'Rural Poverty Ratio (%)';

dir_f = [DIR 'SuppFig' DIR_s 'Soc' DIR_s];
%minVy = floor(nanmin(nanmin(Social.RPV(:,[40 55]))));
minVy = 0;
%maxVy = ceil(nanmax(nanmax(Social.RPV(:,[40 55]))));
maxVy = 100;

f_IndicatorDis_SUPPLNoLog_1yr(Social.RPV,GDP_P_2010_SAM,'RPV',13,2,minV,maxV,minVy,maxVy,ylb, xlb,[40], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,1)
f_IndicatorDis_SUPPLNoLog_1yr(Social.RPV,GDP_P_2010_SAM,'RPV',13,2,minV,maxV,minVy,maxVy,ylb, xlb,[55], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,2)

%f_IndicatorDis_SUPPLNoLog(Social.RPV,GDP_P_2010_SAM,'RPV',13,2,minV,maxV,minVy,maxVy,ylb, xlb,dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName)

%% GGG
ylb = 'Global Gender Gap Score %';

dir_f = [DIR 'SuppFig' DIR_s 'Soc' DIR_s];
%minVy = floor(nanmin(nanmin(Social.GGG(:,[46 56]))));
minVy = 40;
%maxVy = ceil(nanmax(nanmax(Social.GGG(:,[46 56]))));
maxVy = 100;

f_IndicatorDis_SUPPLNoLog_1yr(Social.GGG,GDP_P_2010_SAM,'GGG',70,80,minV,maxV,minVy,maxVy,ylb, xlb,[46], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,1)
f_IndicatorDis_SUPPLNoLog_1yr(Social.GGG,GDP_P_2010_SAM,'GGG',70,80,minV,maxV,minVy,maxVy,ylb, xlb,[56], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,2)

%f_IndicatorDis_SUPPLNoLog_yr(Social.GGG,GDP_P_2010_SAM,'GGG',0.7,0.8,minV,maxV,minVy,maxVy,ylb, xlb,[46 56], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName)

%% LRS
ylb = 'Land Rights Security Score';

dir_f = [DIR 'SuppFig' DIR_s 'Soc' DIR_s];
%minVy = floor(nanmin(nanmin(Social.LRS(:,[54]))));
minVy = 1;
%maxVy = ceil(nanmax(nanmax(Social.LRS(:,[54]))));
maxVy = 5;

f_IndicatorDis_SUPPLNoLog_1yr(Social.LRS,GDP_P_2010_SAM,'LRS',3,2,minV,maxV,minVy,maxVy,ylb, xlb,[54], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,1)

%% UDN
ylb = 'Prevalence of Undernourishment (%)';

dir_f = [DIR 'SuppFig' DIR_s 'Soc' DIR_s];
%minVy = floor(nanmin(nanmin(Social.UDN(:,[40 55]))));
minVy = 0;
%maxVy = ceil(nanmax(nanmax(Social.UDN(:,[40 55]))));
maxVy = 80;

%f_IndicatorDis_SUPPLNoLog_yr(Social.UDN,GDP_P_2010_SAM,'UDN',7.5,0,minV,maxV,minVy,maxVy,ylb, xlb,[40 55], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName)
f_IndicatorDis_SUPPLNoLog_1yr(Social.UDN,GDP_P_2010_SAM,'UDN',7.5,0,minV,maxV,minVy,maxVy,ylb, xlb,[40], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,1)
f_IndicatorDis_SUPPLNoLog_1yr(Social.UDN,GDP_P_2010_SAM,'UDN',7.5,0,minV,maxV,minVy,maxVy,ylb, xlb,[55], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,2)

%% RSH
ylb = 'H Index';

dir_f = [DIR 'SuppFig' DIR_s 'Soc' DIR_s];
%minVy = floor(nanmin(nanmin(Social.RSH(:,[40 55]))));
minVy = 0;
%maxVy = ceil(nanmax(nanmax(Social.RSH(:,[40 55]))));
maxVy = 90;

%f_IndicatorDis_SUPPLNoLog_yr(Social.RSH,GDP_P_2010_SAM,'RSH',22,48,minV,maxV,minVy,maxVy,ylb, xlb,[40 55], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName)
f_IndicatorDis_SUPPLNoLog_1yr(Social.RSH,GDP_P_2010_SAM,'RSH',22,48,minV,maxV,minVy,maxVy,ylb, xlb,[40], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,1)
f_IndicatorDis_SUPPLNoLog_1yr(Social.RSH,GDP_P_2010_SAM,'RSH',22,48,minV,maxV,minVy,maxVy,ylb, xlb,[55], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,2)

%% RSE
ylb = 'Lowest 20% Household Income/Food Expenditure per Capita (%)';

dir_f = [DIR 'SuppFig' DIR_s 'Soc' DIR_s];
%minVy = floor(nanmin(nanmin(Social.RSE(:,[40 51]))));
minVy = 0;
maxVy = ceil(nanmax(nanmax(Social.RSE(:,[40 51]))));
%maxVy = 6;

%f_IndicatorDis_SUPPLNoLog_yr(Social.RSE,GDP_P_2010_SAM,'RSE',0.3,1,minV,maxV,minVy,maxVy,ylb, xlb,[40 51], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName)
f_IndicatorDis_SUPPLNoLog_1yr(Social.RSE,GDP_P_2010_SAM,'RSE',30,100,minV,maxV,minVy,maxVy,ylb, xlb,[40], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,1)
f_IndicatorDis_SUPPLNoLog_1yr(Social.RSE,GDP_P_2010_SAM,'RSE',30,100,minV,maxV,minVy,maxVy,ylb, xlb,[51], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,2)

%% SSR
ylb = 'Self-Sufficiency Ratio (%)';

dir_f = [DIR 'SuppFig' DIR_s 'Soc' DIR_s];
%minVy = floor(nanmin(nanmin(Social.SSR(:,[40 55]))));
minVy = 0;
%maxVy = ceil(nanmax(nanmax(Social.SSR(:,[40 55]))));
maxVy = 260;

f_IndicatorDis_SUPPLNoLog_yr(Social.SSR,GDP_P_2010_SAM,'SSR',85,100,minV,maxV,minVy,maxVy,ylb, xlb,[40 55], dir_f,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName)


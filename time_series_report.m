clear;
%%% Original Scores
dir = 'C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model\'
dir_s = [dir 'SAM_Data_Outputs\SAM_Indicators\'];
dir_A = 'C:\Users\gyao\Google Drive\SAM_CMT\Inputs\';
dir_fig = [dir 'TimeSeries\12222020\'];
load([dir_s 'Environment_SAM_12012019.mat'])
load([dir_s 'Economic_SAM_12012019.mat'])
load([dir_s 'Social_SAM_12012019.mat'])
load([dir_A 'basic_FAO_SAM.mat'])

%%% Original Values
%{
dir = 'C:\Users\gyao\Google Drive\ZhangLabData\SAM\SAM_Model\'
dir_s = [dir 'SAM_Data_Outputs\SAM_Indicators\'];
%}
dir_t = [dir 'SAM_Data_Outputs\SAM_Indicators_Trans\'];
%{
dir_A = 'C:\Users\gyao\Google Drive\SAM_CMT\Inputs\';
dir_fig = [dir 'PatchPlots\11122019\']
%}

load([dir_t 'Environment_SAM_Trans_12012019.mat'])
load([dir_t 'Economic_SAM_Trans_12012019.mat'])
load([dir_t 'Social_SAM_Trans_12012019.mat'])
load([dir_A 'basic_FAO_SAM.mat'])




[All,AllScore,varName_all,Env_Trans,Econ_Trans,Soc_Trans,EnvS,EconS,SocS,envName,econName,socName,envN,econN,socN,threshL,threshU,n] = combIndicatorwithscoretransformation_f(Env_Trans,Econ_Trans,Social_Trans,2005,2014,25,75,100/3,200/3);



    
Env_Trans.Nsur(isinf(Env_Trans.Nsur)) = nan;
% change variable here
AllScore.Nsur = LinearScroeTrans_f(Env_Trans.Nsur,-69,-52,100/3,200/3);
EnvS.Nsur = AllScore.Nsur;

Env_Trans.Psur(isinf(Env_Trans.Psur)) = nan;
% change variable here
AllScore.Psur = LinearScroeTrans_f(Env_Trans.Psur,-6.9,-3.5,100/3,200/3);
EnvS.Psur = AllScore.Psur;

%{
% Old version indicator
Env_Trans.GWD(isinf(Env_Trans.GWD)) = nan;
% change variable here
AllScore.GWD = LinearScroeTrans_f(Env_Trans.GWD,-1*log10(10000000000+1),-1*log10(0+1),100/3,200/3);
EnvS.GWD = AllScore.GWD;
%}

Env_Trans.SUSI(isinf(Env_Trans.SUSI)) = nan;
% change variable here
AllScore.SUSI = LinearScroeTrans_f(Env_Trans.SUSI,-1*log10(2+nanmin(Env.SUSI(Env.SUSI>0))),-1*log10(1+nanmin(Env.SUSI(Env.SUSI>0))),100/3,200/3);
EnvS.SUSI = AllScore.SUSI;

Env_Trans.GHG(isinf(Env_Trans.GHG)) = nan;
% change variable here
AllScore.GHG = LinearScroeTrans_f(Env_Trans.GHG,-1*log10(1.08+nanmin(Env.GHG(Env.GHG>0))),-1*log10(0.86+nanmin(Env.GHG(Env.GHG>0))),100/3,200/3);
EnvS.GHG = AllScore.GHG;

Env_Trans.LCC(isinf(Env_Trans.LCC)) = nan;
% change variable here
AllScore.LCC = LinearScroeTrans_f(Env_Trans.LCC,-1*log10(0.053+nanmin(Env.LCC(Env.LCC>0))),-1*log10(0+nanmin(Env.LCC(Env.LCC>0))),100/3,200/3);
EnvS.LCC = AllScore.LCC;

Env_Trans.SER(isinf(Env_Trans.SER)) = nan;
% change variable here
AllScore.SER = LinearScroeTrans_f(Env_Trans.SER,-1*log10(5),-1*log10(1),100/3,200/3);
EnvS.LCC = AllScore.LCC;

%% Economic indicators
Econ_Trans.AGDP(isinf(Econ_Trans.AGDP)) = nan;
% change variable here
AllScore.AGDP = LinearScroeTrans_f(Econ_Trans.AGDP,log10(460),log10(7946),100/3,200/3);
EconS.AGDP = AllScore.AGDP;

Econ_Trans.AEXP(isinf(Econ_Trans.AEXP)) = nan;
% change variable here
AllScore.AEXP = LinearScroeTrans_f(Econ_Trans.AEXP,log10(25),log10(2405),100/3,200/3);
EconS.AEXP = AllScore.AEXP;

Econ_Trans.TROP(isinf(Econ_Trans.TROP)) = nan;
% change variable here
AllScore.TROP = LinearScroeTrans_f(Econ_Trans.TROP,log10(17),log10(71),100/3,200/3);
EconS.TROP = AllScore.TROP;

Econ_Trans.A2F(isinf(Econ_Trans.A2F)) = nan;
% change variable here
AllScore.A2F = LinearScroeTrans_f(Econ_Trans.A2F,25,80,100/3,200/3);
EconS.A2F = AllScore.A2F;

Econ_Trans.PVOL(isinf(Econ_Trans.PVOL)) = nan;
% change variable here
AllScore.PVOL = LinearScroeTrans_f(Econ_Trans.PVOL,log10(1/0.23),log10(1/0.1),100/3,200/3);
EconS.PVOL = AllScore.PVOL;

%% Social indicators
Social_Trans.RSE(isinf(Social_Trans.RSE)) = nan;
% change variable here
AllScore.RSE = LinearScroeTrans_f(Social_Trans.RSE,30,100,100/3,200/3);
SocS.RSE = AllScore.RSE;


Social_Trans.UDN(isinf(Social_Trans.UDN)) = nan;
% change variable here
AllScore.UDN = LinearScroeTrans_f(Social_Trans.UDN,-7.5,0,100/3,200/3);
SocS.UDN = AllScore.UDN;

Social_Trans.RPV(isinf(Social_Trans.RPV)) = nan;
% change variable here
AllScore.RPV = LinearScroeTrans_f(Social_Trans.RPV,-13,-2,100/3,200/3);
SocS.RPV = AllScore.RPV;

Social_Trans.GGG(isinf(Social_Trans.GGG)) = nan;
% change variable here
AllScore.GGG = LinearScroeTrans_f(Social_Trans.GGG,70,80,100/3,200/3);
SocS.GGG = AllScore.GGG;

Social_Trans.LRS(isinf(Social_Trans.LRS)) = nan;
% change variable here
AllScore.LRS = LinearScroeTrans_f(Social_Trans.LRS,-3,-2,100/3,200/3);
SocS.LRS = AllScore.LRS;

Social_Trans.RSH(isinf(Social_Trans.RSH)) = nan;
% change variable here
AllScore.RSH = LinearScroeTrans_f(Social_Trans.RSH,22,48,100/3,200/3);
SocS.RSH = AllScore.RSH;

AllScoreB = AllScore;
for var = 1:1:n
    AllScoreB.(varName_all{var})(AllScoreB.(varName_all{var})>100) = 100;
    AllScoreB.(varName_all{var})(AllScoreB.(varName_all{var})<0) = 0;    
end

for var = 1:1:envN
    EnvSB.(envName{var}) = AllScoreB.(envName{var});
end

for var = 1:1:econN
    EconSB.(econName{var}) = AllScoreB.(econName{var});
end

for var = 1:1:socN
    SocSB.(socName{var}) = AllScoreB.(socName{var});
end


L(1:n) = 100/3;
U(1:n) = 200/3;


% envNameL = {'SustainWater(SUSI)','Nsurplus (Nsur)','Psurplus (Psur)','LandCoverChange (LCC)','GreenHouseGasEmiss (GHG)','SoilErosion (SER)'};
% econNameL = {'AgGDPAgWorker (AGDP)','Access2Finance (A2F)','PriceVolatility (PVOL)','AgExp2AgWorker (AEXP)','AgExport2AgGDP (TROP)'};
% socNameL = {'CropDiversity (RSH)','FoodAfford (RSE)','Preval.OfUndernourish.(UDN)','RuralPovertyRatio (RPV)','GlobalGenderGap (GGG)','LandSecurity (LRS)'};

envNameL = {'SUSI','Nsur','Psur','LCC','GHG','SER'};
econNameL = {'AGDP','A2F','PVOL','AEXP','TROP'};
socNameL = {'RSH','RSE','UDN','RPV','GGG','LRS'};

testYrs = [1 10 20 30 40 50 54];
%testYrs = [54];

%% line graph

varName_long = horzcat(envNameL,econNameL,socNameL);

%Australia
cn = 9;
f_3D_ts(cn, EnvSB, EconSB, SocSB, uniYrs,FAOSTAT_CoName_FAO(cn));
print(strcat(dir_fig, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');

%United States
cn = 207;
f_3D_ts(cn, EnvSB, EconSB, SocSB, uniYrs,"United States");
print(strcat(dir_fig, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');

%Brazil
cn = 26;
f_3D_ts(cn, EnvSB, EconSB, SocSB, uniYrs,FAOSTAT_CoName_FAO(cn));
print(strcat(dir_fig, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');

%China
cn = 40;
f_3D_ts(cn, EnvSB, EconSB, SocSB, uniYrs,FAOSTAT_CoName_FAO(cn));
print(strcat(dir_fig, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');

%India
cn = 89;
f_3D_ts(cn, EnvSB, EconSB, SocSB, uniYrs,FAOSTAT_CoName_FAO(cn));
print(strcat(dir_fig, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');

%Ukarine
cn = 202;
f_3D_ts(cn, EnvSB, EconSB, SocSB, uniYrs,FAOSTAT_CoName_FAO(cn));
print(strcat(dir_fig, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');

%Ethiopia
cn = 64;
f_3D_ts(cn, EnvSB, EconSB, SocSB, uniYrs,FAOSTAT_CoName_FAO(cn));
print(strcat(dir_fig, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');

% Tajikstan
cn = 188;
f_3D_ts(cn, EnvSB, EconSB, SocSB, uniYrs,FAOSTAT_CoName_FAO(cn));
print(strcat(dir_fig, string(FAOSTAT_CoName_FAO(cn))), '-djpeg');



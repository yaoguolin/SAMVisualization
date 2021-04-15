clear;

dir = 'C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model\SAM_Data_Outputs\SAM_Scores\';
dir_A = 'C:\Users\gyao\Google Drive\SAM_CMT\Inputs\';
dir_fig = [dir 'ReportCard\11122019\']
load([dir 'Environment_Score_SAM_11122019.mat'])
load([dir 'Economic_Score_SAM_11122019.mat'])
load([dir 'Social_Score_SAM_11122019.mat'])
load([dir_A 'basic_FAO_SAM.mat'])

%% Get the average of each dimension

%Env_D.Wat.GWD = Env_S.GWD;
Env_D.Wat.SUSI = Env_S.SUSI;
Env_D.Pol.Nsur = Env_S.Nsur;
Env_D.Pol.Psur = Env_S.Psur;
Env_D.LoB.LCC = Env_S.LCC;
Env_D.Clm.GHG = Env_S.GHG;
Env_D.Sol.SER = Env_S.SER;

Econ_D.ALP.AGDP = Econ_S.AGDP;
Econ_D.ASP.AEXP = Econ_S.AEXP;
Econ_D.GMA.TROP = Econ_S.TROP;
Econ_D.CRD.A2F = Econ_S.A2F;
Econ_D.RSK.PVOL = Econ_S.PVOL;

Soc_D.RES.RSH = Social_S.RSH;
Soc_D.RES.RSE = Social_S.RSE;
%Soc_D.RES.SSR = Social_S.SSR;
Soc_D.HLT.UND = Social_S.UDN;
%Soc_D.HLT.OBR = Social_S.OBR;
%Soc_D.HLT.POA = Social_S.POA;
Soc_D.PVT.RPV = Social_S.RPV;
Soc_D.REQ.GGG = Social_S.GGG;
Soc_D.REQ.LRS = Social_S.LRS;


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
bchmrk = [25 75]; %***

uniyrstart = find(uniYrs == yrstart);
uniyrend = find(uniYrs == yrend);

%%% Organize data
RegScore_tott = nan(218,56,4);
RegScore_tott(:,:,1:3) = RegScore_tot;
RegScore_tott(:,:,4) = RegScore;

%%% Signs
RegScore_sign = nan(218,4);
for i = 1:1:4
    RegScore_sign(:,i) = pattern_f(RegScore_tott(:,:,i),yrstart,yrend);
end

%%% Get the benchmark and colorcode
% 1 = green 2 = yellow 3 = red
% get the average of past 10 yrs
RegScore_avg = nan(218,4);
RegScore_avg = squeeze(nanmean(RegScore_tott(:,uniyrstart:uniyrend,:),2));

RegScore_sign(isnan(RegScore_avg)) = nan;

bchmrk_V = nan(2,4);
for i = 1:1:4
    bchmrk_V(:,i) = prctile(RegScore_avg(:,i),bchmrk,[1 2]);   
end

RegScore_colr = nan(218,4);
for i = 1:1:4
    RegScore_colr(RegScore_avg(:,i)< bchmrk_V(1,i),i)= 3;
    RegScore_colr(RegScore_avg(:,i)> bchmrk_V(2,i),i)= 1;
    RegScore_colr(RegScore_avg(:,i)>= bchmrk_V(1,i) & RegScore_avg(:,i)<= bchmrk_V(2,i),i)= 2;
end

RegScore_colr(isnan(RegScore_avg)) = 4;

FAOSTAT_CoName_FAO2 = FAOSTAT_CoName_FAO;
FAOSTAT_CoName_FAO2(207) = {'USA'};
FAOSTAT_CoName_FAO2(204) = {'UK'};
FAOSTAT_CoName_FAO2(51) = {'Cote dIvoire'};
FAOSTAT_CoName_FAO2(160) = {'Runion'};

for cn = 1:1:218
    reportcard_f(cn,RegScore_colr,RegScore_sign)
    title(FAOSTAT_CoName_FAO(cn),'fontSize',26)
    print(string(FAOSTAT_CoName_FAO2(cn)),'-djpeg')
end

% 40 China
reportcard_f(40,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(40),'fontSize',24)

% 207 USA
reportcard_f(207,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(207),'fontSize',24)


% 158 Russia
reportcard_f(158,RegScore_colr,RegScore_sign)

% 34 Canada
reportcard_f(34,RegScore_colr,RegScore_sign)

%26 Brazil
reportcard_f(26,RegScore_colr,RegScore_sign)

%9 Australia
reportcard_f(26,RegScore_colr,RegScore_sign)

%89 India
reportcard_f(89,RegScore_colr,RegScore_sign)

%123 Mexico
reportcard_f(123,RegScore_colr,RegScore_sign)

%204 UK
reportcard_f(204,RegScore_colr,RegScore_sign)

%114 Malawi
reportcard_f(114,RegScore_colr,RegScore_sign)
title(FAOSTAT_CoName_FAO(114),'fontSize',24)


%69 France
reportcard_f(69,RegScore_colr,RegScore_sign)

%97 Japan
reportcard_f(97,RegScore_colr,RegScore_sign)

%201 Uganda
reportcard_f(201,RegScore_colr,RegScore_sign)



%217 Zambia
reportcard_f(217,RegScore_colr,RegScore_sign)

%7 Argentina
reportcard_f(7,RegScore_colr,RegScore_sign)

%136 New Zealand
reportcard_f(136,RegScore_colr,RegScore_sign)

%139 Nigeria
reportcard_f(139,RegScore_colr,RegScore_sign)

%1 Afghanistan
reportcard_f(1,RegScore_colr,RegScore_sign)


%115 Malaysia
reportcard_f(115,RegScore_colr,RegScore_sign)

%99 {'Kazakhstan'}
reportcard_f(99,RegScore_colr,RegScore_sign)

% 168 'Saudi Arabia'}
reportcard_f(168,RegScore_colr,RegScore_sign)

% 3 Algeria
reportcard_f(3,RegScore_colr,RegScore_sign)

% 109 Libya
reportcard_f(109,RegScore_colr,RegScore_sign)

% 59 Egypt
reportcard_f(59,RegScore_colr,RegScore_sign)

% 182 Sudan
reportcard_f(182,RegScore_colr,RegScore_sign)

% 180 Spain
reportcard_f(180,RegScore_colr,RegScore_sign)

% 23 Bolivia
reportcard_f(23,RegScore_colr,RegScore_sign)


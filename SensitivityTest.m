clear;

dir = 'C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model\';
dir_A = 'C:\Users\gyao\Google Drive\SAM_CMT\Inputs\';
dir_fig = [dir 'Sensitivity\'];


load([dir 'SAM_Data_Outputs\SAM_Patchplot Scores\patchplot_score_02232021.mat'])
load([dir_A 'basic_FAO_SAM.mat'])


dir = 'C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model\';
dir_A = 'C:\Users\gyao\Google Drive\SAM_CMT\Inputs\';
dir_fig_2 = [dir 'ReportCard\12012019\TwoLayer\'];
%dir_fig_3 = [dir 'ReportCard\12012019\ThreeLayer\']
dir_fig_3 = [dir 'ReportCard\12222020\ThreeLayer\'];


load([dir 'SAM_Data_Outputs\SAM_Patchplot Scores\patchplot_score_02232021.mat'])
load([dir_A 'basic_FAO_SAM.mat'])

load([dir 'SAM_Data_Outputs\SAM_Indicators\Environment_SAM_12012019.mat'])
load([dir 'SAM_Data_Outputs\SAM_Indicators\Economic_SAM_12012019.mat'])
load([dir 'SAM_Data_Outputs\SAM_Indicators\Social_SAM_12012019.mat'])

Env_D.Wat.SUSI = AllScoreB.SUSI;
Env_D.Pol.Nsur = AllScoreB.Nsur;
Env_D.Pol.Psur = AllScoreB.Psur;
Env_D.LoB.LCC = AllScoreB.LCC;
Env_D.Clm.GHG = AllScoreB.GHG;
Env_D.Sol.SER = AllScoreB.SER;


Econ_D.ALP.AGDP = AllScoreB.AGDP;
Econ_D.ASP.AEXP = AllScoreB.AEXP;
Econ_D.GMA.TROP = AllScoreB.TROP;
Econ_D.CRD.A2F = AllScoreB.A2F;
Econ_D.RSK.PVOL = AllScoreB.PVOL;
Econ_D.EFC.FLS = AllScoreB.FLS;


Soc_D.RES.RSH = AllScoreB.RSH;
Soc_D.RES.RSE = AllScoreB.RSE;
Soc_D.HLT.UND = AllScoreB.UDN;
Soc_D.PVT.RPV = AllScoreB.RPV;
Soc_D.EQL.GGG = AllScoreB.GGG;
Soc_D.RTS.LRS = AllScoreB.LRS;


[EnvScore,EnvBA] = DimScore_f(Env_D);
[EconScore,EconBA] = DimScore_f(Econ_D);
[SocScore,SocBA] = DimScore_f(Soc_D);

RegScore_tot = nan(218,56,3);

RegScore_tot(:,:,1) = EconScore;
RegScore_tot(:,:,2) = EnvScore;
RegScore_tot(:,:,3) = SocScore;

yrstart = 2010; %***
yrend = 2014;   %***

uniyrstart = find(uniYrs == yrstart);
uniyrend = find(uniYrs == yrend);
RegScore = squeeze(nanmean(RegScore_tot,3));
avg_score = nanmean(RegScore(:, uniyrstart:uniyrend),2);

%% Get the average of each dimension


varname = fieldnames(AllScoreB);


SAM_all = nan(18, 218, 56);
for i = 1:1:18
    SAM_all(i,:,:) = AllScoreB.(varname{i});
end


%% Simulation
fraction = 0.5; % the fractions of variables to be kept
k = fraction * 18;

% create a series of names
full_idx = [1:1:18];

for i = 1:1:k
    ms{i} = strcat('M', num2str(i)); 
end

for i = 1:1:k
    %mm = min(mycombnk(18,i),1000);
    for m = 1:1:1000
        [idx,idx]=sort(rand(1,18));
        out_idx = idx(1:i);
        rd_ary.(ms{i})(m,:) = out_idx;
        %new_idx = full_idx;
        %new_idx(out_idx) = [];
        %new_var.(ms{i}){m} = {varname{new_idx}};
        SAM_temp = SAM_all;
        SAM_temp(out_idx,:,:) = nan;
        [SAM_overall.(ms{i})(:,m)] = f_patch_score_sensitivity(SAM_temp, yrstart, yrend);
    end
end

save([dir_fig 'Sensitivity02242021.mat'],'SAM_overall', 'rd_ary');

cn_list = [9, 207, 26, 40, 89, 202, 64, 188];
for i = 1:1:length(cn_list)
    n = cn_list(i);
    SAM_violin = nan(1000,k);
    for kk = 1:1:k
         SAM_violin(:, kk) = transpose(SAM_overall.(ms{kk})(n,:));
    end
    close all
    figure('units','normalized','outerposition',[0 0 1 1]);
    violin(SAM_violin);
    title(FAOSTAT_CoName_FAO{n},'FontSize', 30);
    ylabel('Score', 'FontSize', 16);
    xlabel('Number of omitted indicators','FontSize', 16);
    print([dir_fig,'Sensitivity02242021_',FAOSTAT_CoName_FAO{n}],'-dpng','-r200')
end






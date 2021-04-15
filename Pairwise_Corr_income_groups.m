%% a function to calculate drivers correlation 
% set up
projectDir = 'C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model'; dirSep = '\'; 


dataDir = [projectDir, dirSep,'SAM_Data_Outputs',dirSep,'SAM_Scores'];
inputsDir = [projectDir, dirSep, 'Correlations',dirSep, 'Inputs'];
graphsDir = [projectDir, dirSep, 'Correlations',dirSep, 'Graphs'];
resultsDir = [projectDir, dirSep,'Correlations',dirSep, 'Results'];

highinc_data = load([resultsDir dirSep 'SAMcorr_highinc.mat']);
upmidinc_data = load([resultsDir dirSep 'SAMcorr_upmidinc.mat']);
lowmidinc_data = load([resultsDir dirSep 'SAMcorr_lowmidinc.mat']);
lowinc_data = load([resultsDir dirSep 'SAMcorr_lowinc.mat']);

%nansum(nansum(nansum(highinc_data.SAMdriver_corr - upmidinc_data.SAMdriver_corr)))
%nansum(nansum(nansum(highinc_data.SAMdriver_corr - lowmidinc_data.SAMdriver_corr)))
%nansum(nansum(nansum(highinc_data.SAMdriver_corr - lowinc_data.SAMdriver_corr)))
%high_income
tradeoffsyn_frac = nan(17,17,4);
tradeoffsyn_frac(:,:,4) = squeeze(highinc_data.SAMdriver_corr(:,:,2))./squeeze(highinc_data.SAMdriver_corr(:,:,4));
tradeoffsyn_frac(:,:,3) = squeeze(upmidinc_data.SAMdriver_corr(:,:,2))./squeeze(upmidinc_data.SAMdriver_corr(:,:,4));
tradeoffsyn_frac(:,:,2) = squeeze(lowmidinc_data.SAMdriver_corr(:,:,2))./squeeze(lowmidinc_data.SAMdriver_corr(:,:,4));
tradeoffsyn_frac(:,:,1) = squeeze(lowinc_data.SAMdriver_corr(:,:,2))./squeeze(lowinc_data.SAMdriver_corr(:,:,4));

figure('units','normalized','outerposition',[0 0 1 1]);
Markers = {'+','o','*','x','v','d','^','s','>','<'};

for i = 1:1:6
    p(i) = plot([1:4],squeeze(tradeoffsyn_frac(7,i,:)),strcat('-',Markers{i}));
    p(i).LineWidth = 2;
    hold on
end
%xlim([0.5,4.5]);
legend('AGDP & SUSI','AGDP & Nsur','AGDP & Psur','AGDP & LCC','AGDP & GHG','AGDP & SER','Location','NorthEastOutside')
ylabel("Tradeoff/(Synergy + TradeOff)", "FontSize",12);
xlabel("Income Groups")
incomegroup = ["Low Income", "Lower Middle Income", "Upper Middle Income", "High Income"];
set(gca,'XTick',1:4);
%set(gca,'XTickLabelMode','manual');
set(gca,'XTickLabel',incomegroup);


%[ha, pos] = tight_subplot(17,17,[0 0],[.1 .05],[.025 .01]) 


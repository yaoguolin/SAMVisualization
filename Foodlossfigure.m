clear;
%%% Original Scores
dir = 'C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model\';
dir_food = [dir 'SAM_Data\FoodLoss\'];
dir_A = 'C:\Users\gyao\Google Drive\SAM_CMT\Inputs\';

load([dir 'SAM_Data\NDatabase_Zhang\dataN_partA1_fullWorkSpace.mat'])  %%%load Nitrogen database 
load([dir_food 'Food_Loss_EIU.mat'])
load([dir 'EPI_Regions.mat']) 
load([dir 'basic_FAO_SAM.mat'])

Yr=1961:2016;
close all;

yr_idx = 56;

region_loss = nan(8,1);
region_loss(1) = 7.8;
region_loss(2) = 11.6;
region_loss(4) = 15.7;
region_loss(5) = 11.6;
region_loss(6) = 10.8;
region_loss(7) = 5.8;
region_loss(8) = 14;


figure('units','normalized','outerposition',[0 0 1 1]);
for j = 1:length(yr_idx)
    regions = fieldnames(RegionCoName);
    colormap = distinguishable_colors(length(regions));

    yr = yr_idx(j);
    for i=1:length(regions)
        idxrgn = RegionID.(regions{i});
        reg_len = length(idxrgn);
        x_var = ones(reg_len,1).*i - 0.125;
        text(x_var,FLoss(idxrgn,yr) + 0.125,char(FAOSTAT_CoABR_ISO(idxrgn)),'Color',colormap(i,:),'Fontweight','bold','FontSize',8);
        hold on
        line([i-0.2 i+0.2], [region_loss(i) region_loss(i)],'Color',colormap(i,:));
        hold on
        eval(['h' num2str(i) '=plot(NaN,NaN,''s'',''markerfacecolor'',colormap(i,:),''Color'',colormap(i,:),''markersize'',10);']);

    end

hold on

set(gca,'fontsize',13)
xlim([0 9])
ylim([0 100])
grid on
legend([h1 h2 h3 h4 h5 h6 h7 h8],RegionName,'fontsize',8,'location','northwest');
xticks(1:1:8);
xticklabels(RegionName);
xtickangle(45)
ylabel('Food loss percentage')
end
title('Food loss percentage by region (2016)')

print([dir_food 'foodlossvisual'],'-dpng','-r200')

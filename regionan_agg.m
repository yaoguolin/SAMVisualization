% Run ReportCard_threelayer11242019_GY_gradientcolor.m first

load([dir 'EPI_Regions.mat']);

rgname = fieldnames(RegionID);
n_rg = length(rgname);

for i = 1:1:length(rgname)
    RegionID0.(rgname{i}) = intersect(RegionID.(rgname{i}), Co_ID_group0);
end

for i = 1:1:4
    for r = 1:1:length(rgname)   
    green_portion.(rgname{r}){:,i} = find(RegScore_colr(RegionID0.(rgname{r}),i) == 1);
    yellow_portion.(rgname{r}){:,i} = find(RegScore_colr(RegionID0.(rgname{r}),i) == 2);
    red_portion.(rgname{r}){:,i} = find(RegScore_colr(RegionID0.(rgname{r}),i) == 3);
    end
end

% 3 dimensions: 1. Econ, 2: Env. 3: Social
dimen_total_share_rg = nan(n_rg, 3, 4);

green_share_rg = nan(n_rg, 4);
yellow_share_rg = nan(n_rg, 4);
red_share_rg = nan(n_rg, 4);

for d = 1:1:4 % dimension
    for r = 1:1:n_rg
        green_share_rg(r, d) = length(green_portion.(rgname{r}){1,d})/ length(RegionID0.(rgname{r}));
        yellow_share_rg(r, d) = length(yellow_portion.(rgname{r}){1,d})/ length(RegionID0.(rgname{r}));
        red_share_rg(r, d) = 1 - green_share_rg(r,d) - yellow_share_rg(r,d);
    end
end

for r = 1:1:n_rg
    dimen_total_share_rg(r, 3, :) = green_share_rg(r,:);
    dimen_total_share_rg(r, 2, :) = yellow_share_rg(r,:);
    dimen_total_share_rg(r, 1, :) = red_share_rg(r,:);
end

RegionName0 = {"Asia", "Caribbean", "E. Europe & Eurasia", "Europe & N. America", "Latin America", "Mid East & N. Afr…", "Pacific", "Sub-Saharan Africa"};

figure('units','normalized','outerposition',[0 0 1 1]);
[ha, pos] = tight_subplot(2,2,[0.1 0.05],[.15 .05],[.05 .01]); 
x = transpose(1:n_rg);

c = ['r' 'y' 'g'];
 axes(ha(1))
 bb_1 = bar(x,dimen_total_share_rg(:,:,4),'stacked','EdgeColor', 'None');
title('a. Overall','fontSize',20);
ylim([0,1])
%xticklabels(['High income', 'Upper Middle Income', 'Lower Middle Income','Low Income']);
set(gca,'XTickLabel',RegionName,'fontSize',12, 'XTickLabelRotation', 15);
%xlabel('Regions','fontSize',14,'fontWeight','bold');

  axes(ha(2))
 bb_3 = bar(dimen_total_share_rg(:,:,2),'stacked','EdgeColor', 'None');
title('b. Environmental','fontSize',20);
ylim([0,1])
set(gca,'XTickLabel',RegionName,'fontSize',12, 'XTickLabelRotation', 15);
%xlabel('Regions','fontSize',14,'fontWeight','bold');

 axes(ha(3))
 bb_2 = bar(dimen_total_share_rg(:,:,1),'stacked','EdgeColor', 'None');
title('c. Economic','fontSize',20);
ylim([0,1])
set(gca,'XTickLabel',RegionName,'fontSize',12, 'XTickLabelRotation', 15);
%xlabel('Regions','fontSize',14,'fontWeight','bold');

  axes(ha(4))
 bb_4 = bar(dimen_total_share_rg(:,:,3),'stacked','EdgeColor', 'None');
title('d. Social','fontSize',20);

set(gca,'XTickLabel',RegionName,'fontSize',12, 'XTickLabelRotation', 15);
%xlabel('Regions','fontSize',14,'fontWeight','bold');


 for k=1:3
  set(bb_1(k),'facecolor',c(k))
  set(bb_2(k),'facecolor',c(k))
  set(bb_3(k),'facecolor',c(k))
  set(bb_4(k),'facecolor',c(k))
 end

 print([dir_fig_inc, 'Regional aggregation'], '-djpeg');

%% Calculate SSR

imports = squeeze(nansum(nansum(ImTrdQnt, 1),4));
exports = squeeze(nansum(nansum(ImTrdQnt, 1),3));

imports = permute(imports,[2,1]);
exports = permute(exports,[2,1]);

imports_SAM = nan(218, 56);
exports_SAM = nan(218, 56);


imports_SAM(:, tradeyrs(1):56) = imports;
exports_SAM(:, tradeyrs(1):56) = exports;
Product_SAM = squeeze(nansum(Product_FAO, 2));

SSR = Product_SAM ./ (Product_SAM + imports_SAM - exports_SAM);


nanmax(nanmax(SSR(SSR<1)))

figure;
histogram(SSR(SSR<1 & SSR>0));


figure;
histogram(SSR(SSR>1));


nansum(nansum(SSR<1)) %4660
nansum(nansum(SSR>1)) %1542

nansum(nansum(SSR<0)) %14

nansum(nansum(SSR<1 & SSR> 0.95)) %1738
nansum(nansum(SSR < 0.95)) %2922


nansum(nansum(SSR < 0.7)) %1217

nansum(nansum(SSR < 0.95 & SSR > 0.7)) %1705

%% SSR average
SSR_average = nanmean(SSR(:, uniyrstart:uniyrend),2);

figure;
histogram(SSR_average);

nansum(nansum(SSR_average>1)) %53
nansum(nansum(SSR_average<1)) %151

nansum(nansum(SSR_average<1 & SSR_average> 0.95)) %42
nansum(nansum(SSR_average < 0.7)) %45
nansum(nansum(SSR_average < 0.95 & SSR_average > 0.7)) %64


nansum(nansum(SSR_average<1 & SSR_average> 0.9)) %40
nansum(nansum(SSR_average < 0.7)) %45
nansum(nansum(SSR_average < 0.9 & SSR_average > 0.7)) %66

%% >1 0.95-1, 0.7-0.95, <0.7

nansum(nansum(SSR_average(Co_ID_group)>1)) %31
nansum(nansum(SSR_average(Co_ID_group)<1)) %81

nansum(nansum(SSR_average(Co_ID_group)<1 & SSR_average(Co_ID_group)> 0.95)) %30
nansum(nansum(SSR_average(Co_ID_group) < 0.7)) %12
nansum(nansum(SSR_average(Co_ID_group) < 0.95 & SSR_average(Co_ID_group) > 0.7)) %39

SSRrgname = {"highSSR","umSSR", "lmSSR", "lowSSR"};
n_rg = length(SSRrgname);

SSRRegionID.highSSR = find(SSR_average >= 1);
SSRRegionID.umSSR = find(SSR_average < 1 & SSR_average >= 0.95);
SSRRegionID.lmSSR = find(SSR_average < 0.95 & SSR_average >= 0.7);
SSRRegionID.lowSSR = find(SSR_average < 0.7);

for i = 1:1:length(SSRrgname)
    SSRRegionID0.(SSRrgname{i}) = intersect(SSRRegionID.(SSRrgname{i}), Co_ID_group0);
end

for i = 1:1:4
    for r = 1:1:length(SSRrgname)   
    green_portion.(SSRrgname{r}){:,i} = find(RegScore_colr(SSRRegionID0.(SSRrgname{r}),i) == 1);
    yellow_portion.(SSRrgname{r}){:,i} = find(RegScore_colr(SSRRegionID0.(SSRrgname{r}),i) == 2);
    red_portion.(SSRrgname{r}){:,i} = find(RegScore_colr(SSRRegionID0.(SSRrgname{r}),i) == 3);
    end
end


% 3 dimensions: 1. Econ, 2: Env. 3: Social
dimen_total_share_ssr = nan(n_rg, 3, 4);

green_share_ssr = nan(n_rg, 4);
yellow_share_ssr = nan(n_rg, 4);
red_share_ssr = nan(n_rg, 4);

for d = 1:1:4 % dimension
    for r = 1:1:n_rg
        green_share_ssr(r, d) = length(green_portion.(SSRrgname{r}){1,d})/ length(SSRRegionID0.(SSRrgname{r}));
        yellow_share_ssr(r, d) = length(yellow_portion.(SSRrgname{r}){1,d})/ length(SSRRegionID0.(SSRrgname{r}));
        red_share_ssr(r, d) = 1 - green_share_ssr(r,d) - yellow_share_ssr(r,d);
    end
end

for r = 1:1:n_rg
    dimen_total_share_ssr(r, 3, :) = green_share_ssr(r,:);
    dimen_total_share_ssr(r, 2, :) = yellow_share_ssr(r,:);
    dimen_total_share_ssr(r, 1, :) = red_share_ssr(r,:);
end

RegionNameSSR = {"> 100%", "95% ~ 100%", "70% ~ 95%", "< 70%"};

figure('units','normalized','outerposition',[0 0 1 1]);
[ha, pos] = tight_subplot(2,2,[0.1 0.05],[.15 .05],[.05 .01]); 
x = transpose(1:n_rg);

c = ['r' 'y' 'g'];
 axes(ha(1))
 bb_1 = bar(x,dimen_total_share_ssr(:,:,4),'stacked','EdgeColor', 'None');
title('a. Overall','fontSize',20);
ylim([0,1])
%xticklabels(['High income', 'Upper Middle Income', 'Lower Middle Income','Low Income']);
set(gca,'XTickLabel',RegionNameSSR,'fontSize',12, 'XTickLabelRotation', 0);
xlabel('Self-sufficiency Ratio','fontSize',12,'fontWeight','bold');

  axes(ha(2))
 bb_3 = bar(dimen_total_share_ssr(:,:,2),'stacked','EdgeColor', 'None');
title('b. Environmental','fontSize',20);
ylim([0,1])
set(gca,'XTickLabel',RegionNameSSR,'fontSize',12, 'XTickLabelRotation', 0);
xlabel('Self-sufficiency Ratio','fontSize',12,'fontWeight','bold');

 axes(ha(3))
 bb_2 = bar(dimen_total_share_ssr(:,:,1),'stacked','EdgeColor', 'None');
title('c. Economic','fontSize',20);
ylim([0,1])
set(gca,'XTickLabel',RegionNameSSR,'fontSize',12, 'XTickLabelRotation', 0);
xlabel('Self-sufficiency Ratio','fontSize',12,'fontWeight','bold');

  axes(ha(4))
 bb_4 = bar(dimen_total_share_ssr(:,:,3),'stacked','EdgeColor', 'None');
title('d. Social','fontSize',30);

set(gca,'XTickLabel',RegionNameSSR,'fontSize',12, 'XTickLabelRotation', 0);
xlabel('Self-sufficiency Ratio','fontSize',12,'fontWeight','bold');


 for k=1:3
  set(bb_1(k),'facecolor',c(k))
  set(bb_2(k),'facecolor',c(k))
  set(bb_3(k),'facecolor',c(k))
  set(bb_4(k),'facecolor',c(k))
 end

 print([dir_fig_inc, 'SSR aggregation'], '-djpeg');

SSR = SSR .* 100;

save('C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model\SAM_Data\SSR\SSR.mat','SSR');




















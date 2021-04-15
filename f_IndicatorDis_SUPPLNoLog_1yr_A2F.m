function f_IndicatorDis_SUPPLNoLog_1yr(var,var_comp,var_name,L,U,minV,maxV,minVy,maxVy,ylb, xlb,yr2000_t,dir,FAOSTAT_CoABR_ISO,RegionCoName,RegionID,RegionName,fig_n)
Yr=1961:2016;
close all;
%yr2000_t= [40 55];
fig_caption={'a','b'};
for j = 1:length(yr2000_t)
regions = fieldnames(RegionCoName);
colormap = distinguishable_colors(length(regions));
figure;

yr2000 = yr2000_t(j);
for i=1:length(regions)
    idxrgn = RegionID.(regions{i});
    rt = text(var_comp(idxrgn,yr2000),var(idxrgn,yr2000),char(FAOSTAT_CoABR_ISO(idxrgn)),'Color',colormap(i,:),'Fontweight','bold','FontSize',8);
    set(rt,'Rotation',45)
    hold on
    eval(['h' num2str(i) '=plot(NaN,NaN,''s'',''markerfacecolor'',colormap(i,:),''Color'',colormap(i,:),''markersize'',10);']);

end

hold on
thr1 = plot([minV maxV], U.*ones(1,2),'color',[0, 0.5, 0],'linewidth',1); uistack(thr1,'bottom');
thr2 = plot([minV maxV], L.*ones(1,2),'r','linewidth',1); uistack(thr2,'bottom');


ylabel(ylb)
xlabel(xlb);
title(sprintf('(%s) Year %d',char(fig_caption(fig_n)), Yr(yr2000)))
%set(gca,'XtickLabel',[])
%set(gca,'Yscale','log')
set(gca,'Xscale','log')

axis square
set(gca,'fontsize',13)
xlim([minV maxV])
ylim([minVy maxVy])
grid on
legend([h1 h2 h3 h4 h5 h6 h7 h8],RegionName,'fontsize',8,'location','northeastoutside');
end

fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 10 10];
print([dir var_name '_SAMSuppInfo_Fig_' num2str(Yr(yr2000_t(1))) '_FAOabr'],'-dpng','-r200')

end


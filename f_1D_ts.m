function f_1D_ts(hdl,cn, dimName,dimStru,dimN, dim,uniYrs)
set(hdl,'box','off',...
    'Color','k','XColor','k','YColor','k',...   
    'xtick',[1961 1970 1980 1990 2000 2010 2016],'XTickLabel',...
    [1961 1970 1980 1990 2000 2010 2016],'ytick',[0 10 20 30 40 50 60 70 80 90 100],...
    'yTickLabel',[0 10 20 30 40 50 60 70 80 90 100],'xlim',[1961 2016],'ylim',[0 100]);

style_list = ["-o","-*","-^","-p","-d","-s","h"];

pp1 = patch([1961 2016 2016 1961], [200/3 200/3 100 100],'green','EdgeColor','none');
hold on
pp2 = patch([1961 2016 2016 1961], [100/3 100/3 200/3 200/3],'yellow','EdgeColor','none');
hold on
pp3 = patch([1961 2016 2016 1961], [0 0 100/3 100/3],'red','EdgeColor','none');
hold on

    for i = 1:1:dimN
        var = dimStru.(dimName{i})(cn,:);
        plot(uniYrs, var,style_list(i),'MarkerEdgeColor','black',...
        'MarkerFaceColor','black','LineWidth',0.4,'Color','black','MarkerSize',5)
        yind = find(~isnan(var), 1, 'last');
        text(uniYrs(yind)+0.4, var(yind),dimName{i},'FontSize',10)
        hold on;
    end
    
ylabel(dim, 'FontSize', 14,'FontWeight','bold','Rotation',90)
xlabel('Year')

end


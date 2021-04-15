function f_overall_percentage_horizontal(pcg_data)
c = [0 1 0; 
     1 1 0;
     1 0 0
     0.8 0.8 0.8];
 
var_name = {"Water Consumption", "N Surplus","P Surplus","Land Use Change","Greenhouse Gas","Soil Erosion",...
    "Labor Productivity","Finance Access","Price Volatility","Government Support","Trade Openness","Food Loss",...
    "Crop Diversity","Food Affordability","Under-nourishment","Rural Poverty","Gender Gap","Land Right"};

env_n = 6;
econ_n = 6;
soc_n = 6;

figure('units','normalized','outerposition',[0 0 1 1]);
h1 = axes;

b = barh(transpose(pcg_data),'stacked','BarWidth', 1,'EdgeColor', [0.75 0.75 0.75]);
ylim([0.5, 18.5])
xlim([-28,100])
xlabel('Percentage (%)', 'FontSize', 16)
set(h1, 'Ydir', 'reverse')
set(h1,'TickLength',[0 .01])
xticks([0:10:100])
xticklabels({[0:10:100]})
set(h1, 'ytick',[])
set(h1, 'ycolor','none')
set(h1,'XTickLabel',[0 10 20 30 40 50 60 70 80 90 100],'fontsize',16)
%set(h1,'YTickLabel',var_name,'fontsize',16)

line([-28,100],[6.5,6.5],'Color','black','LineWidth',0.8);
line([-28,100],[12.5,12.5],'Color','black','LineWidth',0.8);
line([-28,100],[0.5,0.5],'Color','black','LineWidth',0.8);
line([-28,100],[18.5,18.5],'Color','black','LineWidth',0.8);

 for k=1:4
  set(b(k),'facecolor',c(k,:))
 end

 for i = 1:1:18
    text(-20, i,var_name{i},'FontSize',14);
 end

text(-24,(env_n*4.7/5),'Environmental','FontSize',16,'FontWeight','bold','Rotation',90)
text(-24,(env_n + econ_n*4/5),'Economic','FontSize',16,'FontWeight','bold','Rotation',90)
text(-24,(env_n + econ_n + soc_n*3/4),'Social','FontSize',16,'FontWeight','bold','Rotation',90)
end





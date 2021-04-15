%% a function to calculate drivers correlation 
% set up
clear;

projectDir = 'C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model'; dirSep = '\'; 


dataDir = [projectDir, dirSep,'SAM_Data_Outputs',dirSep,'SAM_Scores'];
inputsDir = [projectDir, dirSep, 'Correlations',dirSep, 'Inputs'];
graphsDir = [projectDir, dirSep, 'Correlations',dirSep, 'Graphs'];
resultsDir = [projectDir, dirSep,'Correlations',dirSep, 'Results'];

load([projectDir,dirSep, 'EPI_Regions.mat']);

rgname = fieldnames(RegionID);


for i = 1:1:length(rgname)
    corr.(rgname{i}) = load([resultsDir, dirSep,'SAMcorr_',rgname{i},'.mat']);
end

total_data = load([resultsDir dirSep 'SAMcorr.mat']);

load([dataDir,dirSep, 'Environment_Score_SAM_12012019.mat'])  
load([dataDir,dirSep, 'Economic_Score_SAM_12012019.mat'])  
load([dataDir,dirSep, 'Social_Score_SAM_12012019.mat'])  

env_names = transpose(fieldnames(Env_S));
eco_names = transpose(fieldnames(Econ_S));
soc_names = transpose(fieldnames(Social_S));

SAM_var_names = horzcat(env_names,eco_names,soc_names);

tradeoffsyn_frac = nan(18,18,8);

% the order is different from 
for i = 1:1:length(rgname)
    tradeoffsyn_frac(:,:,i) = squeeze(corr.(rgname{i}).SAMdriver_corr(:,:,2))./squeeze(corr.(rgname{i}).SAMdriver_corr(:,:,4));  
end

tradeoff_insig = total_data.SAMdriver_corr(:,:,4)./ (total_data.SAMdriver_corr(:,:,3) + total_data.SAMdriver_corr(:,:,4));

colorMap = distinguishable_colors(length(rgname));


n = 18;

var_name = {"Water \nConsumption", "N \nSurplus","P \nSurplus","Land Use \nChange","Greenhouse \nGas","Soil \nErosion",...
    "Labor \nProductivity","Finance \nAccess","Price \nVolatility","Government \nSupport","Trade \nOpenness","Food \nLoss",...
    "Crop \nDiversity","Food \nAffordability","Under-\nnourishment","Rural \nPoverty","Gender \nGap","Land \nRight"};


figure('units','normalized','outerposition',[0.25 0 0.5 1]);
ha = tight_subplot(n,n,[.01 .01],[.01 .01],[.01 .01]);
for j = 1:1:n
    for i = j:1:n
    % for i = 1:1:n
    k = (i - 1) * n + j;
        if i ~= j           
            axes(ha(k));
            p(k) = plot([1:8],squeeze(tradeoffsyn_frac(i,j,:)),'-','color',[0.75 0.75 0.75]);
            hold on
            s(k) = scatter([1:8],squeeze(tradeoffsyn_frac(i,j,:)),24* ones(8, 1),colorMap,'filled');
            hold on
            p1(k) = plot([1:8],[0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5],'-','color',[0.8500 0.3250 0.0980]);
            xlim([1,8]);
            ylim([0,1]);
            set(ha(k),'box','on','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])  
            if tradeoff_insig(i,j)>=0.5
                set(ha(k),'color', [0.06, 0.06, 0.06])
            end
        else
            axes(ha(k)) 
            %p(k) = plot([1:4],squeeze(tradeoffsyn_frac(i,j,:)),strcat('-','o'));
            hold on;           
            text(0.1, 0.6, sprintf(var_name{i}),'FontWeight','bold')
            set(ha(k),'XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])
            set(ha(k), 'visible', 'off')
        end           
        %set(ha(k), 'visible', 'off')
        hold on;
    end
end

for i = 1:1:n
    for j = i+1:1:n
        k = (i - 1) * n + j;
        axes(ha(k));
        set(ha(k), 'visible', 'off')
    end 
end
hold off
print([graphsDir dirSep 'Correlation_SAM_reg_reverse'], '-djpeg');

m = transpose([1: -0.1: 0.3]);

figure;
sl = scatter(transpose([1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5]),transpose([1: -0.1: 0.3]),24* ones(8, 1), colorMap,'filled');
hold on
p = plot([1.46, 1.54],[0.2, 0.2],'-','color',[0.8500 0.3250 0.0980]);
xlim([1,2]);
ylim([0,1]);
for i = 1:1:length(rgname)
    r = 9 - i;
    text(1.555, m(r), RegionName{r});
end
text(1.555, 0.2, '50% tradeoff line')

%legend([s(:), p],["High income", "Upper-middle income", "Lower-middle income", "Low income", "50% tradeoff line"])
set(gca, 'box','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])   
set(gca, 'visible','off')
print([graphsDir dirSep 'Correlation_SAM_reg_legend'], '-djpeg');



%% A full matrix figure
tradeoffsyn_frac_full_matrix = tradeoffsyn_frac;
tradeoff_insig_full_matrix = tradeoff_insig;
for i = 1:1:n
    for j = i+1:1:n
        k = (i - 1) * n + j;
        tradeoffsyn_frac_full_matrix(i,j,:) = tradeoffsyn_frac(j,i,:);
        tradeoff_insig_full_matrix(i,j) = tradeoff_insig(j,i);
    end 
end

figure('units','normalized','outerposition',[0.25 0 0.5 1]);
ha = tight_subplot(n,n,[.01 .01],[.01 .01],[.01 .01]);
for j = 1:1:n
    for i = 1:1:n
        k = (i - 1) * n + j;
        if i ~= j           
            axes(ha(k));
            p(k) = plot([1:4],squeeze(tradeoffsyn_frac_full_matrix(i,j,:)),'-','color',[0.75 0.75 0.75]);
            hold on
            s(k) = scatter([1:4],squeeze(tradeoffsyn_frac_full_matrix(i,j,:)),24* ones(4, 1),colorMap,'filled');
            hold on
            p1(k) = plot([1:4],[0.5 0.5 0.5 0.5],'-','color',[0.8500 0.3250 0.0980]);
            xlim([1,4]);
            ylim([0,1]);
            set(ha(k),'box','on','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])  
            if tradeoff_insig_full_matrix(i,j)>=0.5
                set(ha(k),'color', [0.06, 0.06, 0.06])
            end
        else
            axes(ha(k)) 
            %p(k) = plot([1:4],squeeze(tradeoffsyn_frac(i,j,:)),strcat('-','o'));
            hold on;           
            text(0.1, 0.5, SAM_var_names(i),'FontWeight','bold')
            set(ha(k),'XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])
            set(ha(k), 'visible', 'off')
        end           
        %set(ha(k), 'visible', 'off')
        hold on;
    end
end

print([graphsDir dirSep 'Correlation_SAM_Inc_group_full'], '-djpeg');

%% 
% Psur = 3, SER = 6
i = 3;
j = 6;

% AGDP = 7
i = 7;

% GHG = 5
i = 5;
incgroup = ["Low", "Lower-middle", "Upper-middle", "High"];

colorMap2 = [
    0.75 0.75 0.75
    0.75 0.75 0.75
    0.75 0.75 0.75
    0.75 0.75 0.75   
];

var_name = {"Water withdraw", "N surplus","P surplus","Land use change","Greenhouse gas","Soil erosion",...
    "Productivity","Finance access","Price volatility","Government support","Market access","Food loss",...
    "Crop diversity","Food affordability","Under-nourishment","Rural poverty","Gender gap","Land right"}

figure('units','normalized','outerposition',[0.25 0 0.6 1]);

hold on
b = bar([1:4],squeeze(tradeoffsyn_frac_full_matrix(i,j,:)), 'FaceColor', 'c', 'EdgeColor', 'none');
hold on
s = scatter([1:4],squeeze(tradeoffsyn_frac_full_matrix(i,j,:)),80 * ones(4, 1),colorMap2,'filled');
hold on
%p = plot([1:4],squeeze(tradeoffsyn_frac_full_matrix(i,j,:)),'-','color',[0.75 0.75 0.75]);
%hold on
p1 = plot([0.2 4.8],[0.5 0.5],'-','color',[0.8500 0.3250 0.0980]);

xlim([0.5,4.5]);
ylim([0,1]);
set(gca,'box','on','XTickLabel',incgroup,'XTick',[1,2,3,4],'YTickLabel',{'Synergy','Trade-off'},'YTick',[0.25 0.75],'TickLength',[0 .01],'FontSize', 20)
ytickangle(90)
title(strcat(string(var_name{i})," & ",string(var_name{j})),'fontsize',30)


%% Pairwise correlation figure ##### Important ALL correlations 01192021

max_var = 18;
posi_corr=reshape(total_data.SAMdriver_corr(:,:,1),max_var,max_var);
nega_corr=reshape(total_data.SAMdriver_corr(:,:,4),max_var,max_var);
nonNaN_corr=reshape(total_data.SAMdriver_corr(:,:,5),max_var,max_var);
total_corr = ones(max_var,max_var);

figure('units','normalized','outerposition',[0.25 0 0.5 1]);
n = 18;
ha = tight_subplot(n,n,[.01 .01],[.01 .01],[.01 .01]);
for j = 1:1:n
    for i = j:1:n
    % for i = 1:1:n
    k = (i - 1) * n + j;
        if i ~= j           
            axes(ha(k));
            b_t(k) = bar(0.5,total_corr(i,j),'FaceColor', [0.85 0.85 0.85],'EdgeColor', [0.85 0.85 0.85],'BarWidth',1);
            hold on
            b_i(k) = bar(0.5,nonNaN_corr(i,j),'FaceColor','y','EdgeColor','y','BarWidth',1);
            hold on
            b_n(k) = bar(0.5,nega_corr(i,j),'FaceColor','b','EdgeColor','b','BarWidth',1);
            hold on
            b_p(k) = bar(0.5,posi_corr(i,j),'FaceColor',[0.968627451 0.533333333 0.098039216],'EdgeColor',[0.968627451 0.533333333 0.098039216],'BarWidth',1);
           
            xlim([0,1]);
            ylim([0,1]);
            set(ha(k),'box','on','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])  

        else
            axes(ha(k)) 
            %p(k) = plot([1:4],squeeze(tradeoffsyn_frac(i,j,:)),strcat('-','o'));
            hold on;           
            text(0.1, 0.5, sprintf(var_name{i}),'FontWeight','bold')
            set(ha(k),'XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])
            set(ha(k), 'visible', 'off')
        end           
        %set(ha(k), 'visible', 'off')
        hold on;
    end
end

for i = 1:1:n
    for j = i+1:1:n
        k = (i - 1) * n + j;
        axes(ha(k));
        set(ha(k), 'visible', 'off')
    end 
end
hold off
print([graphsDir dirSep 'Correlation_SAM_01192021_reverse'], '-djpeg');

colorMap2 = [
    0.968627451 0.533333333 0.098039216
    0 0 1
    1 1 0
    0.85 0.85 0.85    
];


figure;
yyy = transpose([0.8: -0.1: 0.5]);
hold on
for l = 1:1:4
    p = plot([1.46-0.1, 1.54- 0.1],[yyy(l) yyy(l)],'-','color',colorMap2(l,:),'LineWidth',10);
    hold on
end
xlim([1,2]);
ylim([0,1]);
text(1.555 - 0.1, 0.5, 'No data')
text(1.555  - 0.1, 0.6, 'Insignificant correlations')
text(1.555 - 0.1, 0.7, 'Significant negative correlations (Tradeoffs)')
text(1.555 - 0.1, 0.8, 'Significant positive correlations (Synergies)')
set(gca, 'box','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[]) 

set(gca, 'visible','off')
print([graphsDir dirSep 'Correlation_SAM_legend05132020'], '-djpeg');

%% A new horizontal legend
xxx = [1.1 4.5
       1.1 4.5]
   
yyy = [0.8  0.8
       0.7  0.7];
figure;
hold on
for l = 1:1:4
    p = plot([xxx(l) xxx(l)+0.2],[yyy(l) yyy(l)],'-','color',colorMap2(l,:),'LineWidth',10);
    hold on
end
xlim([0.8,6]);
ylim([0,1]);
text(xxx(4) + 0.25, yyy(4), 'No data')
text(xxx(3) + 0.25, yyy(3), 'Insignificant correlations')
text(xxx(2) + 0.25, yyy(2), 'Significant negative correlations (Tradeoffs)')
text(xxx(1) + 0.25, yyy(1), 'Significant positive correlations (Synergies)')
set(gca, 'box','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[]) 

set(gca, 'visible','off')
print([graphsDir dirSep 'Correlation_SAM_legend06112020'], '-djpeg');

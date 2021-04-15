%% a function to calculate drivers correlation 
% set up
clear;

projectDir = 'C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model'; dirSep = '\'; 


dataDir = [projectDir, dirSep,'SAM_Data_Outputs',dirSep,'SAM_Scores'];
inputsDir = [projectDir, dirSep, 'Correlations',dirSep, 'Inputs'];
graphsDir = [projectDir, dirSep, 'Correlations',dirSep, 'Graphs'];
resultsDir = [projectDir, dirSep,'Correlations',dirSep, 'Results'];

highinc_data = load([resultsDir dirSep 'SAMcorr_highinc.mat']);
upmidinc_data = load([resultsDir dirSep 'SAMcorr_upmidinc.mat']);
lowmidinc_data = load([resultsDir dirSep 'SAMcorr_lowmidinc.mat']);
lowinc_data = load([resultsDir dirSep 'SAMcorr_lowinc.mat']);
total_data = load([resultsDir dirSep 'SAMcorr.mat']);

load([dataDir,dirSep, 'Environment_Score_SAM_12012019.mat'])  
load([dataDir,dirSep, 'Economic_Score_SAM_12012019.mat'])  
load([dataDir,dirSep, 'Social_Score_SAM_12012019.mat'])  

env_names = transpose(fieldnames(Env_S));
eco_names = transpose(fieldnames(Econ_S));
soc_names = transpose(fieldnames(Social_S));

SAM_var_names = horzcat(env_names,eco_names,soc_names);

tradeoffsyn_frac = nan(17,17,4);
% the order is different from 
tradeoffsyn_frac(:,:,4) = squeeze(highinc_data.SAMdriver_corr(:,:,2))./squeeze(highinc_data.SAMdriver_corr(:,:,4));
tradeoffsyn_frac(:,:,3) = squeeze(upmidinc_data.SAMdriver_corr(:,:,2))./squeeze(upmidinc_data.SAMdriver_corr(:,:,4));
tradeoffsyn_frac(:,:,2) = squeeze(lowmidinc_data.SAMdriver_corr(:,:,2))./squeeze(lowmidinc_data.SAMdriver_corr(:,:,4));
tradeoffsyn_frac(:,:,1) = squeeze(lowinc_data.SAMdriver_corr(:,:,2))./squeeze(lowinc_data.SAMdriver_corr(:,:,4));

tradeoff_insig = total_data.SAMdriver_corr(:,:,4)./ (total_data.SAMdriver_corr(:,:,3) + total_data.SAMdriver_corr(:,:,4));

colorMap = [
    1 0 0 %red
    1 0 1 %m
    0 1 1 %c
    0 1 0 %g         
];

colorMap = [
    0 1 1 %c
    0 1 1 %c
    0 1 1 %c
    0 1 1 %c       
];



incomegroup = ["Low Income", "Lower Middle Income", "Upper Middle Income", "High Income"];

n = 17;

figure('units','normalized','outerposition',[0.25 0 0.5 1]);
ha = tight_subplot(n,n,[.01 .01],[.01 .01],[.01 .01]);
for j = 1:1:n
    for i = j:1:n
    % for i = 1:1:n
    k = (i - 1) * n + j;
        if i ~= j           
            axes(ha(k));
            hold on
            s(k) = bar([1:4],squeeze(tradeoffsyn_frac(i,j,:)), 'FaceColor', 'c', 'EdgeColor', 'none');
            hold on
            % p(k) = plot([1:4],squeeze(tradeoffsyn_frac(i,j,:)),'-','color',[0.75 0.75 0.75]);
            hold on
            p1(k) = plot([0.2 4.8],[0.5 0.5],'-','color',[0.8500 0.3250 0.0980]);
            xlim([0.2,4.8]);
            ylim([0,1]);
            set(ha(k),'box','on','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])  
            if tradeoff_insig(i,j)>=0.5
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

for i = 1:1:n
    for j = i+1:1:n
        k = (i - 1) * n + j;
        axes(ha(k));
        set(ha(k), 'visible', 'off')
    end 
end
hold off
print([graphsDir dirSep 'Correlation_SAM_Inc_group01082021_reverse'], '-djpeg');

colorMap = [
    0 1 0
    0 1 1
    1 0 1
    1 0 0   
];

figure;
sl = scatter(transpose([1.5,1.5,1.5,1.5]),transpose([0.8: -0.1: 0.5]),24* ones(4, 1), colorMap,'filled');
hold on
p = plot([1.46, 1.54],[0.4, 0.4],'-','color',[0.8500 0.3250 0.0980]);
xlim([1,2]);
ylim([0,1]);
text(1.555, 0.4, '50% tradeoff line')
text(1.555, 0.5, 'High income')
text(1.555, 0.6, 'Upper middle income')
text(1.555, 0.7, 'Lower middle income')
text(1.555, 0.8, 'Low income')
%legend([s(:), p],["High income", "Upper-middle income", "Lower-middle income", "Low income", "50% tradeoff line"])
set(gca, 'box','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])   
set(gca, 'visible','off')
print([graphsDir dirSep 'Correlation_SAM_Inc_group_legend01082021_reverse'], '-djpeg');



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
incgroup = ["Low", "LMid", "UMid", "High"];

figure('units','normalized','outerposition',[0.25 0 0.5 1]);

p = plot([1:4],squeeze(tradeoffsyn_frac_full_matrix(i,j,:)),'-','color',[0.75 0.75 0.75]);
hold on
s = scatter([1:4],squeeze(tradeoffsyn_frac_full_matrix(i,j,:)),700 * ones(4, 1),colorMap,'filled');
hold on
p1 = plot([1:4],[0.5 0.5 0.5 0.5],'-','color',[0.8500 0.3250 0.0980]);
xlim([1,4]);
ylim([0,1]);
set(gca,'box','on','XTickLabel',incgroup,'XTick',[1,2,3,4],'YTickLabel',[],'YTick',[],'fontsize',30) 
title('SER & AGDP','fontsize',60)


%% Pairwise correlation figure
max_var = 17;
posi_corr=reshape(total_data.SAMdriver_corr(:,:,1),max_var,max_var);
nega_corr=reshape(total_data.SAMdriver_corr(:,:,4),max_var,max_var);
nonNaN_corr=reshape(total_data.SAMdriver_corr(:,:,5),max_var,max_var);
total_corr = ones(max_var,max_var);

figure('units','normalized','outerposition',[0.25 0 0.5 1]);
n = 17;
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
            text(0.1, 0.5, SAM_var_names(i),'FontWeight','bold')
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
print([graphsDir dirSep 'Correlation_SAM_01082021_reverse'], '-djpeg');

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
print([graphsDir dirSep 'Correlation_SAM_legend01082021'], '-djpeg');

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

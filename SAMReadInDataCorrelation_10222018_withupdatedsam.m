%% a function to calculate drivers correlation 
% set up
projectDir = 'C:\Users\gyao\Google Drive\ZhangLabData08222019\SAM\SAM_Model'; dirSep = '\'; 
%projectDir = 'C:\Users\tanzo\Downloads\SAM\SAM_2018'; dirSep = '\'; 
%projectDir='/Users/zoutan/Downloads'; dirSep = '/'; 

dataDir = [projectDir, dirSep,'SAM_Data_Outputs',dirSep,'SAM_Scores'];
inputsDir = [projectDir, dirSep, 'Correlations',dirSep, 'Inputs'];
graphsDir = [projectDir, dirSep, 'Correlations',dirSep, 'Graphs'];
resultsDir = [projectDir, dirSep,'Correlations',dirSep, 'Results'];

%% load data
load([projectDir,dirSep, 'basic_FAO_SAM.mat'])
load([inputsDir,dirSep, 'projectIndexDefinitions.mat'])  
load([inputsDir,dirSep, '114CountryGroup.mat'])
load([dataDir,dirSep, 'Environment_Score_SAM_12012019.mat'])  
load([dataDir,dirSep, 'Economic_Score_SAM_12012019.mat'])  
load([dataDir,dirSep, 'Social_Score_SAM_12012019.mat'])  


%% set up matrix for analysis 
% new matrix for correlation test 
clear Co_ID_group0 Co_ID_group YrSet coN yrN

% Co_ID_group=1:218;
Co_ID_group0=Co_ID_group_X(1:113);

%%% Guolin 05292019 added: exclude regions with harvested area < 1000 km2
AreaH_FAO_sum = squeeze(nansum(AreaH_FAO,2));
AreaH_FAO_mean = nanmean(AreaH_FAO_sum,2);
AreaH_FAO_GT1000 = find(AreaH_FAO_mean>1000);

Co_ID_group = intersect(Co_ID_group0,AreaH_FAO_GT1000);
Co_group_names0 = Co_group_names;
clear Co_group_names;
Co_group_names = FAOSTAT_CoName_FAO(Co_ID_group);

YrSet=1:56; % if all years, corr result is nan, Since 1991 (33-55: 1993-2015)
%YrSet=48:54; % if all years, corr result is nan, Since 2008
coN=length(Co_ID_group);
yrN=length(YrSet);

env_Size = length(fieldnames(Env_S));
econ_Size = length(fieldnames(Econ_S));
soc_Size = length(fieldnames(Social_S));
n_Size = env_Size + econ_Size + soc_Size;
% read in new drivers
clear SAM_var
SAM_var1(1:env_Size) = struct2cell(Env_S);
SAM_var1(env_Size+1:env_Size + econ_Size) = struct2cell(Econ_S);
SAM_var1(env_Size + econ_Size + 1:n_Size) = struct2cell(Social_S);

for i = 1:1:n_Size
     temp = SAM_var1{i};
     SAM_var{i} = temp(Co_ID_group,YrSet);   
end

env_names = transpose(fieldnames(Env_S));
eco_names = transpose(fieldnames(Econ_S));
soc_names = transpose(fieldnames(Social_S));

SAM_var_names = horzcat(env_names,eco_names,soc_names);


% use driver subset to test
clear x_group varN eleN SAM_var2 SAM_var_names2
x_group = [1:n_Size]; % change number here!!!!!!
varN = length(x_group); % var number of subset, 21 
eleN=numel(SAM_var{1}); % 6102

for i =1:1:varN
    SAM_var2{i} = SAM_var{x_group(i)}; % varN cells coN*yrN
end 
SAM_var_names2 = SAM_var_names(x_group);

% calculate data availability
clear SAMdriver_avai
SAMdriver_avai=nan(varN,varN);
for i = 1:1:varN
    for j = 1:1:varN
        clear X Y count
        X=SAM_var2{i}; 
        Y=SAM_var2{j}; 
        count=0;
        for k = 1:1:eleN
            if isnan(X(k))==0 && isnan(Y(k))==0
                count=count+1;
            end 
        end 
        SAMdriver_avai(i,j)=count/eleN;
    end
end

% identify and exclude countries that do not meet standards 
% We carry out the correlation analysis only with the data pairs consisting of more than three data points
% check the driver availability matrix

% for each driver pair in each country
SAMdriver_avai_co=nan(length(Co_ID_group), varN,varN);
for i = 1:1:varN
    for j = 1:1:varN
        for k=1:1:length(Co_ID_group)
            clear X Y count
            X=SAM_var2{i}; X=X(k, :);
            Y=SAM_var2{j}; Y=Y(k, :);
            count=0;
            for anum = 1:1:length(X)
                if isnan(X(anum))==0 && isnan(Y(anum))==0
                    count=count+1;
                end
            end
            SAMdriver_avai_co(k, i,j)=count;
            % SAMdriver_avai_co(k, i,j)=count/length(X);
        end
    end
end

%% Spearman's Rho and p value between differen drivers for individual countries 
% Group into 2 groups: p<0.05 and corr >0, and p<0.05 and corr <0, take hours to calculate 
% https://www.mathworks.com/help/stats/corr.html 
clear SAMdriver_corr 
SAMdriver_corr = nan(varN, varN, 5);

tic
for i = 2:1:varN
    for j = 1:1:(i-1)
        rprp=driver_corr_10222018(Co_ID_group, SAM_var2, SAMdriver_avai_co, i, j, 0); % 113*3
        %show country name that have strongly positive correlation
        %FAOSTAT_CoName_FAO(Co_ID_group(find(rprp(:,5)==1)))
        % percentage of countries that have significant positive correlation
        
        SAMdriver_corr(i,j,1) = length(find(rprp(:,3)==1))/length(Co_ID_group);
        % percentage of countries that have significant negative correlation
        SAMdriver_corr(i,j,2) = length(find(rprp(:,3)==0))/length(Co_ID_group);
        % percentage of countries that have insignificant result or significant 0 correlation 
        SAMdriver_corr(i,j,3) = length(find(rprp(:,3)==2))/length(Co_ID_group);
        % percentage of countries that have significant positive or negative correlation
        SAMdriver_corr(i,j,4) = nansum([SAMdriver_corr(i,j,1) SAMdriver_corr(i,j,2)]);
        % percentage of countries that have non nan correlation
        SAMdriver_corr(i,j,5) = nansum([SAMdriver_corr(i,j,1) SAMdriver_corr(i,j,2) SAMdriver_corr(i,j,3)]);
    end
end  
toc

%%% A report table %%%
SAMdriver_corr_NO = SAMdriver_corr .* length(Co_ID_group);
c = 0;
tc = (varN * varN - varN)/2;
corr_pair = nan(tc,4);
clear name_pair;
for i = 1:1:varN-1
    for j = (i + 1):1:varN
        c = c + 1;
        namei = SAM_var_names(i);
        namej = SAM_var_names(j);
        name_pair(c,1) = strcat(namei, " & ", namej); 
        corr_pair(c,1) = SAMdriver_corr_NO(j,i,1);
        corr_pair(c,2) = SAMdriver_corr_NO(j,i,2);
        corr_pair(c,3) = SAMdriver_corr_NO(j,i,3);
        corr_pair(c,4) = nansum([corr_pair(c,1) corr_pair(c,2) corr_pair(c,3)]);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%


%double check data 
test = SAMdriver_corr(:,:,1); test=squeeze(test);
test = SAMdriver_corr(:,:,2); test=squeeze(test);
test = SAMdriver_corr(:,:,3); test=squeeze(test);
test = SAMdriver_corr(:,:,4); test=squeeze(test);
test = SAMdriver_corr(:,:,5); test=squeeze(test);

%% save data
clear SAMxy_CorrVar SAMxy_var_CorrN
SAMxy_CorrVar = SAM_var2;
SAMxy_var_CorrN = SAM_var_names2;


%% test correlation of all countries and years
% stack matrix 
Yrs = 1961:2015;
clear N X P_CoID P_CoName P_year y P_ynames P_xnames P_xynames   
N=coN*yrN; %country count * year length 
X=nan(N, varN); % (co*yrN, variable number)
P_CoID = repelem(Co_ID_group,yrN)'; % country ID list for panel function, N*1
P_CoName = repelem(FAOSTAT_CoName_FAO(Co_ID_group),yrN); % country namelist for panel function, N*1
P_year = repmat(Yrs, 1,coN)'; % year list for 54 countries for panel function, N*1
for i =1:1:varN
    X(:,i) = reshape(SAM_var{i}',N,1); 
end 

indicatScore= cell2struct(SAM_var,SAM_var_names,2);


SAM_var_names
clear AllVarRho AllVarPval
[AllVarRho,AllVarPval] = corr(X, 'Type', 'Spearman', 'Rows', 'pairwise'); 


save([resultsDir dirSep 'SAMcorr.mat'], 'indicatScore','SAMxy_CorrVar','SAMxy_var_CorrN',...
    'SAMdriver_avai','SAMdriver_avai_co','SAMdriver_corr','AllVarRho','AllVarPval')

%% Plot correlations
Plot_Synergy_Tradeoff(SAMdriver_corr,SAMdriver_avai,SAM_var_names)

print([graphsDir dirSep 'Correlation_SAM_04282020'], '-djpeg');

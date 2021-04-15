function [SAM_overall] = f_patch_score_sensitivity(SAM_all, yrstart, yrend)

    uniYrs = 1961:2016;

    uniyrstart = find(uniYrs == yrstart);
    uniyrend = find(uniYrs == yrend);


    Env_pollution = nanmean(SAM_all(2:3,:,:),1);
    Soc_resilience = nanmean(SAM_all(13:14,:,:),1);

    SAM_BA = nan(16, 218, 56);


    SAM_BA(1,:,:) = SAM_BA(1, 218, 56);
    SAM_BA(2,:,:) = Env_pollution;
    
    for i = 3:1:11
        SAM_BA(i,:,:) = SAM_all(i+1,:,:);
    end
    
    SAM_BA(12,:,:) = Soc_resilience;
    
    for i = 13:1:16
        SAM_BA(i,:,:) = SAM_all(i+2,:,:);
    end

    % SAM_BA_yr = nanmean(SAM_BA(:,:,uniyrstart: uniyrend),3);

    SAM_env = nanmean(SAM_BA(1:5,:,:),1);
    SAM_econ = nanmean(SAM_BA(6:11,:,:),1);
    SAM_soc = nanmean(SAM_BA(12:16,:,:),1);
    
    SAM_env(SAM_env == 0) = nan;
    SAM_econ(SAM_econ == 0) = nan;
    SAM_soc(SAM_econ == 0) = nan;

    SAM_comb = nan(3,218,56);
    SAM_comb(1,:,:) = SAM_env;
    SAM_comb(2,:,:) = SAM_econ;
    SAM_comb(3,:,:) = SAM_soc;
    
    SAM_overall = transpose(nanmean(nanmean(SAM_comb(:,:,uniyrstart:uniyrend),1),3));
    SAM_overall(SAM_overall == 0) = nan;
     
end


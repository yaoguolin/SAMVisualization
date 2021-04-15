function f_3D_ts(cn, EnvSB, EconSB, SocSB, uniYrs, cn_name)



[All,varName_all,envName,econName,socName,envN,econN,socN,n] = combIndicator_f(EnvSB,EconSB,SocSB);


figure;
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.4, 1]);
ha = tight_subplot(3,1,[.05 .1],[.05 .05],[.1 .1]);
axes(ha(1));
f_1D_ts(ha(1),cn,envName,EnvSB,envN,'Environment',uniYrs);
title(cn_name,'FontSize', 16);

axes(ha(2));
f_1D_ts(ha(2),cn,econName,EconSB,econN,'Economic',uniYrs);

axes(ha(3));
f_1D_ts(ha(3),cn,socName,SocSB,socN,'Social',uniYrs);

set(gcf,'color','w');
set(gcf, 'InvertHardcopy', 'off')

hold off
end


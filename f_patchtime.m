function f_patchtime(db, env, econ,soc, Yrs, co_n, co_name, var_name, space)

uniYrs = 1961:2016;
[All,varName_all,envName,econName,socName,envN,econN,socN,n] = combIndicator_f(env,econ,soc);

envV = n - envN;
econV = envV - econN;
socV = econV - socN;

YrN = length(Yrs);

YrS = Yrs(1);
YrE = Yrs(YrN);

uYrS = find(uniYrs == YrS);
uYrE = find(uniYrs == YrE);


SAM_co = nan(n+1, YrN+1+1);
SAM_co_reverse = nan(n+1, YrN+1+1);

for i = 1:1:n
    SAM_co(i,1:YrN) = db.(varName_all{i})(co_n,uYrS:uYrE);
    SAM_co(i,YrN+1) = 0;
    SAM_co_reverse(n-i+1, 1:YrN) = db.(varName_all{i})(co_n,uYrS:uYrE); % used in assinging color
    SAM_co_reverse(n-i+1, YrN+1) = 0;
end


vec = [      100;       84;       67;       50;       33;       17;        0];
hex = ['#00ff00';'#7bff00';'#ccff00';'#ffff00';'#ffb300';'#ff8000';'#ff0000'];
raw = sscanf(hex','#%2x%2x%2x',[3,size(hex,1)]).' / 255;
N = 100;
%N = size(get(gcf,'colormap'),1) % size of the current colormap
map = interp1(vec,raw,linspace(0,100,N),'pchip');

close all;
figure('units','normalized','outerposition',[0 0 1 1]);

h = pcolor(SAM_co_reverse);
h.EdgeColor = [0.7 0.7 0.7];
colormap(map)
c = colorbar('southoutside');
c.Label.FontSize = 14;
xticks([1 space:space:YrN YrN]+0.5)
xticklabels({Yrs([1 space:space:YrN YrN])})
yticks([1:1:n]+0.5)
yticklabels(flip(varName_all))

set(gca,'TickLength',[0 0])
set(gca, 'ytick',[])
set(gca, 'ycolor','none')
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',16)

lowlim = (Yrs(1) - 1961)/6;

xlim([-13 + lowlim, YrN+1])
line([-13+ lowlim,YrN+1],[n+1,n+1],'Color','black','LineWidth',1.1);
line([-13+ lowlim,YrN+1],[envV,envV]+1,'Color','black','LineWidth',1.1);
line([-13+ lowlim,YrN+1],[econV,econV]+1,'Color','black','LineWidth',1.1);
line([-13+ lowlim,YrN+1],[socV,socV]+1,'Color','black','LineWidth',1.1);

for i = 1:1:n
    text(-10.8+ lowlim,0.5+i,var_name{n+1-i},'FontSize',16);
end

text(-12+ lowlim,(n+1-envN*4.7/5),'Environmental','FontSize',18,'FontWeight','bold','Rotation',90)
text(-12+ lowlim,(envV+1-econN*4/5),'Economic','FontSize',18,'FontWeight','bold','Rotation',90)
text(-12+ lowlim,(econV+1-socN*3/5),'Social','FontSize',18,'FontWeight','bold','Rotation',90)
title(co_name, 'FontSize', 36, 'FontWeight','bold')

end


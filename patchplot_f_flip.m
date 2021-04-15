function  [varX, varY] = patchplot_f_flip(env,econ,soc,envnameL,econnameL,socnameL,L,U,a,b,yrIndex,coIndex,coList)

% L lower threshold
% U upper threshold
% a magnitude of x axis a = 1
% b magnitude of y axis b = 1
uniYrs = 1961:2016;
    c = [
             1      0      0 %red
             %0.9290 0.6940 0.1250 %// yellow
             1      1      0 
             0      1      0 %//green
             ]
         
         
     dimc = [
            1 1 0.7;...     %%yellow
            0.7 0.87 0.41;... %%green
            0.98 0.5 0.45]; %%red


     
     yrN = length(yrIndex);
     %pointc = fliplr(jet(length(yrIndex)));
     pointc =   flipud(gray(yrN+1));
     %pointc =   gray(yrN+1);
     %ptSize = linspace(220,100,yrN);
     pointalpha = linspace(0.1+0.9/yrN,1,yrN);

varName_long = horzcat(envnameL,econnameL,socnameL);

[All,varName_all,envName,econName,socName,envN,econN,socN,n] = combIndicator_f(env,econ,soc);


    envV = n - envN;
    econV = envV - econN;
    socV = econV - socN;

    figure('units','normalized','outerposition',[0 0 1 1]);
    %%% dimensioin color
   % patch([-3.5*a 0 0 -3.5*a],[envV envV n n].*b,dimc(1,:),'EdgeColor',dimc(1,:))
   % patch([-3.5*a 0 0 -3.5*a],[econV econV envV envV].*b,dimc(2,:),'EdgeColor',dimc(2,:))
   % patch([-3.5*a 0 0 -3.5*a],[socV socV econV econV].*b,dimc(3,:),'EdgeColor',dimc(3,:))

    %%% generate dimension names
    %text(13.8*a,(n-envN/2)*b,'Environmental','FontSize',15,'Rotation',90)
    %text(13.8*a,(envV-econN/2)*b,'Economic','FontSize',15,'Rotation',90)
    %text(13.8*a,(econV-socN/2)*b,'Social','FontSize',15,'Rotation',90)
    
    text(13.8*a,(n-envN*4.5/5)*b,'Environmental','FontSize',15,'Rotation',90)
    text(13.8*a,(envV-econN*4/5)*b,'Economic','FontSize',15,'Rotation',90)
    text(13.8*a,(econV-socN*3/5)*b,'Social','FontSize',15,'Rotation',90)


%%% create a patchplot for each indicator's dimensions
    for i = 1:1:n
        x(1,:,i) = [0 L(n+1-i) L(n+1-i) 0];
        x(2,:,i) = [L(n+1-i) U(n+1-i) U(n+1-i) L(n+1-i)];
        x(3,:,i) = [U(n+1-i) 10*a 10*a U(n+1-i)];

        y(1,:,i) = [0+(i-1)*b 0+(i-1)*b i*b i*b];
        y(2,:,i) = [0+(i-1)*b 0+(i-1)*b i*b i*b];
        y(3,:,i) = [0+(i-1)*b 0+(i-1)*b i*b i*b];

        for m = 1:1:3
            xx = squeeze(x(m,:,i));
            yy = squeeze(y(m,:,i));
            p(m) = patch(xx,yy,c(m,:));
            hold on
        end
        %%% variable name for each indicator
        text(12.7*a,0.5*b+(i-1)*b,varName_long(n+1-i),'FontSize',12);
        
        %%% scatter plot for points in different years

    end

    line([0,14*a],[n,n]*b,'Color','black','LineWidth',1.1);
    line([0,14*a],[envV,envV]*b,'Color','black','LineWidth',1.1);
    line([0,14*a],[econV,econV]*b,'Color','black','LineWidth',1.1);
    line([0,14*a],[socV,socV]*b,'Color','black','LineWidth',1.1);
    
    %%scale points
    for i = 1:1:n
        varX(n+1-i,1:yrN) = All.(varName_all{i})(coIndex,yrIndex);
        varY(i,1:yrN) = (0.5+i-1)*b;
    end
        for pt = 1:1:yrN
        %s(pt) = scatter(varX(:,pt),varY(:,pt), ptSize(pt), 'MarkerFaceColor', [0 0 0]+(1/yrN)*pt, 'MarkerFaceAlpha', 0.6, 'MarkerEdgeColor', 'black', 'MarkerEdgeAlpha', 0.8, 'LineWidth', 0.1);
        %s(pt) = scatter(varX(:,pt),varY(:,pt),ptSize(pt), 'MarkerFaceColor', pointc(pt+1,:), 'MarkerFaceAlpha', 1, 'MarkerEdgeColor', pointc(pt+1,:), 'MarkerEdgeAlpha', 0.8, 'LineWidth', 0.1);
        %s(pt) = scatter(varX(:,pt),varY(:,pt),ptSize(pt), 'MarkerFaceColor', pointc(pt,:), 'MarkerFaceAlpha', 1, 'MarkerEdgeColor', pointc(pt+1,:), 'MarkerEdgeAlpha', 0.8, 'LineWidth', 0.1);
        s(pt) = scatter(varX(:,pt),varY(:,pt),180, 'MarkerFaceColor', pointc(pt+1,:), 'MarkerFaceAlpha',pointalpha(pt), 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 1, 'LineWidth', 0.1);

        end
        
    hold off
 set(gca, 'XDir','reverse')   
 set(gca,'ytick',[]);
 set(gca,'ycolor',[1 1 1]);
 set(gca,'XLim',[0,14*a]);
 set(gca,'YLim',[0, n*b]);
 
 xticks([0 10 20 30 40 50 60 70 80 90 100])
 %xticklabels({'x = 0','x = 5','x = 10'})
  yrTitle = string(uniYrs(yrIndex));
  pTitle = ["Above planetary boundaries","Within planetary boundaries","Below planetary boundaries"];
  LegTitle = horzcat(yrTitle,pTitle);
  hLeg = legend([s,p(3),p(2),p(1)],LegTitle);
   %set(hLeg, 'position', [0.1 0.16 0.05 0.14], 'FontSize', 15)
  %set(hLeg,'Location', 'northeastoutside', 'FontSize', 12)
    set(hLeg,'Location', 'southoutside','Orientation','horizontal', 'FontSize', 12)
  title(coList(coIndex),'FontSize',40)
end


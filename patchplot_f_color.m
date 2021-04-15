function  [varX, varY] = patchplot_f_color(env,econ,soc,envnameL,econnameL,socnameL,L,U,a,b,yrIndex,coIndex,coList)

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
         
    % color map with green [0 1 0] and blue [0 0 1] on the edges
    C1 = colorGradient([1 0 0],[1 0.7 0], 100); 
    % red to orange (overridden by next line)
    C2 = colorGradient([1 0.7 0],[0.7 1 0], 100); % orange to yellowgreen
    C3= colorGradient([0.7 1 0],[0 1 0], 100); % yellowgreen to green

         
        


     
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
    
    
    % color
    

    figure('units','normalized','outerposition',[0 0 1 1]);
    %%% dimensioin color
   % patch([-3.5*a 0 0 -3.5*a],[envV envV n n].*b,dimc(1,:),'EdgeColor',dimc(1,:))
   % patch([-3.5*a 0 0 -3.5*a],[econV econV envV envV].*b,dimc(2,:),'EdgeColor',dimc(2,:))
   % patch([-3.5*a 0 0 -3.5*a],[socV socV econV econV].*b,dimc(3,:),'EdgeColor',dimc(3,:))

    %%% generate dimension names
    %text(13.8*a,(n-envN/2)*b,'Environmental','FontSize',15,'Rotation',90)
    %text(13.8*a,(envV-econN/2)*b,'Economic','FontSize',15,'Rotation',90)
    %text(13.8*a,(econV-socN/2)*b,'Social','FontSize',15,'Rotation',90)
    mtp = -2.0;
    
    ax1=axes('box','off',...
    'Color','none','XColor','k','YColor','none',...   
    'xtick',[],'ytick',[],'xlim',[mtp*a,10*a],'ylim',[0 n*b]);
    ax2=axes('box','off',...
    'Color','none','XColor','k','YColor','none',...   
    'xtick',[],'ytick',[],'xlim',[mtp*a,10*a],'ylim',[0 n*b]);

    ax3=axes('box','off',...
    'Color','none','XColor','k','YColor','none',...   
    'XTick',[],'XTickLabel',[0 10 20 30 40 50 60 70 80 90 100],'ytick',[],'xlim',[mtp*a,10*a],'ylim',[0 n*b]);

    colormap(ax1,C1)
    colormap(ax2,C2)
    colormap(ax3,C3)
    
    
    % text(ax3,-3.3*a,(n-envN*4.5/5)*b,'Environmental','FontSize',15,'Rotation',90)
    % text(ax3,-3.3*a,(envV-econN*4/5)*b,'Economic','FontSize',15,'Rotation',90)
    % text(ax3,-3.3*a,(econV-socN*3/5)*b,'Social','FontSize',15,'Rotation',90)
    
    text(ax3,-1.6*a,(n-envN*4.5/5)*b,'Environmental','FontSize',20,'FontWeight','bold','Rotation',90)
    text(ax3,-1.6*a,(envV-econN*4/5)*b,'Economic','FontSize',20,'FontWeight','bold','Rotation',90)
    text(ax3,-1.6*a,(econV-socN*3/5)*b,'Social','FontSize',20,'FontWeight','bold','Rotation',90)


    

    pp1 = patch(ax1,[0 L(1) L(1) 0],[0 0 n*b n*b],[0 1 1 0],'FaceColor','interp');

    
    hold on;
    pp2 = patch(ax2,[L(1) U(1) U(1) L(1)],[0 0 n*b n*b],[0 1 1 0],'FaceColor','interp');
    
  
    hold on;
    pp3 = patch(ax3,[U(1) 10*a 10*a U(1)],[0 0 n*b n*b],[0 1 1 0],'FaceColor','interp');
    hold on;
 
%%% create a patchplot for each indicator's dimensions
    for i = 1:1:n
        x(1,:,i) = [0 L(n+1-i) L(n+1-i) 0];
        x(2,:,i) = [L(n+1-i) U(n+1-i) U(n+1-i) L(n+1-i)];
        x(3,:,i) = [U(n+1-i) 10*a 10*a U(n+1-i)];

        y(1,:,i) = [0+(i-1)*b 0+(i-1)*b i*b i*b];
        y(2,:,i) = [0+(i-1)*b 0+(i-1)*b i*b i*b];
        y(3,:,i) = [0+(i-1)*b 0+(i-1)*b i*b i*b];
        

        for m = 1:1:3

            % set colormap
            
            
            xx = squeeze(x(m,:,i));
            yy = squeeze(y(m,:,i));
            cc = [0 1 1 0];
            p(m) = patch(ax3,xx,yy,cc,'FaceColor','none');
            hold on
        end
        %%% variable name for each indicator
        % text(ax3,-2.6*a,0.5*b+(i-1)*b,varName_long(n+1-i),'FontSize',12);
        text(ax3,-1*a,0.5*b+(i-1)*b,varName_long(n+1-i),'FontSize',16);
        
        %%% scatter plot for points in different years

    end
    
    % line(ax3,[-3.5*a,n*b],[n,n]*b,'Color','black','LineWidth',1.1);
    % line(ax3,[-3.5*a,n*b],[envV,envV]*b,'Color','black','LineWidth',1.1);
    % line(ax3,[-3.5*a,n*b],[econV,econV]*b,'Color','black','LineWidth',1.1);
    % line(ax3,[-3.5*a,n*b],[socV,socV]*b,'Color','black','LineWidth',1.1);

    line(ax3,[mtp*a,n*b],[n,n]*b,'Color','black','LineWidth',1.1);
    line(ax3,[mtp*a,n*b],[envV,envV]*b,'Color','black','LineWidth',1.1);
    line(ax3,[mtp*a,n*b],[econV,econV]*b,'Color','black','LineWidth',1.1);
    line(ax3,[mtp*a,n*b],[socV,socV]*b,'Color','black','LineWidth',1.1);
    
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
 %set(gca, 'XDir','reverse')   

 xticks(ax1,[0 10 20 30 40 50 60 70 80 90 100])
 xt = get(ax1,'XTickLabel');  
 set(ax1,'XTickLabel',xt,'fontsize',16)
 %xticklabels({'x = 0','x = 5','x = 10'})
  yrTitle = string(uniYrs(yrIndex));
  pTitle = ["Below the red threshold","Between the green and the red thresholds","Above the green threshold"];
  LegTitle = horzcat(yrTitle,pTitle);
  
  hLeg = legend(ax3,[s,pp1,pp2,pp3],LegTitle,'Position',[0.49 0.04 0.04 0.01],'Orientation','horizontal','FontSize',12);

  %hLeg2 = legend(ax2,[s,pp1,pp2,pp3],LegTitle,'Location','southoutside','Orientation','horizontal','FontSize',12);
  %hLeg3 = legend(ax3,[s,pp1,pp2,pp3],LegTitle,'Location','southoutside','Orientation','horizontal','FontSize',12);

   %set(hLeg, 'position', [0.1 0.16 0.05 0.14], 'FontSize', 15)
  %set(hLeg,'Location', 'northeastoutside', 'FontSize', 12)
   %set(hLeg,'Location', 'southoutside','Orientation','horizontal', 'FontSize', 12)
  title(ax1,coList(coIndex),'FontSize',40)
  title(ax2,coList(coIndex),'FontSize',40)
  title(ax3,coList(coIndex),'FontSize',40)
end


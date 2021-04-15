function f_reportcard_threeLayersLong(cn,env_n,econ_n,soc_n,dim_n,var_n,dimcolrcode,dimlabels,dimsign,varcolrcode,varlabels)
    piecolors = {[0 1 0],[1 1 0],[1 0 0],[0.85 0.85 0.85]};
         


    envSegments = 360 ./ dim_n./env_n;
    ecoSegments = 360 ./ dim_n./econ_n;
    socSegments = 360 ./ dim_n./soc_n;
    
    dimSegments = 360 ./dim_n;
    
    envX = repmat(envSegments,[1,env_n]);
    ecoX = repmat(ecoSegments,[1,econ_n]);
    socX = repmat(socSegments,[1,soc_n]);
    
    X = [ecoX envX socX];
    dimX = repmat(dimSegments,[1,dim_n]);
   
    donutInput{1,1} = dimX;
    donutInput{2,1} = X;
    
    lbtxt{1,1} = dimlabels;
    lbtxt{2,1} = varlabels;
    
    
    for i = 1:1:dim_n
         colrInd = dimcolrcode(cn,i);
         dimcolr{1,i} = piecolors{1,colrInd};
    end
    
    varcolr = {};
    for i = 1:1:var_n
        colrInd = varcolrcode(cn,i);
        varcolr{1,i} = piecolors{1,colrInd};
    end
        
    colr{1,1} = dimcolr;
    colr{2,1} = varcolr;
    
    
    totcolr = piecolors{1,dimcolrcode(cn,4)};
    

    fontSize = 20;
    figure('units','normalized', 'outerposition', [0.1 0.1 0.5 0.75]);
    donout = donut_gy(donutInput,lbtxt,colr);
    hold on;
    h = circle(0,0,1,totcolr,5);
   
    
 %{
    for k = 1:1:4
        s = dimsign(n,k);
        if s == -1
            d = 1;
        elseif s == 1
            d = 3;
        else d = 2;
        end
        annotation('textarrow',xx{k}(d,:),yy{k}(d,:),'LineWidth',3)
    end
  %}
    x = 0; y = 0;
    r = 1 + 1 * 0.5;
    incre = pi / (dim_n * 2);
    ang = 0:incre:2*pi;
 
    xp=r*cos(ang);
    yp=r*sin(ang);
   
    text(x+xp(2)-0.3,y+yp(2)+0.3,'Soc.','FontSize',14,'FontWeight','bold')
    text(x+xp(6)-0.1,y+yp(6)+0.3,'Econ.','FontSize',14,'FontWeight','bold')
    text(x+xp(10)+0.25,y+yp(10)+0.15,'Env.','FontSize',14,'FontWeight','bold')
    
    
    r = 2 + 1 * 0.25;
    incre = pi / 18;
    ang = 0:incre:2*pi;
 
    xp=r*cos(ang);
    yp=r*sin(ang);
    
    %text(x+xp(1),y+yp(1),varlabels(var_n-4),'FontSize',12);
    %text(x+xp(3),y+yp(3)+0.1,varlabels(var_n-3),'FontSize',12);
    %text(x+xp(5),y+yp(5)+0.1,varlabels(var_n-2),'FontSize',12);
    %text(x+xp(7)-0.1,y+yp(7)+0.2,varlabels(var_n-1),'FontSize',12);
    %text(x+xp(9)-0.15,y+yp(9)+0.2,varlabels(var_n-0),'FontSize',12);
    %text(x+xp(length(ang)-2),y+yp(length(ang)-2),varlabels(var_n-5),'FontSize',12);
    
    %text(x+xp(length(ang)-4)-0.1,y+yp(length(ang)-4)-0.2,varlabels(6),'FontSize',12);
    %text(x+xp(length(ang)-6)-0.1,y+yp(length(ang)-6)-0.2,varlabels(5),'FontSize',12);
    %text(x+xp(length(ang)-8)-0.2,y+yp(length(ang)-8)-0.2,varlabels(4),'FontSize',12);
    %text(x+xp(length(ang)-10)-0.2,y+yp(length(ang)-10)-0.2,varlabels(3),'FontSize',12);
    %text(x+xp(length(ang)-12)-0.3,y+yp(length(ang)-12)-0.2,varlabels(2),'FontSize',12);
    %text(x+xp(length(ang)-14)-0.4,y+yp(length(ang)-14)-0.2,varlabels(1),'FontSize',12);

    text(x+xp(1)+0.21,y+yp(1),sprintf('Food \naffordability'),'FontSize',10,'HorizontalAlignment','center','VerticalAlignment','middle');
    text(x+xp(3)+0.24,y+yp(3)+0.05,sprintf('Under- \nnourishment'),'FontSize',10,'Rotation', 15,'HorizontalAlignment','center','VerticalAlignment','middle');
    text(x+xp(5)+0.12,y+yp(5)+0.15,sprintf('Rural \npoverty'),'FontSize',10,'Rotation', 40,'HorizontalAlignment','center','VerticalAlignment','middle');
    text(x+xp(7)+0.12,y+yp(7)+0.15,sprintf('Gender \ngap'),'FontSize',10,'Rotation', 60,'HorizontalAlignment','center','VerticalAlignment','middle');
    text(x+xp(9)+0.05,y+yp(9)+0.15,sprintf('Land \nright'),'FontSize',10,'Rotation', 80,'HorizontalAlignment','center','VerticalAlignment','middle');
    text(x+xp(length(ang)-2)+0.2,y+yp(length(ang)-2)-0.05,sprintf('Crop \ndiversity'),'FontSize',10,'Rotation', -18,'HorizontalAlignment','center','VerticalAlignment','middle');
    
    text(x+xp(length(ang)-4)+0.19,y+yp(length(ang)-4)-0.09,sprintf('Soil \nerosion'),'FontSize',10,'Rotation', -38,'HorizontalAlignment','center','VerticalAlignment','middle');
    text(x+xp(length(ang)-6)+0.1,y+yp(length(ang)-6)-0.23,sprintf('Greenhouse \ngas'),'FontSize',10,'Rotation', -58,'HorizontalAlignment','center','VerticalAlignment','middle');
    text(x+xp(length(ang)-8),y+yp(length(ang)-8)-0.25,sprintf('Land use \nchange'),'FontSize',10,'Rotation', -78,'HorizontalAlignment','center','VerticalAlignment','middle');
    text(x+xp(length(ang)-10)-0.1,y+yp(length(ang)-10)-0.2,sprintf('P surplus'),'FontSize',10,'Rotation', 78,'HorizontalAlignment','center','VerticalAlignment','middle');
    text(x+xp(length(ang)-12)-0.15,y+yp(length(ang)-12)-0.2,sprintf('N surplus'),'FontSize',10,'Rotation', 58,'HorizontalAlignment','center','VerticalAlignment','middle');
    text(x+xp(length(ang)-14)-0.15,y+yp(length(ang)-14)-0.15,sprintf('Water \nwithdraw'),'FontSize',10,'Rotation', 38,'HorizontalAlignment','center','VerticalAlignment','middle');
    
    
    text(x+xp(length(ang)-16)-0.16,y+yp(length(ang)-16)-0.08,sprintf('Food \nloss'),'FontSize',10,'Rotation', 18,'HorizontalAlignment','center','VerticalAlignment','middle');
    text(x+xp(length(ang)-18)-0.18,y+yp(length(ang)-18),sprintf('Market \naccess'),'FontSize',10,'Rotation', 0,'HorizontalAlignment','center','VerticalAlignment','middle');
    text(x+xp(length(ang)-20)-0.18,y+yp(length(ang)-20)+0.05,sprintf('Government \nsupport'),'FontSize',10,'Rotation', -20,'HorizontalAlignment','center','VerticalAlignment','middle');
    text(x+xp(length(ang)-22)-0.18,y+yp(length(ang)-22)+0.1,sprintf('Price \nvolatility'),'FontSize',10,'Rotation', -40,'HorizontalAlignment','center','VerticalAlignment','middle');
    text(x+xp(length(ang)-24)-0.05,y+yp(length(ang)-24)+0.18,sprintf('Finance \naccess'),'FontSize',10,'Rotation', -60,'HorizontalAlignment','center','VerticalAlignment','middle');
    text(x+xp(length(ang)-26)-0.05,y+yp(length(ang)-26)+0.2,sprintf('Productivity'),'FontSize',10,'Rotation', -80,'HorizontalAlignment','center','VerticalAlignment','middle');



    
    %r = 2 + 1 * 0.25;
    %incre =  pi / 18;
    %ang = 0:incre:2*pi;
 
    %xp=r*cos(ang);
    %yp=r*sin(ang);
    
    %text(x+xp(10)-0.1,y+yp(10)+0.27,varlabels(7),'FontSize',12);
    %text(x+xp(12)-0.1,y+yp(12)+0.3,varlabels(8),'FontSize',12);
    %text(x+xp(14)-0.3,y+yp(14)+0.3,varlabels(9),'FontSize',12);
    %text(x+xp(16)-0.45,y+yp(16)+0.3,varlabels(10),'FontSize',12);
    %text(x+xp(18)-0.55,y+yp(18)+0.1,varlabels(11),'FontSize',12);

 
    
    %%% 1 = economic, 2 = environment 3 = social 4 = total
    %%% 1 = down      2 = flat   3 = up

    xx{1}(1,:) = [0.39 0.39]-0.015;
    yy{1}(1,:) = [0.67 0.57]-0.05;
    xx{1}(2,:) = [0.387 0.483]-0.06;
    yy{1}(2,:) = [0.57 0.57];
    xx{1}(3,:) = [0.39 0.39]-0.015;
    yy{1}(3,:) = [0.57 0.67]-0.05;

    xx{2}(1,:) = [0.5 0.5]+0.016;
    yy{2}(1,:) = [0.41 0.31] - 0.05;
    xx{2}(2,:) = [0.452 0.548]+0.016;
    yy{2}(2,:) = [0.31 0.31];
    xx{2}(3,:) = [0.5 0.5]+0.016;
    yy{2}(3,:) = [0.31 0.41] - 0.05;

    xx{3}(1,:) = [0.642 0.642]+0.015;
    yy{3}(1,:) = [0.67 0.57]-0.05;
    xx{3}(2,:) = [0.599 0.695]+0.015;
    yy{3}(2,:) = [0.57 0.57];
    xx{3}(3,:) = [0.642 0.642]+0.015;
    yy{3}(3,:) = [0.57 0.67] - 0.05;

    xx{4}(1,:) = [0.5 0.5]+0.016;
    yy{4}(1,:) = [0.55 0.45]+0.016;
    xx{4}(2,:) = [0.452 0.548]+0.016;
    yy{4}(2,:) = [0.5 0.5]+0.016;
    xx{4}(3,:) = [0.5 0.5]+0.016;
    yy{4}(3,:) = [0.45 0.55]+0.016;
    

    
      for k = 1:1:4
        s = dimsign(cn,k);
        if s == -1
            d = 1;
        elseif s == 1
            d = 3;
        else d = 2;
        end

       annotation('textarrow',xx{k}(d,:),yy{k}(d,:),'LineWidth',5,'HeadWidth', 25, 'HeadStyle','plain')
      end
        

    %{
    for k = 1:1:4
        s = dimsign(cn,k);
        if s == -1
            d = 1;
        elseif s == 1
            d = 3;
        else d = 2;
        end
       X=(xx{k}(d,:)-AX(1))/Xrange +AX(1);
       Y=(yy{k}(d,:)-AX(3))/Yrange +AX(3);
        annotation('textarrow',X,Y,'LineWidth',3)
        
    end
    %}
    
    
    hold off;
end


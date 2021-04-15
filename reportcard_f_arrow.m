function reportcard_f(n,varcolr, varsign)
    piecolors = [
             0     1       0 %//green
             %0.9290 0.6940 0.1250 %// yellow
             1      1      0
             1      0      0 %//red
             0.85   0.85   0.85] 
         

             
    
    dimlabels = {"Econ.","Env.","Soc."}; 

    %%% Arrow locations
    %%% 1 = economic, 2 = social 3 = environmental 4 = total
    %%% 1 = down      2 = flat   3 = up
%{    
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
%}    
    xx{1}(1,:) = [0.3585 0.3585];
    yy{1}(1,:) = [0.673 0.5754];
    xx{1}(2,:) = [0.3088 0.3943];
    yy{1}(2,:) = [0.594 0.5928];
    xx{1}(3,:) = [0.3577 0.3577 + 0.0976] - 0.05;
    yy{1}(3,:) = [0.5754 0.673];

    xx{2}(1,:) = [0.5158 0.515];
    yy{2}(1,:) = [0.309 0.2114];
    xx{2}(2,:) = [0.4807 0.5662];
    yy{2}(2,:) = [0.2816 0.2804];
    xx{2}(3,:) = [0.515 0.5158];
    yy{2}(3,:) = [0.2114 0.309];

    xx{3}(1,:) = [0.6607 0.6599];
    yy{3}(1,:) = [0.6898 0.5922];
    xx{3}(2,:) = [0.6404 0.7259];
    yy{3}(2,:) = [0.6046 0.6034];
    xx{3}(3,:) = [0.6599 0.6607];
    yy{3}(3,:) = [0.5922 0.6898];

    xx{4}(1,:) = [0.5162 0.5154];
    yy{4}(1,:) = [0.5766 0.479];
    xx{4}(2,:) = [0.4666 0.5521];
    yy{4}(2,:) = [0.5222 0.521];
    xx{4}(3,:) = [0.5154 0.5162];
    yy{4}(3,:) = [0.479 0.5766];

    fontSize = 20;
    fig = figure;
    ax = axes('Parent', fig);
    numberOfSegments = 3;
    hPieComponentHandles = pie(ax, ones(1,numberOfSegments),dimlabels);

        % Enlarge figure to full screen.
    set(fig, 'units', 'normalized', 'outerposition', [0.1 0.1 0.5 0.75]);
        % Assign custom colors.
    for k = 1 : numberOfSegments
       % Create a color for this sector of the pie % Color for this segment.
       % Apply the colors we just generated to the pie chart.
       set(hPieComponentHandles(k*2-1), 'FaceColor', piecolors(varcolr(n,k),:),'EdgeColor', [1  1  1],'LineWidth',5);
       set(hPieComponentHandles(k*2), 'String',dimlabels{k}, 'FontSize', fontSize );
    end
    %pieAxis = get(hPieComponentHandles(1), 'Parent');  
    %pieAxisPosition = get(pieAxis, 'Position');
    hold on;
    rectangle('Position',[-0.5 -0.5 1 1],'FaceColor',piecolors(varcolr(n,4),:),'EdgeColor',[1  1   1],...
        'LineWidth',5,'Curvature',[1 1]);
    set(gcf, 'InvertHardCopy', 'off');
    set(gcf,'color','w');
    for k = 1:1:4
        s = varsign(n,k);
        if s == -1
            d = 1;
        elseif s == 1
            d = 3;
        else d = 2;
        end
        annotation('textarrow',xx{k}(d,:),yy{k}(d,:),'LineWidth',4)
    end
    hold off;
end


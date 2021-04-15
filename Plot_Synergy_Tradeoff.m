function [] = Plot_synergy_tradeoff(SAMdriver_corr,SAMdriver_avai,SAM_var_names)
%clc;
%load('Corr_Matrix.mat') : Correlation matrix Obtained by Tan's code
%Plot_synergy_tradeoff(SAMdriver_corr,SAMdriver_avai,SAM_var_names);

varNames=SAM_var_names;
max_var=length(SAM_var_names);

posi_corr=reshape(SAMdriver_corr(:,:,1),max_var,max_var);
nega_corr=reshape(SAMdriver_corr(:,:,4),max_var,max_var);
nonNaN_corr=reshape(SAMdriver_corr(:,:,5),max_var,max_var);
total_corr = ones(max_var,max_var);


data_avail=SAMdriver_avai;
% making lower triangle NaN
for i=2:max_var
data_avail(i:max_var,i-1)=NaN;
end
%%
close all

figure('units','normalized','outerposition',[0 0 1 1]);

xdist=0.1; ydist=0.5;

xlim([0 max_var])
ylim([0 max_var])
grid on
ax = gca;
ax.XColor = 'k'; % Red
ax.YColor = 'k'; % Blue
ax.GridAlpha = 0.9;  % Make grid lines less transparent.
ax.GridColor = 'k'; % Dark Green.
set(gca,'YtickLabel',[])
set(gca,'XtickLabel',[])
set(gca,'Ytick',0:1:max_var)
set(gca,'Xtick',0:1:max_var)

%%
P=2;% starting point
col=max_var;
for I=0:(max_var-1)
    R=P+I;
for j=col:-1:2
    
    
    x=[I I+total_corr(R,I+1) I+total_corr(R,I+1) I];
    y=[(j-2) (j-2) (j-1) (j-1)]; 
    patch(x,y,[0.85 0.85 0.85],'EdgeColor',[0.9 0.9 0.9]);
    
    hold on
    x=[I I+nonNaN_corr(R,I+1) I+nonNaN_corr(R,I+1) I];
    y=[(j-2) (j-2) (j-1) (j-1)]; 
    patch(x,y,'y','EdgeColor','y');
    
    x=[I I+nega_corr(R,I+1) I+nega_corr(R,I+1) I];
    y=[(j-2) (j-2) (j-1) (j-1)]; 
    patch(x,y,[0.145098039 0.337254902 0.968627451],'EdgeColor',[0.145098039 0.337254902 0.968627451]);
    hold on

    hold on
    x=[I I+posi_corr(R,I+1) I+posi_corr(R,I+1) I];
    y=[(j-2) (j-2) (j-1) (j-1)]; 
    patch(x,y,[0.968627451 0.533333333 0.098039216],'EdgeColor',[0.968627451 0.533333333 0.098039216]);
    


    
    R=R+1;
end
col=col-1;

end
%% plotting data availability
hold on
col=max_var;
P=1;
for I=0:(max_var-1)
    R=P+I;
    for j=max_var:-1:col
        
    hold on
    x=[I I+data_avail((max_var-j+1),R) I+data_avail((max_var-j+1),R) I];
    y=[(j-1) (j-1) j j]; 
    patch(x,y,[0.745098039 0.549019608 0.980392157],'EdgeColor',[0.745098039 0.549019608 0.980392157]);
    disp([R I+1 col])
    %R=R-1;
    end
    col=col-1;
end
    

%%
j=max_var;
for i=0:(max_var-1)
    text(i+xdist,j-ydist,char(varNames(i+1)),'fontsize',10,'FontWeight','bold');
    if j<0 
        break
    else
        j=j-1;
    end
end

axis square

%% changing grid lines
ax = gca;
ax.GridColor = [0 0 0];
ax.GridLineStyle = '-';
ax.GridAlpha = 0.7;
ax.Layer = 'top';
ax.LineWidth = 2;


end



function donout = donut_gy(numdat,lbtxt,colr)
% numdat: number data. Each column is a catagory, each row represents
%   a separate set of data
% varargin{1}: cell of legend entries, one string for each column of numdat,
%   default is none, eg. {'First','Second','Third'}
% varargin{2}: cell of colors, one row of 3 RGB values for each category (column of numdat)
% varargin{3}: if 'pie', will make a standard pie chart
% Examples:
%   donut([50,20,10;40,30,15],{'First','Second','Third'},{'r','g','b'});
%   donut([50,20,10],{'First','Second','Third'},[],'pie');
%   donut([50,20,10;40,30,15],[],{[ .945 .345 .329],[ .376 .741 .408],[ .365 .647 .855 ]});

% Default Values, if no variable arguments in

% Original donut function is downloaded from https://www.mathworks.com/matlabcentral/fileexchange/56833-donut
% modified by Guolin Yao on 11/24/2019.
legtextdim = [];
legtextvar = [];
colormap lines
clrmp = jet;

if length(lbtxt)>0
    legtextdim = lbtxt{1};
    legtextvar = lbtxt{2};
end

rings = size(numdat,1); % nuber of rings in plot

for i = 1:1:rings
    if length(colr)>0
         if ~isempty(colr)
            clrmp = colr{i};
         else
            colormap lines
            clrmp = colormap;
         end
    end
end

for i = 1:rings
    cats(i) = size(numdat{i},2); % number of categories in each ring/set modified by Guolin Yao
    tot = nansum(numdat{i,1}); % total things modified by Guolin Yao
    donout{i,1}=numdat{i,1}./tot; %modified by Guolin Yao
    fractang = (pi/2)+[0,cumsum((numdat{i,1}./tot).*(2*pi))]; % modified by Guolin Yao
    for j = 1:cats(i) % modified by Guolin Yao
        r0 = i;
        r1 = i+0.95;
        a0 = fractang(j);
        a1 = fractang(j+1);
        if iscell(colr)
            cl = colr{i,1}{j};
        else
            cl = colrmap(j,:);
        end
        polsect(a0,a1,r0,r1,cl);
    end
    %{
     if i==rings
        legend1 = legend(legtext);
        wi = legend1.Position(3);
        Xlm = xlim;
        widx = diff(Xlm);
        unitwi = widx.*wi;
        xlim([Xlm(1),Xlm(2)+unitwi])
    end
    %}
    
       
end

function pspatch = polsect(th0,th1,rh0,rh1,cl)
% This function creates a patch from polar coordinates

a1 = linspace(th0,th0);
r1 = linspace(rh0,rh1);
a2 = linspace(th0,th1);
r2 = linspace(rh1,rh1);
a3 = linspace(th1,th1);
r3 = linspace(rh1,rh0);
a4 = linspace(th1,th0);
r4 = linspace(rh0,rh0);
[X,Y]=pol2cart([a1,a2,a3,a4],[r1,r2,r3,r4]);

p=patch(X,Y,cl,'EdgeColor',[1 1 1],'LineWidth',5); % Note: patch function takes text or matrix color def
axis equal
set(gca,'XTick',[], 'YTick', [],'box','off','XColor','none','YColor','none')
pspatch = p;

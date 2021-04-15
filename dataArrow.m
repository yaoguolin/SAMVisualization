function obj = dataArrow(Xdata,Ydata,ax)
    %https://www.mathworks.com/matlabcentral/answers/346297-how-to-draw-an-arrow-using-non-normalized-coordinates
    %This function will draw an arrow on the plot for the specified data.
    %The inputs are 
    oldunits = get(ax, 'Units');
    set(ax, 'Units', 'Normalized');
    axpos = ax.CurrentAxes.Position;
    set(ax, 'Units', oldunits);
    %get axes drawing area in data units
    ax_xlim = ax.CurrentAxes.XLim;
    ax_ylim = ax.CurrentAxes.YLim;
    ax_per_xdata = axpos(3) ./ diff(ax_xlim);
    ax_per_ydata = axpos(4) ./ diff(ax_ylim);
    %these are figure-relative
    Xpixels = (Xdata - ax_xlim(1)) .* ax_per_xdata + axpos(1);
    Ypixels = (Ydata - ax_ylim(1)) .* ax_per_ydata + axpos(2);
    obj = annotation('arrow', Xpixels, Ypixels, 'Units', 'pixels');
end

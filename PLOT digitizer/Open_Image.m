function [  ] = Open_Image(  )
%   This functino opens an image

    global X X_d
    global size_x size_y
    global ax bx ay by
    global x_min x_max y_min y_max
    close all;
    
    [File_, Path_] = uigetfile( ...
              {'*.jpg;*.jpeg;*.tif;*.gif;*.png;*.bmp', ...
               'All MATLAB Image Files (*.jpg,*.jpeg,*.tif,*.gif,*.png,*.bmp)'; ...
               '*.*', ...
               'All Files (*.*)'}, ...
               'Select image file');
    Path_ = strcat(Path_, File_);
    clear File_
    if(isequal(Path_,0))
        return;
    end
    
    n = length(Path_);
    [X, ~] = imread(Path_);
    X_d    = X;
    tmp    = size(X);
    size_x = tmp(2);
    size_y = tmp(1);
    x_min = 0;              x_max = size_x;
    y_min = 0;              y_max = size_y;
    ax     = (size_x - 1)/(x_max - x_min);
    ay     = (1 - size_y)/(y_max - y_min);
    bx     = size_x - ax*x_max;
    by     = size_y - ay*y_min;
    
    figure(1);
    hFig = figure(1);                           %±×·¡ÇÁ Ã¢ÀÇ À§Ä¡¿Í Å©±âÁ¶Àý
    set(hFig, 'Position', [350 150 800 800])
    clear hFig;
    set(gcf, 'color', 'w');
    
    Display_Image;
    
end


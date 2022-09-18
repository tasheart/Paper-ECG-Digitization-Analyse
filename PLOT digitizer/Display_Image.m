function [  ] = Display_Image(  )
%   This function shows an image and croped image

    global X_d Y
    global x_min x_max y_min y_max
    global ratio
    global m_location
    global data

    %   Draw main image
    imagesc([x_min, x_max], [y_min, y_max], flipdim(X_d,1))
    set(gca,'ydir','normal');
    
    %   Get mouse location
    set(gcf, 'WindowButtonMotionFcn', @Get_Mouse_Location);
    m_location = Get_Mouse_Location;
    
    %   Obtain cropped image
    [px1, px2, py1, py2] = Get_Crop_Position;
    Y = X_d(px1:px2, py1:py2,:);
    hold on;
    
    x1 = x_max + ratio*(x_min - x_max);
    y1 = y_max + ratio*(y_min - y_max);
    imagesc([x1, x_max], ...
            [y1, y_max], flipdim(Y,1));

    %   Plot boarderline for cropped image
    %plot(        (x1 + x_max)/2,        (y1 + y_max)/2, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'red')
    plot([1, 1] *(x1 + x_max)/2,        [y1,  y_max]  , 'black:')
    plot(        [x1,  x_max]  , [1, 1]*(y1 + y_max)/2, 'black:')
    plot([x1, x_max], [y1, y1   ], 'black')
    plot([x1, x1   ], [y1, y_max], 'black')
    hold off
    
    
    % Temp: Mark data
    if(data)
        hold on;
        plot(data(:,1), data(:,2), 'cyano--', 'linewidth', 1.0)
        hold off
    end
    
end
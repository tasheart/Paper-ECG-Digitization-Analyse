function [  ] = Mark_Cursor( option_ )
%   This function displays the cursor location 
%   options_: marked cursor color option. True -> Red, False -> Cyan

    global size_x size_y
    global m_location
    
    %   Transform mouse location to pixel location
    [px, py] = m_loc2pixel(m_location(1, 1), m_location(1, 2));
    
    %   Marked cursor color
    if(option_)
        RGB_ = [255, 0, 0];
    else
        RGB_ = [0, 255, 255];
    end
    
    %   Mark cursor on the image
    Mark_Pixel(px, py, RGB_);

end


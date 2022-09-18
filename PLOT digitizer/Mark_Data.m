function [  ] = Mark_Data(  )
%   This function displays the data

    global data n
    
    RGB_ = [255, 0, 0];             % Mark data red color
    for i = 1:n                     % Mark data once again
        [px, py] = m_loc2pixel(data(i,1), data(i,2));
        Mark_Pixel(px, py, RGB_);
    end

end


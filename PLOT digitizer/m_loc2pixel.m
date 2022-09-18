function [ px, py ] = m_loc2pixel( rx, ry )
%    This function converts m_location into pixel index

    global ax bx ay by
    global size_x size_y

    %   Round pixel data: For consistency
    py = round(rx*ax + bx);
    px = round(ry*ay + by);
    
    %   Make px and py in the picture
    px = max(px, 2);
    px = min(px, size_y - 2);
    py = max(py, 2);
    py = min(py, size_x - 2);

end


function [ px1, px2, py1, py2 ] = Get_Crop_Position(  )
%   This function calculates crop position where cropped and magnified size
%   of picture is (max-min)*ratio

    global x_min x_max y_min y_max
    global size_x size_y
    global ax bx ay by
    global magnification
    global ratio
    global m_location

    Lx = ratio*(x_max-x_min)/magnification / 2;
    Ly = ratio*(y_max-y_min)/magnification / 2;
    px = fix(m_location(1,1)*ax + bx);
    py = fix(m_location(1,2)*ay + by);
    px = min(px, size_x - fix(ax*Lx));
    px = max(px, 1      + fix(ax*Lx));
    py = min(py, size_y - fix(-ay*Ly));
    py = max(py, 1      + fix(-ay*Ly));
    
    py1 = px - fix(ax*Lx);
    py2 = px + fix(ax*Lx);
    px1 = py - fix(-ay*Ly);
    px2 = py + fix(-ay*Ly);

end


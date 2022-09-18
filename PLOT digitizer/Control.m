function [  ] = Control( i )
%   This function controls menu
    
    if(i == 1)
        Open_Image;
    elseif(i == 2)
        Calibrate_Axis
    elseif(i == 3)
        Acquire_Data_m;
    elseif(i == 4)
        Acquire_Data_a;
    elseif(i == 5)
        View_Sort_Data;
    elseif(i == 6)
        Clear_Data;
        Display_Image;
    end

end


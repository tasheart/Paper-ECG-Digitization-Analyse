function [  ] = Mark_Pixel( px, py, RGB_ )
%   This function displays the cursor location 
%   options_: marked cursor color option. True -> Red, False -> Cyan

    global X_d
    
    ratio = 0.3;
    
    %   Mark cursor on the image
    for i = px-1:px+1
        for j = py-1:py+1
            for k = 1:3
                X_d(i , j , 1)  = RGB_(1)*ratio + X_d(i , j , 1)*(1-ratio);
                X_d(i , j , 2)  = RGB_(2)*ratio + X_d(i , j , 2)*(1-ratio);
                X_d(i , j , 3)  = RGB_(3)*ratio + X_d(i , j , 3)*(1-ratio);
                X_d(i , py, k)  = 000;
                X_d(px, j , k)  = 000;
            end
        end
    end

end


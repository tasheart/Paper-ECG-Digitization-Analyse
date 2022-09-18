function [  ] = Acquire_Data_m(  )
%   This function controls data acquisition

    global X X_d
    global data n
    global m_location
    global ax bx ay by

    NULL = 'b';                             % Null parameter
    set(gcf, 'currentchar', NULL);          % Initialization
    figure(1);                              % Focus on figure
    
    while(1)                                % Exit when Esc key is pressed
        c = get(gcf, 'currentchar');        % Get character for control
        Mark_Cursor(0);
        Mark_Data;
        Display_Image;
        title(sprintf('Coordinate = (%d, %d)\n%s%s', m_location(1,1), m_location(1,2), ...
                      'Press esc to terminate. Press ''A/a'' to add data ', ...
                      'and ''R/r'' to remove the nearest data.'), ...
              'fontsize', 12);
        drawnow
        X_d = X;
        
        if(~length(c)); c = NULL; end;      % Prevent null character - Matlab cannot handle this
        if(c == '')                        % Exit when Esc key is pressed
            break;
            
        elseif((c == 'a') || (c == 'A'))    % Add data point
            set(gcf, 'currentchar', NULL);  % Reset input
            [px, py] = m_loc2pixel(m_location(1, 1), m_location(1, 2));
            n = n + 1;                      % Increase number of the data
            %data(n, 1) = m_location(1, 1); % Raw data
            %data(n, 2) = m_location(1, 2);
            data(n, 1) = (py - bx)/ax;      % Actual pixel location
            data(n, 2) = (px - by)/ay;
            X_d = X;                        % Recover original image
            Mark_Data;                      % Mark data
            
            clc;
            data
            
            figure(1);                      % Focus on figure again
            
        elseif((c == 'r') || (c == 'R'))    % Remove last data
            set(gcf, 'currentchar', NULL);  % Reset input
            if(n == 0)                      % Remove data when n > 0 only
                continue;
            end
            
            % Remove nearest point to the mouse pointer
            distance = (data(:,1) - m_location(1,1)).^2 + (data(:,2) - m_location(1,2)).^2;
            [~, i_] = min(distance);
            c_ = 0;
            tmp_ = [0, 0];
            for i = 1:n
                if(i ~= i_)
                    c_ = c_ + 1;
                    tmp_(c_, 1) = data(i, 1);
                    tmp_(c_, 2) = data(i, 2);
                end
            end
            n = n - 1;                      % Decrease data number
            data = tmp_;                    % Update data
            clear i_ c_ tmp_
            
            X_d = X;                        % Recover original image
            Mark_Data;                      % Mark data
            
            clc;
            data
            
            figure(1);                      % Focus on figure again
        end
    end

end
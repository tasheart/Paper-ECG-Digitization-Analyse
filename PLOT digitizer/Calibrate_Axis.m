function [  ] = Calibrate_Axis(  )
%   This function defines/re-defines the reference axis

    global X X_d
    global size_x size_y
    global ax bx ay by
    global x_min x_max y_min y_max
    global m_location
    
    fprintf('\t\t\tAxis definition\n');
    
    n = 0;
    A = zeros(4, 4);
    b = zeros(4, 1);

    NULL = 'b'
    set(gcf, 'currentchar', NULL);                              % Initialization

    while(n ~= 4)
        clc
        fprintf('\t Menu\n');
        fprintf('\t\t 1. Define x reference point\n');
        fprintf('\t\t 2. Define y reference point\n');
        fprintf('\t\t 3. Define x/y ratio\n');
        fprintf('\t\t-1. Return\n');
        fprintf('\t\t\t(%d / 4)\n\n\n', n)
        i = input('   Your menu? : ');
        figure(1);                                  % Focus on the figure
        
        if(i == 1)                                  % Get x refence point
            while(1)
                c = get(gcf, 'currentchar');        % Get character for control
                Mark_Cursor(0);                     % Mark current mouse cursor to image: cyan
                Display_Image;
                title(sprintf('Coordinate = (%d, %d)\n%s', m_location(1,1), m_location(1,2), ...
                      'Press ''A/a'' to select reference point'), 'fontsize', 12);
                drawnow;
                X_d = X;                            % Initialize image
                                
                if(~length(c)); c = NULL; end;      % Prevent null character - Matlab cannot handle this
                if((c == 'a') || (c == 'A'))        % Select reference point
                    set(gcf, 'currentchar', NULL);  % Reset input
                    
                    [px, py] = m_loc2pixel(m_location(1, 1), m_location(1, 2));
                    rx = (py - bx)/ax;
                    ry = (px - by)/ay;
                    Mark_Cursor(1);                 % Mark current mouse cursor to image: red
                    Display_Image;
                    
                    n = n + 1;                      % Update matrix index
                    alpha = (rx - x_min)/(x_max - x_min);
                    A(n, 1) = 1 - alpha;
                    A(n, 2) = alpha;
                    clc;
                    b(n)    = input('   Refence x is : ');
                    break;                          % Exit while loop
                end
            end
        
        
        elseif(i == 2)                              % Get y refence point
            while(1)
                c = get(gcf, 'currentchar');        % Get character for control
                Mark_Cursor(0);                     % Mark current mouse cursor to image: cyan
                Display_Image;
                title(sprintf('Coordinate = (%d, %d)\n%s', m_location(1,1), m_location(1,2), ...
                      'Press ''A/a'' to select reference point'), 'fontsize', 12);
                drawnow;
                X_d = X;                            % Initialize image
                                
                if(~length(c)); c = NULL; end;      % Prevent null character - Matlab cannot handle this
                if((c == 'a') || (c == 'A'))        % Select reference point
                    set(gcf, 'currentchar', NULL);  % Reset input
                    
                    [px, py] = m_loc2pixel(m_location(1, 1), m_location(1, 2));
                    rx = (py - bx)/ax;
                    ry = (px - by)/ay;
                    Mark_Cursor(1);                 % Mark current mouse cursor to image: red
                    Display_Image;
                    
                    n = n + 1;                      % Update matrix index
                    alpha = (ry - y_min)/(y_max - y_min);
                    A(n, 3) = 1 - alpha;
                    A(n, 4) = alpha;
                    clc;
                    b(n)    = input('   Refence y is : ');
                    break;                          % Exit while loop
                end
            end
        
            
        elseif(i == 3)                               % Get scale factor
            n = n + 1;
            ratio_xy = input('   Ratio for x/y is is : ');
            ratio_xy = ratio_xy * size_x/size_y;
            A(n, 1) = -1;
            A(n, 2) = +1;
            A(n, 3) = +ratio_xy;
            A(n, 4) = -ratio_xy;
            b(n)    = 0;
        
        
        elseif(i == -1)
            return;
        end
    end
    
    if(det(A) == 0)
        fprintf('Failed to calibrate axis.\n');
        pause(1);
        return;
    end
    
    X_d   = X;
    x     = A\b;
    x_min = x(1);
    x_max = x(2);
    y_min = x(3);
    y_max = x(4);
    ax    = (size_x - 1)/(x_max - x_min);
    ay    = (1 - size_y)/(y_max - y_min);
    bx    = size_x - ax*x_max;
    by    = size_y - ay*y_min;
    
    Display_Image;

end
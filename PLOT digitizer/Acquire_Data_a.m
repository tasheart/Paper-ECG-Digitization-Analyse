function [  ] = Acquire_Data_a(  )
%   This function controls data acquisition

    global X X_d
    global size_x size_y
    global data n
    global m_location
    global ax bx ay by

    NULL = 'b';                                 % Null parameter
    RGB_ = uint8([0, 0, 0]);                    % Initialization
    
    clc;
    fprintf('\t Menu\n');
    fprintf('\t\t 1. Write color RGB value for target\n');
    fprintf('\t\t 2. Pick color from figure for target\n');
    fprintf('\t\t-1. Return\n');
    i = input('   Your menu? : ');
    
    if(    i == 1)                              % Get color RGB input
        RGB_ = input('    Your RGB color in the vector form is: ');
        RGB_ = uint8(RGB_);
        
    elseif(i == 2)                              % Pick RGB color
        set(gcf, 'currentchar', NULL);          % Initialization
        figure(1);                              % Focus on figure
        while(1)
            c = get(gcf, 'currentchar');        % Get character for control
            Mark_Cursor(0);                     % Mark cursor
            Display_Image2(RGB_);
            Clear_Data;                         % Clear previous data
            X_d = X;                            % Recover original image
            title(sprintf('Coordinate = (%d, %d)\n%s', m_location(1,1), m_location(1,2), ...
                          'Press Esc to exit, ''a/A'' to pick color and ''c/C'' to confirm it.' ), ...
                  'fontsize', 12);
            drawnow;
            figure(1);                          % Focus on figure
            
            if(~length(c)); c = NULL; end       % Prevent null character - Matlab cannot handle this
            if(c == '')                        % Exit when Esc key is pressed
                return;
            elseif((c == 'a') || (c == 'A'))    % Pick color
                set(gcf, 'currentchar', NULL);  % Reset input
                clc;
                [px, py] = m_loc2pixel(m_location(1, 1), m_location(1, 2));
                RGB_ = X_d(px, py, :);
                fprintf('\tPicked color = [%d, %d, %d]\n', RGB_(1), RGB_(2), RGB_(3));
            elseif((c == 'c') || (c == 'C'))    % Confirm the color
                set(gcf, 'currentchar', NULL);  % Reset input
                clc;
                figure(1);                      % Focus on figure
                break;
            end
        end
        
    elseif(i == -1)                             % Exit to the menu
        return;
    end
    

    set(gcf, 'currentchar', NULL);              % Initialization
    figure(1);                                  % Focus on figure
    dpx    = round(size_x / 20);                % Delta pixel for digitization
    Radius = 50;                                % Color radius
    X_R    = double(X_d);                       % Conversion from unsigned int to real value
    RGB_   = double(RGB_);                      % Conversion from unsigned int to real value
    while(1)                                	% Exit when Esc key is pressed
        distance_ = (X_R(:,:,1) - RGB_(1)).^2 ...
                  + (X_R(:,:,2) - RGB_(2)).^2 ...
                  + (X_R(:,:,3) - RGB_(3)).^2;
        distance_ = sqrt(distance_);            % Get color distance
        flag_     = distance_ < Radius;         % Flag for is color in the radius
        offset_   = 0;                          % Starting point of digitization
        for i = 1:size_x
            if(sum(flag_(:, i)))
                offset_ = i;                    % Starting offset
                break;
            end
        end
        
        if(offset_)                             % Do digitization at least when one data point exists
            i = offset_;
            while(i <= size_x)
                index_1 = 0;
                index_2 = 0;
                for j = 2:size_y                    % Determine index 1
                    if( (flag_(j-1, i) == false) && (flag_(j,i) == true))
                        index_1 = j;
                        for k = index_1:size_y-1    % Determine index 2
                            if( (flag_(k+1, i) == false) && (flag_(k,i) == true))
                                index_2 = k;
                                break;
                            end
                        end
                        break;
                    end
                end
            
                if( index_1 || index_2)             % If there is target point
                    j = fix((index_1 + index_2)/2); % Take mid point

                    n = n + 1;                      % Add data
                    data(n, 1) = (i - bx)/ax;       % Actual pixel location
                    data(n, 2) = (j - by)/ay;                    
                    i = i + dpx;                    % Next target pixel
                else
                    i = i + 1;                      % Search target at the next pixel
                end
            end
            
            clc;
            fprintf('\t\t Digitization has been done\n');
            data
            X_d = X;                                % Recover original image
            Mark_Data;                              % Mark data
            figure(1);
        end
        clear distance_ flag_ offset_ index_1 index_2        
        
        set(gcf, 'currentchar', NULL);          % Initialization
        c = NULL;                               % Initialization
        while(1)
            Display_Image;
            title(sprintf('1. Complete automatic digitization\n%s', ...
                          '2. Digitize once again with different delta pixel and color radius' ), ...
                  'fontsize', 12);
            drawnow;
            c = get(gcf, 'currentchar');        % Get character for control
            if(c ~= NULL)
                figure(1);                      % Focuse on the figure
                break;
            end
        end

        if(c == '1' || c == '')
            title('Now it is in the main menu', 'fontsize', 12);
            drawnow
            break;
        elseif(c == '2')
            clc;
            fprintf('\tSize of figure\n');
            fprintf('\t\tWidth:  %d\n', size_x);
            fprintf('\t\tHeight: %d\n', size_y);
            dpx    = input('    delta pixel  for automatic digitization: ');
            Radius = input('    Color radius for automatic digitization: ');
            figure(1);                      % Focuse on the figure
            Clear_Data;
            X_d = X;
        end
    end

end
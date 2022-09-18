function [ ] = View_Sort_Data( )
%    This function visualize the data

    global data n
    
    clc;
    data                                    % Data in the form of text
    
    NULL = 'b';
    figure(1);                              % Focus on a figure window
    fprintf('Press esc to terminate in the figure window\n')
    set(gcf, 'currentchar', NULL);
    if(n < 4)
        return;
    end
    x_d = Cubic_Spline(1:n, data(:,1), 1:0.1:n);
    y_d = Cubic_Spline(1:n, data(:,2), 1:0.1:n);
    
    while(1)                                % Exit when Esc key is pressed
        c = get(gcf, 'currentchar');
        Display_Image;
        hold on;
        plot(data(:,1), data(:,2), 'redo', 'linewidth', 2)
        plot(x_d      , y_d      , 'red-', 'linewidth', 2)
        hold off
        title(sprintf('Press esc to terminate\n %s', ...
                      'Press ''x/X'' to sort data with respect to x, ''y/Y'' to y'), ...
              'fontsize', 12);
        drawnow;
        
        if(~length(c)); c = NULL; end;      % Prevent null character - Matlab cannot handle this
        if(c == '')                        % Exit when Esc key is pressed
            set(gcf, 'currentchar', NULL);
            break;
        elseif((c == 'x') || (c == 'X'))
            set(gcf, 'currentchar', NULL);
            for i = 1:n-1
                for j = i+1:n
                    if(data(i, 1) > data(j, 1))
                        c          = data(i, 1);
                        data(i, 1) = data(j, 1);
                        data(j, 1) = c;
                        c          = data(i, 2);
                        data(i, 2) = data(j, 2);
                        data(j, 2) = c;
                    end                        
                end
            end
            x_d = Cubic_Spline(1:n, data(:,1), 1:0.1:n);
            y_d = Cubic_Spline(1:n, data(:,2), 1:0.1:n);
            
            clc;
            data
            fprintf('Press esc to terminate in the figure window\n');
            figure(1);
            
        elseif((c == 'y') || (c == 'Y'))
            set(gcf, 'currentchar', NULL);
            for i = 1:n-1
                for j = i+1:n
                    if(data(i, 2) > data(j, 2))
                        c          = data(i, 1);
                        data(i, 1) = data(j, 1);
                        data(j, 1) = c;
                        c          = data(i, 2);
                        data(i, 2) = data(j, 2);
                        data(j, 2) = c;
                    end                        
                end
            end
            x_d = Cubic_Spline(1:n, data(:,1), 1:0.1:n);
            y_d = Cubic_Spline(1:n, data(:,2), 1:0.1:n);
            
            clc;
            data
            fprintf('\tPress esc to terminate in the figure window\n')
            figure(1);
        end
        drawnow
    end

end
function [ Location ] = Get_Mouse_Location( object, eventdata )
%   This function gets the location of the mouse pointer

    Location = get(gca, 'CurrentPoint');

end


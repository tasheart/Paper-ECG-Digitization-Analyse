%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                               Digitizer                                 %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i = Initializer;            % Initialize environment
while(i ~= -1)
    i = Get_Input;
    Control(i);
end
clear i
clc;
fprintf('\t\tThe code is terminated\n\n');

global data                 % To store global variable
data = data + 0;   

% To get rid of warning
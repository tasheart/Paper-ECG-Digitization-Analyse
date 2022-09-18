function [ i ] = Get_Input(  )
%   This function display menu options and get an input

    clc;
    fprintf('\t Menu\n');
    fprintf('\t\t 1. Open an image file\n');
    fprintf('\t\t 2. Calibrate axis\n');
    fprintf('\t\t 3. Acquire data manually\n');
    fprintf('\t\t 4. Acquire data automatically\n');
    fprintf('\t\t 5. View and sort data\n');
    fprintf('\t\t 6. Clear data\n');
    fprintf('\t\t-1. Exit\n\n');
    i = input('   Your menu? : ');

end


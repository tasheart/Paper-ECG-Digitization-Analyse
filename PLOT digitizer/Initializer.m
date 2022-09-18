function [ i ] = Initializer(  )
%   This function initializes environment

    clc
    close all
    clear all
    format long
    
    global X X_d                        % Original Image, image with data
    global Y                            % Cropped image
    global size_x size_y                % Size of the picture
    global x_min x_max y_min y_max      % Graph axis
    global ax bx ay by                  % Linear transform coefs : from location to pixel
    global m_location                   % Mouse location
    global data n                       % Data array and its size
    global magnification                % Multiplication factor
    global ratio                        % Crop size ratio
    
    X      = 0;             X_d    = 0;
    Y      = 0;
    size_x = 0;             size_y = 0;
    x_min  = 0;             x_max  = 0;
    y_min  = 0;             y_max  = 0;
    ax     = 0;             bx     = 0;
    ay     = 0;             by     = 0;
    m_location = 0;
    data   = 0;
    n      = 0;
    magnification = 5;      %User input: Magnification factor
    ratio  = 0.2;           %User input: Maginified image size
    
    i = 0;                  %idle state menu

end


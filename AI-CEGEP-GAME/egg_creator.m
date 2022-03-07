%+-----------------------------------------------------------------------+
%|                         EGG PLOTTER FUNCTION                          |
%+-----------------------------------------------------------------------+

%This the egg creator function I created. Here, I plot different types of
%eggs: the falling egg, the life eggs and the life eggs' shadows. This function is called into the
%main code's opening function a couple of times! When the function is
%called, the color of the egg is chosen by giving RGB values, in either
%1-255 or 0.0-1.0 !
function output = egg_creator(R, G, B)

%I start by transforming any RGB values that could've been put in 1-255 into 
%the 0-1 system. I'm converting integer values into doubles. I know that 
%I'm the one calling this function and I always use 0-1 values, but for
%this code to be universally good, I'm simply making sure that it would work
%in any possible case. 
if isinteger(R) 
    R = double(R)/255
elseif isinteger(G)
    G = double(G)/255
elseif isinteger(B)
    B = double(B)/255
end

%Here, I define the color of the edge of the egg. I want the outline to
%be a bit darker then the inside of the egg, so I reduce the value of the
%color of the egg to get my RGB values for the outline.
R_edge = R - 0.2;
G_edge = G - 0.2;
B_edge = B - 0.2;

%To make sure that the RGB values of the dark outline don't become
%negative, I'm setting delimiters to the color. If the color of the edge
%after having 0.2 reduced from it is a negative value, then this code
%transforms it to a 0!
if R_edge < 0
    R_edge = 0;
elseif G_edge < 0
    G_edge = 0;
elseif B_edge < 0
    B_edge = 0;
end
    
%This is the actual plotting of the egg. I found the first three lines of
%code online, giving me the mathematical functions needed to plot a nice
%looking egg. Actually, the online version was putting the egg
%horizontally, so I switched the axis of the function. Also, I had used the
%plot function at thte fourth line, but it only coded the outline of the
%egg. So, I found this fill function that basically plots but fills in the
%lines, to make a very nice looking egg. I finally change the color of the
%edge to make the egg even more majestic!!
    theta = 0:0.001:2*pi;
    egg_y = cos(theta)*6;
    egg_x = sin(theta).*(4-egg_y/6);
    eggPlot = fill(egg_x, egg_y, [R G B]);
    set(eggPlot, 'EdgeColor', [R_edge G_edge B_edge])
    axis off
end




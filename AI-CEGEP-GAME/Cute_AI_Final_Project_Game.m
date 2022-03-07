%+-------------------------------------------------------+%
%|                ANDRÉ'S EGG SIMULATOR                  |%
%|               Final Project in PI 2020                |%
%+-------------------------------------------------------+%

%Welcome to my Egg Simulator Game. The goal is to catch as many of the 
%falling eggs as possible. However, be weary, the speed of the eggs
%augments as time advances, making it harder and harder. Try to score as
%many points as possible, and compare the results with your friends! It's
%a simple yet addicting game, and it's great for the whole family. You can
%purchase it on the MatLab store for only 99.99$! All jokes aside, I hope
%that you will enjoy this mini-game, which has a lot of love/frustrating effort) 
%put into it :)


function varargout = Cute_AI_Final_Project_Game(varargin)
% AI_Final_Project_Game MATLAB code for AI_Final_Project_Game.fig
%      AI_Final_Project_Game, by itself, creates a new AI_Final_Project_Game or raises the existing
%      singleton*.
%
%      H = AI_Final_Project_Game returns the handle to a new AI_Final_Project_Game or the handle to
%      the existing singleton*.
%
%      AI_Final_Project_Game('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AI_Final_Project_Game.M with the given input arguments.
%
%      AI_Final_Project_Game('Property','Value',...) creates a new AI_Final_Project_Game or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AI_Final_Project_Game_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AI_Final_Project_Game_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AI_Final_Project_Game

% Last Modified by GUIDE v2.5 11-May-2021 14:19:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Cute_AI_Final_Project_Game_OpeningFcn, ...
                   'gui_OutputFcn',  @Cute_AI_Final_Project_Game_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before AI_Final_Project_Game is made visible.
function Cute_AI_Final_Project_Game_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AI_Final_Project_Game (see VARARGIN)

% Choose default command line output for Cute_AI_Final_Project_Game
handles.output = hObject;

handles.n = 0;
handles.difficulty = 2;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes Cute_AI_Final_Project_Game wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%+-----------------------------------------------------------------------+
%|                 TRANSFORMING THE "LOOK" OF THE GAME                   |
%+-----------------------------------------------------------------------+

%+-----------+
%|BACKGROUND |
%+-----------+
%I start by adding a background image, which is a dope little farm. I am
%defining the axes9 as the axes in question. The axes9 is a big axes that
%is as large as the figure1 (check in GUIDE to understand). I then read the
%matrix of the background image. I show it, which shows directly onto axes9.

axes(handles.axes9)         
imshow(imread('Princess_Background.jpg'));                  


%+------------+
%|FALLING EGG |
%+------------+
%For the falling egg, I start, yet again, by defining the axes in question:
%axes 2. I then call a function that I made called egg_creator. Go check
%this function to understand what it does in more precise detail. Briefly,
%it plots/fills an egg shape. The color is decided here, where you
%need to put the RGB values in the calling of the function. Here, I am
%saying that there is 1 red, 0.6 green, and 0.5 blue, making a nice pink-ish.

axes(handles.axes2)
egg_creator(1, 0.6, 0.5)


%+-----------+
%|LIFE EGGS  |
%+-----------+
%For axes5, axes7 and axes8, I do the same thing as before... I define my
%axes and then use my egg_creator function. This time, I change the color
%to a more pale, white-ish color.

axes(handles.axes5)
egg_creator(1, 0.9, 0.9)

axes(handles.axes7)
egg_creator(1, 0.9, 0.9)

axes(handles.axes8)
egg_creator(1, 0.9, 0.9)


%+-----------+
%|BASKET     |
%+-----------+
%Now, I'm creating my basket; the moving axes at the bottom of the spheres
%that needs to catch the falling egg. I'm using an uploaded image. So,
%again, I first define the axes and read the image matrix.

axes(handles.axes1)
basketMat = imread('basket.jpg');

%I'm then calling my function where I threshold a particular color. Basically, 
%I make all the white (background of the basket) from the image become 1s, 
%so white. All the other colors become 0s, so black.
basket = flipud(M04_P5_threshold_AndreKolstad('basket.jpg', 255, 255, 255, 30));

%This is deleting all the whites from my image and restoring the original
%colors in the blacks of the image. This basically transforms my basket image
%into a PNG, into an object, deleting its background.
obj_basket = image('CData', flipud(basketMat), 'AlphaData', ~basket);
axis xy
axis equal

%here, I am making my object bigger, since it used to be 600x429, which
%didn't look nice and was too small... now, it'll fit better in my GUI, at 2000x400. I'm also
%taking the axis off, so that all we see is the image itself.
obj_basket.XData = [1 2000];
obj_basket.YData = [1 400];
axis off

%+---------------+
%| CENTER SCREEN |
%+---------------+
%This code makes the GUI pop up fully centered. This is used to make the
%whole look more esthetic. 
screenS = get(0, 'ScreenSize'); 
xPix = screenS(3);  %defining the width of the screen
yPix = screenS(4);  %defining the height of the screen
set(hObject, 'Units', 'pixels');    %putting the units into pixels
figPos = get(hObject, 'Position');   
w = figPos(3);      %defining the width of the figure1
h = figPos(4);      %defining the height of the figure1 
set(hObject, 'Position', [(xPix-w)/2 , (yPix-h)/2, w, h]);   %placing the screen/figure in the middle



% --- Outputs from this function are returned to the command line.
function varargout = Cute_AI_Final_Project_Game_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

%+-----------------------------------------------------------------------+
%|                        MAIN CODE OF THE GAME                          |
%+-----------------------------------------------------------------------+

%Let me just show you the dimensions of the figure1 and axes1...

%position of figure1 = [1087, 1049, 773, 639]
%position of axes1 (basket) at start = [287 62 173 36]

%+--------------+
%|KEYS PRESSED  |
%+--------------+
    switch eventdata.Key    %for every case that a Key from eventdata is pressed, something happens...
        case 'leftarrow'
            %when the left arrow is pressed, the x value of the basket
            %moves 50 pixels to the left. If you hold the key, it'll move
            %by 50 pixels at a rapid rate.
            handles.axes1.Position(1) = handles.axes1.Position(1) - 50;  
            
            %here I'm stopping the basket from going out of bounds to the
            %left. If it goes further left than 0, I change that value in x
            %to 0, so it's the minimum x value.
            if handles.axes1.Position(1) < 0
                handles.axes1.Position(1) = 0;
            end
            
        case 'rightarrow'
            %same concept as before, but to the right
            handles.axes1.Position(1) = handles.axes1.Position(1) + 50;
            
            %same concept as before again, but instead of having 0 as a
            %minimum, we have the difference between the biggest x of the
            %figure1 - the width of the axes1.
            if handles.axes1.Position(1) > 773 - handles.axes1.Position(3)  %most right position of figure1 - width of axes1
                handles.axes1.Position(1) = 773 - handles.axes1.Position(3);
            end

        case 'return'
           %+----------------+
           %|SMALL CONSTANTS |
           %+----------------+
            handles.lives = 3;  %creating a handle for the amount of lives. If we drop the egg three times, game is over.
            score = 0;          %the score starts at 0 and augments progressively.
            handles.text3.String = num2str(score);
            
            %DIFFICULTY LEVEL
            %changing the speed depending on the difficulty level, which is
            %found through the end of each previous game... 
            if handles.difficulty == 1
                speed = 4;
            elseif handles.difficulty == 2
                speed = 6;         %speed starts at 5 and augments progressively.
            elseif handles.difficulty == 3
                speed = 8;
            end
            
            %When the 'enter' key is pressed, I start by removing the big 
            %block that says: "press enter to start!"
            handles.text10.Visible = 'off';
            
            %I am using a while loop, because I don't know the exact amount
            %of times that the loop will run. The number of times the egg 
            %starts falling could be 27 as it could be 3... So, I am saying 
            %that as long as we're alive, the loop will run. 
            while handles.lives > 0    %for as long as we haven't dropped the egg 3 times... while we're alive...
                pause(0.5);
                currX_egg = randi(722);    %randomizes the x position of the falling egg, each round
                currY_egg = 639;   %defining the current Y at max high point so that the egg's fall starts up of the screen.
             
                %self-learning software part!
                handles.n = handles.n + 1
                handles.basketPosition(handles.n) = handles.axes1.Position(1)
                    if handles.n > 30
                        handles.n = 0;
                    end
                    
                    if handles.n > 10
                        if mean(handles.basketPosition) > 261 && mean(handles.basketPosition) < 461
                            left_or_right = randi(2);
                            if left_or_right == 2
                                currX_egg = randi(261);
                            elseif left_or_right == 1
                                currX_egg = randi ([461, 722]);
                            end
                        end
                    end
                
                while handles.axes2.Position(2) > -50 %while the egg falls; before reaching bottom (-50 so it disappears)
                    currY_egg = currY_egg - speed;  %incrementing the current Y of the egg by subtracting value of speed
                    set(handles.axes2, 'Position', [currX_egg currY_egg 50 50]); %makes egg descend every iteration of loop
                    drawnow()
                    
                    %CONSTANTS
                    
                    %I needed to define these constants inside the while
                    %loop, since they need to change every time the
                    %position of the egg changes. Also, I use the function
                    %double for the y values, because there was a problem
                    %with them not being able to read eachother, because
                    %some were integer and some were double. With a speed
                    %incrimentation of 0.5, I chose to transform it into
                    %double instead of integer. 
                    xi_Basket = handles.axes1.Position(1);                      %left of basket
                    yi_Basket = double(handles.axes1.Position(2));              %bottom of basket
                    xf_Basket = xi_Basket + handles.axes1.Position(3);          %right of basket
                    yf_Basket = yi_Basket + double(handles.axes1.Position(4));  %top of basket

                    xi_egg = handles.axes2.Position(1);                         %left of egg
                    yi_egg = double(handles.axes2.Position(2));                 %bottom of egg
                    xf_egg = xi_egg + handles.axes2.Position(3);                %right of egg
                    yf_egg = yi_egg + double(handles.axes2.Position(4));        %top of egg
                    
                    
                    %HITBOX TEST
                    
                    %This is the hitbox coding. Here, the goal is for the
                    %program to understand when the basket catches the egg.
                    %To do this, I am using a "double if" structure, to
                    %check both y and x axes. Firstly, I ask if the top
                    %of the basket is at a bigger or equal position in y
                    %than the bottom of the egg. I also added the fact that
                    %the yi_egg needs to be bigger than 30 to work. This
                    %makes it so that I have a good margin of error. I
                    %couldn't simply say "yf_Basket == yi_egg", because the
                    %speed of the falling object isn't always 1, because it can be
                    %very fast, so the point where they are equal is often skipped. 
                    %Therefore, there needs to be a margin of error. I decided for 
                    %it to be of 68 pixels (62+36 is yf_basket, so -30 is 68). 
                    %Then, I ask if the left of the basket is to the left
                    %of the egg AND if the right of the basket
                    %is to the right of the egg. This gives some good
                    %conditions for the egg to be caught!
                    if yf_Basket >= yi_egg && yi_egg > 30   %if top of basket is higher than bottom of egg
                        if xi_Basket < xi_egg && xf_Basket > xf_egg     %if egg falls in x values of basket
                            score = score + 1;  %every time the egg is caught, the score goes up by 1
                            speed = speed + 0.5;  %every time the egg is caught, the speed goes up by 0.5
                            handles.text3.String = num2str(score);  %updating the score at the top right of the screen
%Pause?
                            break    %I'm breaking the while loop, making the egg start at the top once again
                        end
                    end
                    
                    %If the egg descends all the way to 0 or lower (again, the speed isn't 1, so
                    %there always needs to be a margin of error), the
                    %amount of lives is reduced by 1, and the while loop is
                    %broken, making a new egg at a new position x appear at
                    %the top.
                    if yi_egg <= 0
                        handles.lives = handles.lives - 1;
                        break
                    end
                end

                
                %LIFE COUNTER
                
                %Every time the egg is dropped, the life counter loses an
                %egg. There is one less life egg on the screen, replaced by
                %a blue shadow. I used a switch structure here, even though
                %I could've used an 'if' (would do the same thing).
                %By the way, I had created handles.lives earlier and defined it to 3. 
                    switch handles.lives
                        case 2      %if there are 2 lives left. After you dropped the egg once.
                            
                            %So, let me just explain what I did here. There
                            %was a problem with my function earlier,
                            %because the blue shadow of the egg was created
                            %every loop after the first time, even when the
                            %egg was caught! Since the egg-creating
                            %function is relatively big, at least for my
                            %matlab, there was a little pause every time I
                            %caught the egg. The game was a lot less
                            %smooth. So, to fix this, I figured out a way
                            %that, I agree, can be a bit unconventional, but
                            %works very well! Originally, my axes are made
                            %with '-' grid lines. So, I am saying that if
                            %their grid lines are '-', I can craft this blue
                            %shadow, and then proceed to change the grid
                            %line to 'none'. Next time the code gets to
                            %this point, the grid lines will be of 'none',
                            %stopping us from entering this structure!
                            %So, the blue shadow is only made one time! I 
                            %do the same thing for the second life egg that becomes blue.
                            if  handles.axes8.GridLineStyle == '-'
                                axes(handles.axes8)
                                egg_creator(0.68, 0.85, 0.9)  %light blue coloring
                                handles.axes8.GridLineStyle = 'none';
                            end

                       %when you have 1 life left. After dropping the egg
                       %twice. (same concept as earlier)
                        case 1
                            if  handles.axes7.GridLineStyle == '-'
                                axes(handles.axes7)
                                egg_creator(0.68, 0.85, 0.9)
                                handles.axes7.GridLineStyle = 'none';
                            end
                    end
            end         %end of first while loop
            
            %GAME OVER
            
            %Once we are out of the first while loop, it means the game is over.
            axes(handles.axes5)
            egg_creator(0.68, 0.85, 0.9) %calling the same function as earlier, making the last life egg a light blue shadow
            
            %TO CHANGE MANUALLY!!!!!!!!!
            if score > 42
                scoreboard = msgbox(['WOW! You beat JUDE!! You hold the new high score at ' num2str(score) ' points!!!!'])
            else
                scoreboard = msgbox(['Congrats my child! You scored ' num2str(score) ' points!']);
            end
            
            uiwait         
            restart_ans = questdlg('Would you like to play another game?', ...
                'Selection menu', ...
                'Yes please!', 'No thank you...', 'No thank you...');
            switch restart_ans
                case 'Yes please!'
                    delete(scoreboard);
                    
                    %DIFFICULTY LEVEL
                    %the score on each previous game determines the
                    %difficulty level for the next game
                    if score < 20
                        handles.difficulty = 1;
                    elseif score > 30
                        handles.difficulty = 3;
                    else
                        handles.difficulty = 2;
                    end
                    
                    axes(handles.axes5)
                    egg_creator(1, 0.9, 0.9)
                    axes(handles.axes7)
                    egg_creator(1, 0.9, 0.9)
                    axes(handles.axes8)
                    egg_creator(1, 0.9, 0.9)
                    
                    handles.text10.Visible = 'on';
                   
                case 'No thank you...'
                    delete(scoreboard);
                    closereq();     %when you press OK on the message box, the game (GUI) closes.
            end
    end
    
    
guidata(hObject, handles)



%+-----------------------------------------------------------------------+
%|                           USELESS FUNCTION                            |
%+-----------------------------------------------------------------------+

%I used to have a key release function, but finally didn't need it.
%However, every time I try to delete it, it says 'error'. So to fix this,
%even though it's not the most efficient thing ever, I just say that when a
%key is pressed, a = 1;. This doesn't do anything to my function nor to my
%GUI, it's just a way to satisfy matlab... so you can SKIP THIS PART, it's not important!


% --- Executes on key release with focus on figure1 and none of its controls.
function figure1_KeyReleaseFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was released, in lower case
%	Character: character interpretation of the key(s) that was released
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) released
% handles    structure with handles and user data (see GUIDATA)
a = 1;

guidata(hObject, handles)
        

%+-----------------------------------------------------------------------+
%|                           PAUSING THE GAME                            |
%+-----------------------------------------------------------------------+

%If you want to pause the game, you can click on the toggle button "Pause"
%to pause and unpause the game at will! 

% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1

if handles.togglebutton1.Value == 1     %if the toggle button is pressed, then uiwait. uiwait stops the motion of the egg
   uiwait           %uiwait makes the whole GUI program wait until further notice. It's perfect as a pause function.
else
   uiresume         %Whenever the toggle button is not pressed or unpressed (pressed a second time), resume the GUI.
end
    


%+-----------------------------------------------------------------------+
%|                               MENU BAR                                |
%+-----------------------------------------------------------------------+

%These are simply menu bars, it is a different way to close the GUI, if we
%wanted to. You can simply press on the CLOSE GAME menu, which closes the GUI!

% --------------------------------------------------------------------
function menu_game_Callback(hObject, eventdata, handles)
% hObject    handle to menu_game (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_closegame_Callback(hObject, eventdata, handles)
% hObject    handle to menu_closegame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
save(basketlog, handles.basketPosition)
closereq();     %closing the GUI





%Thank you very much for playing this game! 
%André Kasper Kolstad

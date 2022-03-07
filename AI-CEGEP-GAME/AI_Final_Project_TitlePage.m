%+-------------------------------------------------------+%
%|                ANDRÉ'S EGG SIMULATOR                  |%
%|               Final Project in PI 2020                |%
%+-------------------------------------------------------+%

%Welcome to my Egg Simulator Game. The goal is to catch as many of the 
%falling eggs as possible. However, be weary, the speed of the eggs
%augments as time advances, making it harder and harder. Try to score as
%many points as possible, and compare the results with your friends! As of 
%now, the record to beat is 38 points!! It's a simple yet addicting game, 
%and it's great for the whole family. You can purchase it on the MatLab 
%store for only 99.99$! All jokes aside, I hope that you will enjoy this 
%mini-game, which has a lot of love/frustrating effort put into it :)


function varargout = AI_Final_Project_TitlePage(varargin)
% AI_Final_Project_TitlePage MATLAB code for AI_Final_Project_TitlePage.fig
%      AI_Final_Project_TitlePage, by itself, creates a new AI_Final_Project_TitlePage or raises the existing
%      singleton*.
%
%      H = AI_Final_Project_TitlePage returns the handle to a new AI_Final_Project_TitlePage or the handle to
%      the existing singleton*.
%
%      AI_Final_Project_TitlePage('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AI_Final_Project_TitlePage.M with the given input arguments.
%
%      AI_Final_Project_TitlePage('Property','Value',...) creates a new AI_Final_Project_TitlePage or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AI_Final_Project_TitlePage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AI_Final_Project_TitlePage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AI_Final_Project_TitlePage

% Last Modified by GUIDE v2.5 09-May-2021 19:17:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AI_Final_Project_TitlePage_OpeningFcn, ...
                   'gui_OutputFcn',  @AI_Final_Project_TitlePage_OutputFcn, ...
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


% --- Executes just before AI_Final_Project_TitlePage is made visible.
function AI_Final_Project_TitlePage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AI_Final_Project_TitlePage (see VARARGIN)

% Choose default command line output for AI_Final_Project_TitlePage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AI_Final_Project_TitlePage wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%+-----------------------------------------------------------------------+
%|                              BACKGROUND                               |
%+-----------------------------------------------------------------------+
%I start by adding a background image, which is a neat field with a farm. I am
%defining the axes1 as the axes in question. The axes1 is a big axes that
%is as large as the figure1 (check in GUIDE to understand). I then read and show the
%matrix of the background image, which appears directly onto axes1.

axes(handles.axes1)
imshow(imread('title_background.png'));


%+-----------------------------------------------------------------------+
%|                            CENTER SCREEN                              |
%+-----------------------------------------------------------------------+
%This code makes the GUI pop up fully centered. This is used to make the
%whole look more esthetic. 
screenS = get(0, 'ScreenSize'); 
xPix = screenS(3);  %defining the width of the screen
yPix = screenS(4);  %defining the height of the screen
set(hObject, 'Units', 'pixels');    %putting the units into pixels
figPos = get(hObject, 'Position');   
w = figPos(3);      %defining the width of the figure1
h = figPos(4);      %defining the height of the figure1 
set(hObject, 'Position', [(xPix-w)/2 , (yPix-h)/2, w, h]);      %placing the screen/figure in the middle


% --- Outputs from this function are returned to the command line.
function varargout = AI_Final_Project_TitlePage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%+-----------------------------------------------------------------------+
%|                             PLAY BUTTON                               |
%+-----------------------------------------------------------------------+
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%When you press 'play', the program will close this GUI and lead you to the
%second GUI where the game will be played. However, you need to have
%written your name in order for you to be able to press 'play'. Since the original 
%text in the edit1 box is 'Write your name', I am using a string compare
%function to check if the name in the edit box when pressing the 'play'
%button has been changed or not. If it has been modified, then it means the
%user put in a name, if it's the same as before, the user forgot to put in
%their name.
if strcmp(handles.edit1.String, 'Write your name') == 1     %if the text in edit1 has not been modified
    errordlg('Please write your name before playing.');       %error message pops up and tells the user to write their name

else                                                        %if the text in edit1 HAS been modified
    username = handles.edit1.String;        %text in the edit1 is defined as the username
    wtbr = waitbar(0, ['Please wait a moment, ' username '.']);     %creates a waitbar that uses the user's name
    for i = 0:0.33:1        %I'm giving the waitbar three main ticks, using a for loop to make jumps of 1/3 of the bar
        waitbar(i, wtbr);   %updating the waitbar with the new tick
        pause(1);           %adding a little pause between each tick
    end
    waitbar(1, wtbr, ['Ready? GOOOOOOO!!']);  %updating the final waitbar screen, when it's at 100%, with different text.
    pause(2);                   %adding a small pause before deleting everything so the user can read the text.
    close(wtbr)             %close the wait bar

  contents = get(handles.popupmenu2,'String'); 
  popupmenu2value = contents{get(handles.popupmenu2,'Value')};
  switch popupmenu2value
      case 'Minecraft'
        closereq();
        run('AI_Final_Project_Game.m');
      case 'Mario'
        closereq();
        run('Cute_AI_Final_Project_Game.m');
      case 'Doom'
        closereq();
        run('Violent_AI_Final_Project_Game.m');
  end
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','yellow');
end

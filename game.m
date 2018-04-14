function varargout = game(varargin)
% GAME MATLAB code for game.fig
%      GAME, by itself, creates a new GAME or raises the existing
%      singleton*.
%
%      H = GAME returns the handle to a new GAME or the handle to
%      the existing singleton*.
%
%      GAME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAME.M with the given input arguments.
%
%      GAME('Property','Value',...) creates a new GAME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before game_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to game_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help game

% Last Modified by GUIDE v2.5 13-Jul-2017 16:29:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @game_OpeningFcn, ...
                   'gui_OutputFcn',  @game_OutputFcn, ...
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


% --- Executes just before game is made visible.
function game_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to game (see VARARGIN)
%Create the figure

handles.score = 0;
handles.board = zeros(4,4);
handles.goal = 2048;

% To find the highest score record of the game
if exist('record.mat', 'file') == 2
    load ('record.mat');
    handles.highest_score = highest_score;
else
    handles.highest_score = 0;
end

draw_board(handles.board);
set(handles.highest_score_text,'String',num2str(handles.highest_score));
set(handles.axes1,'Color',[0.8235,0.8235,0.8235]);

% Choose default command line output for game
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes game wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = game_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes the start_button
function Start_button_Callback(hObject, eventdata, handles)
% hObject    handle to Start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of Start_button



handles.score = 0;
% handles.board = [2,4,8,16;32,64,128,256;512,1024,2048,4096;8192,16384,32768,65536];
% handles.board = [512,64,4,128;2,16,32,8;8,4,8,4;0,8,1024,2];
handles.board = initialize_board;


handles.record = [];
handles.record(1).board = handles.board;
handles.record(1).score = handles.score;

set(handles.score_text,'String',num2str(handles.score));
set(handles.condition_text,'String','');


draw_board(handles.board);

guidata(hObject, handles);




% --- Executes on button press in move_up.
function move_up_Callback(hObject, eventdata, handles)
% hObject    handle to move_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[updated_board, valid_move, updated_score] = move_2048('w',handles.board,handles.score);
%only update information when valid move is made
if valid_move
    handles.record(length(handles.record)+1).board = handles.board;
    handles.record(length(handles.record)).score = handles.score;
    handles.board = updated_board;
    handles.score = updated_score;
    handles.board = generate_block(handles.board);
end

set_highest_score(handles)
set(handles.score_text,'String',num2str(handles.score));

draw_board(handles.board);
check_win_lose(handles);
guidata(hObject, handles);




% --- Executes on button press in move_left.
function move_left_Callback(hObject, eventdata, handles)
% hObject    handle to move_left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[updated_board, valid_move, updated_score] = move_2048('a',handles.board,handles.score);
%only update information when valid move is made
if valid_move
    handles.record(length(handles.record)+1).board = handles.board;
    handles.record(length(handles.record)).score = handles.score;
    handles.board = updated_board;
    handles.score = updated_score;
    handles.board = generate_block(handles.board);
end

set_highest_score(handles)
set(handles.score_text,'String',num2str(handles.score));

draw_board(handles.board);
check_win_lose(handles);
guidata(hObject, handles);


% --- Executes on button press in move_right.
function move_right_Callback(hObject, eventdata, handles)
% hObject    handle to move_right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[updated_board, valid_move, updated_score] = move_2048('d',handles.board,handles.score);
%only update information when valid move is made
if valid_move
    handles.record(length(handles.record)+1).board = handles.board;
    handles.record(length(handles.record)).score = handles.score;
    handles.board = updated_board;
    handles.score = updated_score;
    handles.board = generate_block(handles.board);
end

set_highest_score(handles)
set(handles.score_text,'String',num2str(handles.score));

draw_board(handles.board);
check_win_lose(handles);
guidata(hObject, handles);



% --- Executes on button press in move_down.
function move_down_Callback(hObject, eventdata, handles)
% hObject    handle to move_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[updated_board, valid_move, updated_score] = move_2048('s',handles.board,handles.score);
%only update information when valid move is made
if valid_move
    handles.record(length(handles.record)+1).board = handles.board;
    handles.record(length(handles.record)).score = handles.score;
    handles.board = updated_board;
    handles.score = updated_score;
    handles.board = generate_block(handles.board);
end

set_highest_score(handles)
set(handles.score_text,'String',num2str(handles.score));

draw_board(handles.board);
check_win_lose(handles);
guidata(hObject, handles);

% --- Executes on button press in move_undo.
function move_undo_Callback(hObject, eventdata, handles)
% hObject    handle to move_undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.board =  handles.record(length(handles.record)).board;
handles.score =  handles.record(length(handles.record)).score;
handles.record(length(handles.record)) = [];

set_highest_score(handles)
set(handles.score_text,'String',num2str(handles.score));

draw_board(handles.board);
check_win_lose(handles);
guidata(hObject, handles);

% update the board by putting handles.board
function draw_board(board)

t=(1/8:1/4:1)'*2*pi;
cla;
hold on;
for i=1:4
    for k=1:4
        x=(cos(t)+k*2-1)*0.5;
        y=(sin(t)+(5-i)*2-1)*0.5;
        switch( board(i,k) )
            case 0
                fill(x,y,[0.796,0.796,0.796]);
            case 2
                fill(x,y,[0.992,1,0.87]);
            case 4
                fill(x,y,[0.95,0.976,0.683]);
            case 8
                fill(x,y,[0.99,0.781,0.4]);
            case 16
                fill(x,y,[1,0.58,0.4]);
            case 32
                fill(x,y,[0.894,0.341,0.231]);
            case 64
                fill(x,y,[0.870,0.247,0.121]);
            case 128
                fill(x,y,[0.932,0.976,0.35686]);
            case 256
                fill(x,y,[0.9215,0.9529,0.455]);
            case 512
                fill(x,y,[0.909,0.953,0.3058]);
            case 1024
                fill(x,y,[0.2924,0.98,0.2217]);
            case 2048
                fill(x,y,[1,0.8705,0]);
            case 4096
                fill(x,y,[0.490,0.8352,0.98]);
            case 8192
                fill(x,y,[0.9647,0.396,0.945]);
            case 16384
                fill(x,y,[0.137,1,0.196]);
            case 32768
                fill(x,y,[0.682,0.2235,0.988]);
            case 65536
                fill(x,y,[0.607,0.6,0.6039]);
            otherwise
                fill(x,y,'white');                
        end             
    end
end
hold off;
axis square

for i=1:length(board)
    for k=1:length(board)
        switch( board(i,k) )
            case 0
            case {2,4,8}
                h=text((k*2-1.15)*0.5,(10 - i*2-1)*0.5,num2str(board(i,k)));
                h.FontSize=40;
                h.Color = [0.3529,0.3529,0.3529];
            case {16,32,64}
                h=text((k*2-1.3)*0.5,(10 - i*2-1)*0.5,num2str(board(i,k)));
                h.FontSize=40;
                h.Color = 'white';
            case {128,256,512}
                h=text((k*2-1.48)*0.5,(10 - i*2-1)*0.5,num2str(board(i,k)));
                h.FontSize=40;
                h.Color = [0.3529,0.3529,0.3529];
            case {1024,2048,4096,8192}
                h=text((k*2-1.48)*0.5,(10 - i*2-1)*0.5,num2str(board(i,k)));
                h.FontSize=30;
                h.Color = 'white';
            case {16384,32768,65536}
                h=text((k*2-1.5)*0.5,(10 - i*2-1)*0.5,num2str(board(i,k)));
                h.FontSize=25;
                h.Color = 'white';
            otherwise
                h=text((k*2-1.15)*0.5,(10 - i*2-1)*0.5,num2str(board(i,k)));
                h.FontSize=10;
                h.Color = 'white';
        end      
    end
end
hold off;

% check the win and lose condition
function check_win_lose(handles)
%Check win and lose condition

if checklose(handles.board)
    set(handles.condition_text,'String','You Lose','ForegroundColor','red');
elseif checkwin(handles.goal,handles.board)
    set(handles.condition_text,'String','You Win','ForegroundColor','green');
else
    set(handles.condition_text,'String','');
end
    

% update and save the highest score
function set_highest_score(handles)
if handles.score > handles.highest_score
    handles.highest_score = handles.score;
    set(handles.highest_score_text,'String',num2str(handles.highest_score));
    highest_score = handles.highest_score;
    save('record.mat' ,'highest_score');
end  


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

switch eventdata.Key
    case 'leftarrow'
        move_left_Callback(hObject, eventdata, handles)
    case 'rightarrow'
        move_right_Callback(hObject, eventdata, handles)
    case 'uparrow'
        move_up_Callback(hObject, eventdata, handles)
    case 'downarrow'
        move_down_Callback(hObject, eventdata, handles)
    case 'u'
        move_undo_Callback(hObject, eventdata, handles)
    case 'return'
        Start_button_Callback(hObject, eventdata, handles) 
end

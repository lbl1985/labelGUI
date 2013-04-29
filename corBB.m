function varargout = corBB(varargin)
% CORBB MATLAB code for corBB.fig
%      CORBB, by itself, creates a new CORBB or raises the existing
%      singleton*.
%
%      H = CORBB returns the handle to a new CORBB or the handle to
%      the existing singleton*.
%
%      CORBB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CORBB.M with the given input arguments.
%
%      CORBB('Property','Value',...) creates a new CORBB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before corBB_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to corBB_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help corBB

% Last Modified by GUIDE v2.5 11-May-2012 10:43:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @corBB_OpeningFcn, ...
                   'gui_OutputFcn',  @corBB_OutputFcn, ...
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


% --- Executes just before corBB is made visible.
function corBB_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to corBB (see VARARGIN)

handles.cor = [];
handles.corData = [];
handles.isStop.cam1 = 0;
handles.isStop.cam2 = 0;
set(handles.isStop.cam1, 'UserData', false);
set(handles.isStop.cam2, 'UserData', false);
% Choose default command line output for corBB
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes corBB wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = corBB_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function cam1slider_Callback(hObject, eventdata, handles)
% hObject    handle to cam1slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.cam1.currentFrame = round(get(hObject, 'Value'));
imshow(read(handles.cam1.obj, handles.cam1.currentFrame), 'Parent', handles.cam1show);
set(handles.cam1frame, 'String', ['Frame ' num2str(handles.cam1.currentFrame)]);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function cam1slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cam1slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function cam2slider_Callback(hObject, eventdata, handles)
% hObject    handle to cam2slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.cam2.currentFrame = round(get(hObject, 'Value'));
imshow(read(handles.cam2.obj, handles.cam2.currentFrame), 'Parent', handles.cam2show);
set(handles.cam2frame, 'String', ['Frame ' num2str(handles.cam2.currentFrame)]);


uicontrol(hObject);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function cam2slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cam2slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function cam1Name_Callback(hObject, eventdata, handles)
% hObject    handle to cam1Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cam1Name as text
%        str2double(get(hObject,'String')) returns contents of cam1Name as a double
cam1Name = get(hObject, 'String');
handles.cam1.name = cam1Name;
uicontrol(hObject);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function cam1Name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cam1Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cam2Name_Callback(hObject, eventdata, handles)
% hObject    handle to cam2Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cam2Name as text
%        str2double(get(hObject,'String')) returns contents of cam2Name as a double
cam2Name = get(hObject, 'String');
handles.cam2.name = cam2Name;
uicontrol(hObject);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function cam2Name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cam2Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadButton.
function loadButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
handles.cam1.Name = get(handles.cam1Name, 'String');
handles.cam1.obj = VideoReader(handles.cam1.Name);
handles.cam1.NumberOfFrames = handles.cam1.obj.NumberOfFrames;
handles.cam1.currentFrame = 1;
set(handles.cam1slider, 'Max', handles.cam1.NumberOfFrames);
set(handles.cam1slider, 'SliderStep', [1/(handles.cam1.NumberOfFrames -1) 0.1]);
set(handles.cam1slider, 'Value', 1);

handles.cam2.Name = get(handles.cam2Name, 'String');
handles.cam2.obj = VideoReader(handles.cam2.Name);
handles.cam2.NumberOfFrames = handles.cam2.obj.NumberOfFrames;
handles.cam2.currentFrame = 1;
set(handles.cam2slider, 'Max', handles.cam2.NumberOfFrames);
set(handles.cam2slider, 'SliderStep', [1/(handles.cam2.NumberOfFrames -1) 0.1]);
set(handles.cam2slider, 'Value', 1);

imshow(read(handles.cam1.obj, handles.cam1.currentFrame), 'Parent', handles.cam1show);
set(handles.cam1frame, 'String', ['Frame ' num2str(handles.cam1.currentFrame)]);
imshow(read(handles.cam2.obj, handles.cam2.currentFrame), 'Parent', handles.cam2show);
set(handles.cam2frame, 'String', ['Frame ' num2str(handles.cam2.currentFrame)]);

% h1 = imrect(handles.cam1show, [10 10 100 100]);
% handles.cam1.rect = wait(h1);
% 
% h2 = imrect(handles.cam2show, [10 10 100 100]);
% handles.cam2.rect = wait(h2);
% 
% handles.cam1.preRect = handles.cam1.rect;
% handles.cam2.preRect = handles.cam2.rect;

uicontrol(hObject);
guidata(hObject, handles);


% --- Executes on button press in cam1prev.
function cam1prev_Callback(hObject, eventdata, handles)
% hObject    handle to cam1prev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam1.currentFrame = handles.cam1.currentFrame - 1;
set(handles.cam1slider, 'Value', handles.cam1.currentFrame);
set(handles.cam1frame, 'String', ['Frame ' num2str(handles.cam1.currentFrame)]);
imshow(read(handles.cam1.obj, handles.cam1.currentFrame), 'Parent', handles.cam1show);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in cam1prev2.
function cam1prev2_Callback(hObject, eventdata, handles)
% hObject    handle to cam1prev2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam1.currentFrame = handles.cam1.currentFrame - 50;
set(handles.cam1slider, 'Value', handles.cam1.currentFrame);
set(handles.cam1frame, 'String', ['Frame ' num2str(handles.cam1.currentFrame)]);
imshow(read(handles.cam1.obj, handles.cam1.currentFrame), 'Parent', handles.cam1show);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in cam1next.
function cam1next_Callback(hObject, eventdata, handles)
% hObject    handle to cam1next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam1.currentFrame = handles.cam1.currentFrame + 1;
set(handles.cam1slider, 'Value', handles.cam1.currentFrame);
set(handles.cam1frame, 'String', ['Frame ' num2str(handles.cam1.currentFrame)]);
imshow(read(handles.cam1.obj, handles.cam1.currentFrame), 'Parent', handles.cam1show);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in cam1next2.
function cam1next2_Callback(hObject, eventdata, handles)
% hObject    handle to cam1next2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam1.currentFrame = handles.cam1.currentFrame + 50;
set(handles.cam1slider, 'Value', handles.cam1.currentFrame);
set(handles.cam1frame, 'String', ['Frame ' num2str(handles.cam1.currentFrame)]);
imshow(read(handles.cam1.obj, handles.cam1.currentFrame), 'Parent', handles.cam1show);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in cam2prev.
function cam2prev_Callback(hObject, eventdata, handles)
% hObject    handle to cam2prev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam2.currentFrame = handles.cam2.currentFrame - 1;
set(handles.cam2slider, 'Value', handles.cam2.currentFrame);
set(handles.cam2frame, 'String', ['Frame ' num2str(handles.cam2.currentFrame)]);
imshow(read(handles.cam2.obj, handles.cam2.currentFrame), 'Parent', handles.cam2show);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in cam2prev2.
function cam2prev2_Callback(hObject, eventdata, handles)
% hObject    handle to cam2prev2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam2.currentFrame = handles.cam2.currentFrame - 50;
set(handles.cam2slider, 'Value', handles.cam2.currentFrame);
set(handles.cam2frame, 'String', ['Frame ' num2str(handles.cam2.currentFrame)]);
imshow(read(handles.cam2.obj, handles.cam2.currentFrame), 'Parent', handles.cam2show);

uicontrol(hObject);
guidata(hObject, handles);


% --- Executes on button press in cam2next.
function cam2next_Callback(hObject, eventdata, handles)
% hObject    handle to cam2next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam2.currentFrame = handles.cam2.currentFrame + 1;
set(handles.cam2slider, 'Value', handles.cam2.currentFrame);
set(handles.cam2frame, 'String', ['Frame ' num2str(handles.cam2.currentFrame)]);
imshow(read(handles.cam2.obj, handles.cam2.currentFrame), 'Parent', handles.cam2show);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in cam2next2.
function cam2next2_Callback(hObject, eventdata, handles)
% hObject    handle to cam2next2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam2.currentFrame = handles.cam2.currentFrame + 50;
set(handles.cam2slider, 'Value', handles.cam2.currentFrame);
set(handles.cam2frame, 'String', ['Frame ' num2str(handles.cam2.currentFrame)]);
imshow(read(handles.cam2.obj, handles.cam2.currentFrame), 'Parent', handles.cam2show);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in link.
function link_Callback(hObject, eventdata, handles)
% hObject    handle to link (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cam1I = read(handles.cam1.obj, handles.cam1.currentFrame);
cam1.bb = handles.cam1.rect;
cam1.region = rectroi(cam1I, cam1.bb([2 1 4 3]));
cam1.t = handles.cam1.currentFrame;

cam2I = read(handles.cam2.obj, handles.cam2.currentFrame);
cam2.bb = handles.cam2.rect;
cam2.region = rectroi(cam2I, cam2.bb([2 1 4 3]));
cam2.t = handles.cam2.currentFrame;



tmpcor.cam1 = cam1; 
tmpcor.cam2 = cam2;

handles.cor = cat(1, handles.cor, tmpcor);
handles.corData = cat(1, handles.corData, [cam1.bb cam1.t cam2.bb cam2.t]);

imshow(handles.cor(end).cam1.region, 'Parent', handles.cam1region);
imshow(handles.cor(end).cam2.region, 'Parent', handles.cam2region);

set(handles.regionInfo, 'Data', handles.corData);

guidata(hObject, handles);

% --- Executes on button press in cam1label.
function cam1label_Callback(hObject, eventdata, handles)
% hObject    handle to cam1label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles.cam1, 'rect')
    h1 = imrect(handles.cam1show, [10 10 100 100]);
else
    h1 = imrect(handles.cam1show, handles.cam1.preRect);
end
handles.cam1.rect = wait(h1);
setColor(h1, 'g');
handles.cam1.rect = round(handles.cam1.rect);
handles.cam1.preRect = handles.cam1.rect;
guidata(hObject, handles);

    

% --- Executes on button press in cam2label.
function cam2label_Callback(hObject, eventdata, handles)
% hObject    handle to cam2label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles.cam2, 'rect')
    h2 = imrect(handles.cam2show, [10 10 100 100]);
else
    h2 = imrect(handles.cam2show, handles.cam2.preRect);
end
handles.cam2.rect = wait(h2);
setColor(h2, 'g');
handles.cam2.rect = round(handles.cam2.rect);
handles.cam2.preRect = handles.cam2.rect;
guidata(hObject, handles);

% --- Executes on button press in Quick.
function Quick_Callback(hObject, eventdata, handles)
% hObject    handle to Quick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in regionInfo.
function regionInfo_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to regionInfo (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
handles.currSelection = eventdata.Indices(:,1);
if length(handles.currSelection) ~= 1
    error('You can only select one line.');
end

id = handles.currSelection;
imshow(read(handles.cam1.obj, handles.cor(id).cam1.t), 'Parent', handles.cam1show);
imshow(read(handles.cam2.obj, handles.cor(id).cam2.t), 'Parent', handles.cam2show);
imshow(handles.cor(id).cam1.region, 'Parent', handles.cam1region);
imshow(handles.cor(id).cam2.region, 'Parent', handles.cam2region);

handles.cam1.currentFrame = handles.cor(id).cam1.t;
set(handles.cam1slider, 'Value', handles.cam1.currentFrame);
set(handles.cam1frame, 'String', ['Frame ' handles.cam1.currentFrame]);

handles.cam1.currentFrame = handles.cor(id).cam2.t;
set(handles.cam2slider, 'Value', handles.cam1.currentFrame);
set(handles.cam2frame, 'String', ['Frame ' handles.cam1.currentFrame]);

guidata(hObject, handles);


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
corData = handles.corData;
cor = handles.cor;
save('corData.mat', 'corData', 'cor');

% --- Executes on button press in Delete.
function Delete_Callback(hObject, eventdata, handles)
% hObject    handle to Delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
index = [1 : handles.currSelection - 1 ...
    handles.currSelection + 1 : size(handles.corData, 1)];
handles.corData = handles.corData(index, :);
handles.cor = handles.cor(index);
set(handles.regionInfo, 'Data', handles.corData);
guidata(hObject, handles);


% --- Executes on button press in cam1play.
function cam1play_Callback(hObject, eventdata, handles)
% hObject    handle to cam1play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
keepRunning = true;
while keepRunning
    handles.cam1.currentFrame = handles.cam1.currentFrame + 1;    
    set(handles.cam1slider, 'Value', handles.cam1.currentFrame);
    set(handles.cam1frame, 'String', ['Frame ' num2str(handles.cam1.currentFrame)]);
    imshow(read(handles.cam1.obj, handles.cam1.currentFrame), 'Parent', handles.cam1show);
    pause(1/22);
    userData = get(handles.isStop.cam1, 'UserData');
    if userData
        keepRunning = false;
    end
end
set(handles.isStop.cam1, 'UserData', false);

uicontrol(hObject);
guidata(hObject, handles);


% --- Executes on button press in cam1stop.
function cam1stop_Callback(hObject, eventdata, handles)
% hObject    handle to cam1stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.isStop.cam1, 'UserData', true);
% handles.isStop.cam2 = 1;
guidata(hObject, handles);

% --- Executes on button press in cam1playback.
function cam1playback_Callback(hObject, eventdata, handles)
% hObject    handle to cam1playback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
keepRunning = true;
while keepRunning
    handles.cam1.currentFrame = handles.cam1.currentFrame - 1;    
    set(handles.cam1slider, 'Value', handles.cam1.currentFrame);
    set(handles.cam1frame, 'String', ['Frame ' num2str(handles.cam1.currentFrame)]);
    imshow(read(handles.cam1.obj, handles.cam1.currentFrame), 'Parent', handles.cam1show);
    pause(1/22);
    userData = get(handles.isStop.cam1, 'UserData');
    if userData
        keepRunning = false;
    end
end
set(handles.isStop.cam1, 'UserData', false);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in cam2playback.
function cam2playback_Callback(hObject, eventdata, handles)
% hObject    handle to cam2playback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
keepRunning = true;
while keepRunning
    handles.cam2.currentFrame = handles.cam2.currentFrame - 1;    
    set(handles.cam2slider, 'Value', handles.cam2.currentFrame);
    set(handles.cam2frame, 'String', ['Frame ' num2str(handles.cam2.currentFrame)]);
    imshow(read(handles.cam2.obj, handles.cam2.currentFrame), 'Parent', handles.cam2show);
    pause(1/22);
    userData = get(handles.isStop.cam2, 'UserData');
    if userData
        keepRunning = false;
    end
end
set(handles.isStop.cam2, 'UserData', false);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in cam2play.
function cam2play_Callback(hObject, eventdata, handles)
% hObject    handle to cam2play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
keepRunning = true;
while keepRunning
    handles.cam2.currentFrame = handles.cam2.currentFrame + 1;    
    set(handles.cam2slider, 'Value', handles.cam2.currentFrame);
    set(handles.cam2frame, 'String', ['Frame ' num2str(handles.cam2.currentFrame)]);
    imshow(read(handles.cam2.obj, handles.cam2.currentFrame), 'Parent', handles.cam2show);
    pause(1/22);
    userData = get(handles.isStop.cam2, 'UserData');
    if userData
        keepRunning = false;
    end
end
set(handles.isStop.cam2, 'UserData', false);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in cam2stop.
function cam2stop_Callback(hObject, eventdata, handles)
% hObject    handle to cam2stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% data = get(handles.isStop.cam1, 'UserData');
% data = true;
set(handles.isStop.cam2, 'UserData', true);
% handles.isStop.cam2 = 1;
guidata(hObject, handles);

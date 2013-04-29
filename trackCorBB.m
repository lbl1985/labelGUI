function varargout = trackCorBB(varargin)
% TRACKCORBB MATLAB code for trackCorBB.fig
%      TRACKCORBB, by itself, creates a new TRACKCORBB or raises the existing
%      singleton*.
%
%      H = TRACKCORBB returns the handle to a new TRACKCORBB or the handle to
%      the existing singleton*.
%
%      TRACKCORBB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRACKCORBB.M with the given input arguments.
%
%      TRACKCORBB('Property','Value',...) creates a new TRACKCORBB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before trackCorBB_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to trackCorBB_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help trackCorBB

% Last Modified by GUIDE v2.5 16-May-2012 09:57:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trackCorBB_OpeningFcn, ...
                   'gui_OutputFcn',  @trackCorBB_OutputFcn, ...
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


% --- Executes just before trackCorBB is made visible.
function trackCorBB_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to trackCorBB (see VARARGIN)

handles.Person = [];
% Choose default command line output for trackCorBB
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes trackCorBB wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = trackCorBB_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function editFileName1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFileName1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function editFileName2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFileName2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function sliderCam1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderCam1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function sliderCam2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderCam2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%% Utility Functions
function handles = updateImage(handles, id)

switch num2str(id)
    case '1'
        handles.cam1.I = read(handles.cam1.obj, handles.cam1.currentFrame);
        imshow(handles.cam1.I, 'Parent', handles.axesCam1);
        set(handles.textCam1VideoInfo, 'String', ['Video: ' handles.cam1.Person(1).VideoName ...
            ' Frame:' num2str(handles.cam1.currentFrame)]);
        handles = updateAxesCamBB(handles, 1);
        set(handles.sliderCam1, 'Value', handles.cam1.currentFrame);
    case '2'
        handles.cam2.I = read(handles.cam2.obj, handles.cam2.currentFrame);
        imshow(handles.cam2.I, 'Parent', handles.axesCam2);
        set(handles.textCam2VideoInfo, 'String', ['Video: ' handles.cam2.Person(1).VideoName ...
            ' Frame:' num2str(handles.cam2.currentFrame)]);
        handles = updateAxesCamBB(handles, 2);
        set(handles.sliderCam2, 'Value', handles.cam2.currentFrame);
    otherwise
        error('Only two camera is allowed.');
end


function handles = updateAxesCamBB(handles, id)

switch num2str(id)
    case '1'
        if ~isempty(handles.cam1.tmpPerson)
            % tmpPerson is not empty
            if handles.cam1.currentFrame >= handles.cam1.tmpPerson.t(1) && handles.cam1.currentFrame <= handles.cam1.tmpPerson.t(end)
                % current Frame is within the labeling range
                ind = find(handles.cam1.tmpPerson.t == handles.cam1.currentFrame);
                if ~isempty(ind)
                    % currentFrame is when key labeling happening
                    rectangle('Position', handles.cam1.tmpPerson.key(ind, :), 'EdgeColor', 'r', ...
                        'LineWidth', 2, 'Parent', handles.axesCam1);
                else
                    ind = find(handles.cam1.tmpPerson.tAll == handles.cam1.currentFrame);
                    rectangle('Position', handles.cam1.tmpPerson.rectAll(ind, :), 'EdgeColor', 'b', ...
                        'LineWidth', 2, 'Parent', handles.axesCam1); %#ok<FNDSB>
                end
            end
        end
    case '2'
        if ~isempty(handles.cam2.tmpPerson)
            % tmpPerson is not empty
            if handles.cam2.currentFrame >= handles.cam2.tmpPerson.t(1) && handles.cam2.currentFrame <= handles.cam2.tmpPerson.t(end)
                % current Frame is within the labeling range
                ind = find(handles.cam2.tmpPerson.t == handles.cam2.currentFrame);
                if ~isempty(ind)
                    % currentFrame is when key labeling happening
                    rectangle('Position', handles.cam2.tmpPerson.key(ind, :), 'EdgeColor', 'r', ...
                        'LineWidth', 2, 'Parent', handles.axesCam2);
                else
                    ind = find(handles.cam2.tmpPerson.tAll == handles.cam2.currentFrame);
                    rectangle('Position', handles.cam2.tmpPerson.rectAll(ind, :), 'EdgeColor', 'b', ...
                        'LineWidth', 2, 'Parent', handles.axesCam2); %#ok<FNDSB>
                end
            end
        end
    otherwise
        error('Only two camera is allowed.');
end

function handles = updatePerson(handles, id)
switch num2str(id)
    case '1'
        nPerson = length(handles.cam1.Person);
        handles.PersonInfo1 = cell(nPerson, 4);
        for i = 1 : nPerson
            handles.PersonInfo1{i, 1} = handles.cam1.Person(i).Id(1);
            handles.PersonInfo1{i, 2} = handles.cam1.Person(i).t(1);
            handles.PersonInfo1{i, 3} = handles.cam1.Person(i).t(end);
            handles.PersonInfo1{i, 4} = handles.cam1.Person(i).VideoName;
        end
        set(handles.uitablePerson1, 'Data', handles.PersonInfo1);
    case '2'
        nPerson = length(handles.cam2.Person);
        handles.PersonInfo2 = cell(nPerson, 4);
        for i = 1 : nPerson
            handles.PersonInfo2{i, 1} = handles.cam2.Person(i).Id(1);
            handles.PersonInfo2{i, 2} = handles.cam2.Person(i).t(1);
            handles.PersonInfo2{i, 3} = handles.cam2.Person(i).t(end);
            handles.PersonInfo2{i, 4} = handles.cam2.Person(i).VideoName;
        end
        set(handles.uitablePerson2, 'Data', handles.PersonInfo2);
    otherwise
        error('Only two camera is allowed.');
end

function handles = updateComPerson(handles)
nPerson = length(handles.Person);
if nPerson ~= 0
    handles.PersonInfo = cell(nPerson, 3);
    for i = 1 : nPerson
        fieldNames = fieldnames(handles.Person{i});
        handles.PersonInfo{i, 1} = handles.Person{i}.Id;
        for j = 2 : length(fieldNames)
            handles.PersonInfo{i, j} = fieldNames{j};
        end
    end

    set(handles.uitableComPerson, 'Data', handles.PersonInfo);
else
    set(handles.uitableComPerson, 'Data', []);
end

%% Functionalities
% --- Executes on button press in pbLoad1.
function pbLoad1_Callback(hObject, eventdata, handles)
% hObject    handle to pbLoad1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc; 
handles.cam1.tmpPerson = [];

handles.cam1.loadFileName = get(handles.editFileName1, 'String');

load(handles.cam1.loadFileName);
str = ['handles.cam1.Person = Person_' handles.cam1.loadFileName(10:end-4) ';'];
eval(str);
handles.cam1.VideoName = handles.cam1.loadFileName(10:end-4);
handles = updatePerson(handles, 1);


% handles.cam.VideoFile = get(handles.editCam, 'String');
% ind = strfind(handles.cam.VideoFile, '/');
% handles.cam.VideoName = handles.cam.VideoFile(ind(end) + 1 : end - 4);
handles.cam1.obj = VideoReader(handles.cam1.Person(1).VideoFile);
handles.cam1.NumberOfFrames = handles.cam1.obj.NumberOfFrames;
handles.cam1.currentFrame = 1;
set(handles.sliderCam1, 'Max', handles.cam1.NumberOfFrames);
set(handles.sliderCam1, 'SliderStep', [1/(handles.cam1.NumberOfFrames -1) 0.1]);
set(handles.sliderCam1, 'Value', 1);

handles = updateImage(handles, 1);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in pbLoad2.
function pbLoad2_Callback(hObject, eventdata, handles)
% hObject    handle to pbLoad2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc; 
handles.cam2.tmpPerson = [];

handles.cam2.loadFileName = get(handles.editFileName2, 'String');

load(handles.cam2.loadFileName);
str = ['handles.cam2.Person = Person_' handles.cam2.loadFileName(10:end-4) ';'];
eval(str);
handles.cam2.VideoName = handles.cam2.loadFileName(10:end-4);
handles = updatePerson(handles, 2);


% handles.cam.VideoFile = get(handles.editCam, 'String');
% ind = strfind(handles.cam.VideoFile, '/');
% handles.cam.VideoName = handles.cam.VideoFile(ind(end) + 1 : end - 4);
handles.cam2.obj = VideoReader(handles.cam2.Person(1).VideoFile);
handles.cam2.NumberOfFrames = handles.cam2.obj.NumberOfFrames;
handles.cam2.currentFrame = 1;
set(handles.sliderCam2, 'Max', handles.cam2.NumberOfFrames);
set(handles.sliderCam2, 'SliderStep', [1/(handles.cam2.NumberOfFrames -1) 0.1]);
set(handles.sliderCam2, 'Value', 1);

handles = updateImage(handles, 2);

uicontrol(hObject);
guidata(hObject, handles);

%% Camera Controling Section
% --- Executes on slider movement.
function sliderCam1_Callback(hObject, eventdata, handles)
% hObject    handle to sliderCam1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.cam1.currentFrame = round(get(hObject, 'Value'));
handles = updateImage(handles, 1);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on slider movement.
function sliderCam2_Callback(hObject, eventdata, handles)
% hObject    handle to sliderCam2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.cam2.currentFrame = round(get(hObject, 'Value'));
handles = updateImage(handles, 2);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in pbCam1Next.
function pbCam1Next_Callback(hObject, eventdata, handles)
% hObject    handle to pbCam1Next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam1.currentFrame = handles.cam1.currentFrame + 1;
handles = updateImage(handles, 1);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in pbCam1Next2.
function pbCam1Next2_Callback(hObject, eventdata, handles)
% hObject    handle to pbCam1Next2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam1.currentFrame = handles.cam1.currentFrame + 20;
handles = updateImage(handles, 1);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in pbCam1Prev.
function pbCam1Prev_Callback(hObject, eventdata, handles)
% hObject    handle to pbCam1Prev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam1.currentFrame = handles.cam1.currentFrame - 1;
handles = updateImage(handles, 1);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in pbCam1Prev2.
function pbCam1Prev2_Callback(hObject, eventdata, handles)
% hObject    handle to pbCam1Prev2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam1.currentFrame = handles.cam1.currentFrame - 20;
handles = updateImage(handles, 1);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in tbCam1Play.
function tbCam1Play_Callback(hObject, eventdata, handles)
% hObject    handle to tbCam1Play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbCam1Play
isPushed = get(hObject, 'Value');
while isPushed
    handles.cam1.currentFrame = handles.cam1.currentFrame + 1;
    handles = updateImage(handles, 1);
    pause(1/11);
    isPushed = get(hObject, 'Value');
end
uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in tbCam1Playback.
function tbCam1Playback_Callback(hObject, eventdata, handles)
% hObject    handle to tbCam1Playback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbCam1Playback
isPushed = get(hObject, 'Value');
while isPushed
    handles.cam1.currentFrame = handles.cam1.currentFrame - 1;
    handles = updateImage(handles, 1);
    pause(1/11);
    isPushed = get(hObject, 'Value');
end
uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in pbCam2Next.
function pbCam2Next_Callback(hObject, eventdata, handles)
% hObject    handle to pbCam2Next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam2.currentFrame = handles.cam2.currentFrame + 1;
handles = updateImage(handles, 2);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in pbCam2Next2.
function pbCam2Next2_Callback(hObject, eventdata, handles)
% hObject    handle to pbCam2Next2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam2.currentFrame = handles.cam2.currentFrame + 20;
handles = updateImage(handles, 2);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in pbCam2Prev.
function pbCam2Prev_Callback(hObject, eventdata, handles)
% hObject    handle to pbCam2Prev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam2.currentFrame = handles.cam2.currentFrame - 1;
handles = updateImage(handles, 2);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in pbCam2Prev2.
function pbCam2Prev2_Callback(hObject, eventdata, handles)
% hObject    handle to pbCam2Prev2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam2.currentFrame = handles.cam2.currentFrame - 20;
handles = updateImage(handles, 2);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in tbCam2Play.
function tbCam2Play_Callback(hObject, eventdata, handles)
% hObject    handle to tbCam2Play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbCam2Play
isPushed = get(hObject, 'Value');
while isPushed
    handles.cam2.currentFrame = handles.cam2.currentFrame + 1;
    handles = updateImage(handles, 2);
    pause(1/11);
    isPushed = get(hObject, 'Value');
end
uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in tbCam2Playback.
function tbCam2Playback_Callback(hObject, eventdata, handles)
% hObject    handle to tbCam2Playback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbCam2Playback

isPushed = get(hObject, 'Value');
while isPushed
    handles.cam2.currentFrame = handles.cam2.currentFrame - 1;
    handles = updateImage(handles, 2);
    pause(1/11);
    isPushed = get(hObject, 'Value');
end
uicontrol(hObject);
guidata(hObject, handles);

%% Data Selection Visualization and Linking Section


% --- Executes when selected cell(s) is changed in uitablePerson1.
function uitablePerson1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitablePerson1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
handles.cam1.currSelection = eventdata.Indices(:,1);
if length(handles.cam1.currSelection) ~= 1
    error('You can only select one line.');
end

handles.cam1.tmpPerson = handles.cam1.Person(handles.cam1.currSelection);
handles.cam1.currentFrame = handles.cam1.tmpPerson.t(1);
handles = updateImage(handles, 1);

% uicontrol(hObject);
guidata(hObject, handles);

% --- Executes when selected cell(s) is changed in uitablePerson2.
function uitablePerson2_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitablePerson2 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
handles.cam2.currSelection = eventdata.Indices(:,1);
if length(handles.cam2.currSelection) ~= 1
    error('You can only select one line.');
end

handles.cam2.tmpPerson = handles.cam2.Person(handles.cam2.currSelection);
handles.cam2.currentFrame = handles.cam2.tmpPerson.t(1);
handles = updateImage(handles, 2);
% uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in pbLink.
function pbLink_Callback(hObject, eventdata, handles)
% hObject    handle to pbLink (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% This functional will be modified later for large scale linking operations
tmpPerson.Id = handles.cam1.tmpPerson.Id(1);
str = ['tmpPerson.cam' handles.cam1.tmpPerson.VideoName ' = handles.cam1.tmpPerson;'];
eval(str);
handles.Person = cat(1, handles.Person, {tmpPerson});
str = ['handles.Person{end}.cam' handles.cam2.tmpPerson.VideoName ' = handles.cam2.tmpPerson;'];
eval(str);

handles = updateComPerson(handles);

uicontrol(hObject);
guidata(hObject, handles);

%% Combine Person Control Functionality
% --- Executes when selected cell(s) is changed in uitableComPerson.
function uitableComPerson_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitableComPerson (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
handles.comPerson.currSelection = eventdata.Indices(:, 1);
if length(handles.comPerson.currSelection) ~= 1
    error('You can only select one line.');
end
if ~isempty(handles.comPerson.currSelection)
    cam1name = handles.PersonInfo{handles.comPerson.currSelection(1), 2};
    cam2name = handles.PersonInfo{handles.comPerson.currSelection(1), 3};
    str = ['handles.cam1.tmpPerson = handles.Person{handles.comPerson.currSelection(1)}.' cam1name ';'];
    eval(str);
    handles.cam1.currentFrame = handles.cam1.tmpPerson.t(1);
    handles = updateImage(handles, 1);

    str = ['handles.cam2.tmpPerson = handles.Person{handles.comPerson.currSelection(1)}.' cam2name ';'];
    eval(str);
    handles.cam2.currentFrame = handles.cam2.tmpPerson.t(1);
    handles = updateImage(handles, 2);
end

% uicontrol(hObject);
guidata(hObject, handles);


% --- Executes on button press in pbComPersonSave.
function pbComPersonSave_Callback(hObject, eventdata, handles)
% hObject    handle to pbComPersonSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = ['Person_' handles.cam1.VideoName '_' handles.cam2.VideoName ' = handles.Person;'];
eval(str);
save(['link_' handles.cam1.VideoName '_' handles.cam2.VideoName '.mat'], ...
    ['Person_' handles.cam1.VideoName '_' handles.cam2.VideoName]);

% --- Executes on button press in pbComPersonLoad.
function pbComPersonLoad_Callback(hObject, eventdata, handles)
% hObject    handle to pbComPersonLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fileName = ['link_' handles.cam1.VideoName '_' handles.cam2.VideoName '.mat;'];
varname = ['Person_' handles.cam1.VideoName '_' handles.cam2.VideoName];
str = ['load ' fileName ';'];
eval(str);
str = ['handles.Person = ' varname ';'];
eval(str);
handles = updateComPerson(handles);

uicontrol(hObject);
guidata(hObject, handles);
% --- Executes on button press in pbComPersonDel.
function pbComPersonDel_Callback(hObject, eventdata, handles)
% hObject    handle to pbComPersonDel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% if length(handles.Person) == 1
%     % If only one occupation, DelKey equals to remove the person
%     handles.Person = [];
%     handles = updateComPerson(handles);
% else
if ~isempty(handles.comPerson.currSelection)
    ind = handles.comPerson.currSelection;
%     if ~isempty(ind)
        leftInd = [1 : ind - 1 ind + 1 : length(handles.Person)];
        handles.Person = handles.Person(leftInd);
        handles = updateComPerson(handles);
end
%     else
%         error('There is no key on current frame.');
%     end
% end

uicontrol(hObject);
guidata(hObject, handles);

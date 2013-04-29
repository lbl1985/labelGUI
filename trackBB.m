function varargout = trackBB(varargin)
% TRACKBB MATLAB code for trackBB.fig
%      TRACKBB, by itself, creates a new TRACKBB or raises the existing
%      singleton*.
%
%      H = TRACKBB returns the handle to a new TRACKBB or the handle to
%      the existing singleton*.
%
%      TRACKBB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRACKBB.M with the given input arguments.
%
%      TRACKBB('Property','Value',...) creates a new TRACKBB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before trackBB_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to trackBB_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help trackBB

% Last Modified by GUIDE v2.5 15-May-2012 22:44:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trackBB_OpeningFcn, ...
                   'gui_OutputFcn',  @trackBB_OutputFcn, ...
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


% --- Executes just before trackBB is made visible.
function trackBB_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to trackBB (see VARARGIN)

handles.Person = [];
handles.tmpPerson = [];
handles.selPerson = [];
% Choose default command line output for trackBB
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes trackBB wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = trackBB_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% Calling Function for updating Image 
function handles = updateImage(handles)

handles.I = read(handles.cam.obj, handles.cam.currentFrame);
imshow(handles.I, 'Parent', handles.axesCam);
set(handles.textVideoInfo, 'String', ['Video: ' handles.cam.VideoName ...
    ' Frame:' num2str(handles.cam.currentFrame)]);
handles = updateAxesCamBB(handles);
set(handles.sliderCam, 'Value', handles.cam.currentFrame);

% if ~isempty(handles.tmpPerson)
%     rectangle('Position', tmpPerson.key(end, :), 'Parent', handles.axesCam);
% end

function handles = updateAxesCamBB(handles)
if ~isempty(handles.tmpPerson)
    % tmpPerson is not empty
    if handles.cam.currentFrame >= handles.tmpPerson.t(1) && handles.cam.currentFrame <= handles.tmpPerson.t(end)
        % current Frame is within the labeling range
        ind = find(handles.tmpPerson.t == handles.cam.currentFrame);
        if ~isempty(ind)
            % currentFrame is when key labeling happening
            rectangle('Position', handles.tmpPerson.key(ind, :), 'EdgeColor', 'r', ...
                'LineWidth', 2, 'Parent', handles.axesCam);
        else
            ind = find(handles.tmpPerson.tAll == handles.cam.currentFrame);
            rectangle('Position', handles.tmpPerson.rectAll(ind, :), 'EdgeColor', 'b', ...
                'LineWidth', 2, 'Parent', handles.axesCam); %#ok<FNDSB>
        end
    end
end

function handles = updateRegion(handles)
if ~isempty(handles.tmpPerson)
    handles = updateData(handles);
    tmpUpdateRegionId = handles.updateRegionId;
    imshow(handles.tmpPerson.region{tmpUpdateRegionId}, 'Parent', handles.axesRegion);
    set(handles.textRegionInfo, 'String', ['Person: ' num2str(handles.tmpPerson.Id(tmpUpdateRegionId)) ...
        'Time: ' num2str(handles.tmpPerson.t(tmpUpdateRegionId))]);
    set(handles.uitableRegion, 'Data', handles.tmpPerson.data);
else
    imshow([], 'Parent', handles.axesRegion);
    set(handles.textRegionInfo, 'String', '');
    set(handles.uitableRegion, 'Data', []);
end

function handles = updateData(handles)
handles.tmpPerson.data = [handles.tmpPerson.Id handles.tmpPerson.t ...
    handles.tmpPerson.key];

function handles = updateTmpPersonOrder(handles, order)
handles.tmpPerson.Id = handles.tmpPerson.Id(order);
handles.tmpPerson.t = handles.tmpPerson.t(order);
handles.tmpPerson.key = handles.tmpPerson.key(order, :);
handles.tmpPerson.region = handles.tmpPerson.region(order);

[handles.tmpPerson.rectAll handles.tmpPerson.tAll] = interRect(handles.tmpPerson.key, ...
    handles.tmpPerson.t);
rect = handles.tmpPerson.rectAll;
handles.tmpPerson.cenAll = [rect(:, 1) + rect(:, 3) / 2 rect(:, 2) + rect(:, 4)/2];

function handles = updateTrack(handles)


function handles = updatePerson(handles)
nPerson = length(handles.Person);
handles.PersonInfo = cell(nPerson, 4);
for i = 1 : nPerson
    handles.PersonInfo{i, 1} = handles.Person(i).Id(1);
    handles.PersonInfo{i, 2} = handles.Person(i).t(1);
    handles.PersonInfo{i, 3} = handles.Person(i).t(end);
    handles.PersonInfo{i, 4} = handles.Person(i).VideoName;
end
set(handles.uitablePerson, 'Data', handles.PersonInfo);

function handles = showTmpPerson(handles)

if ~isempty(handles.selPerson)
    handles.tP = handles.selPerson;

    nT = length(handles.tP.tAll);
    for i = 1 : nT
        imshow(read(handles.cam.obj, handles.tP.tAll(i)), 'Parent', handles.axesTrack);
        hold on
        rectangle('Position', handles.tP.rectAll(i, :), 'EdgeColor', 'r',  ...
            'LineWidth', 2, 'Parent', handles.axesTrack);
        
        line(handles.tP.cenAll(1:i, 1), handles.tP.cenAll(1:i, 2), 'Color', 'r',  ...
            'Parent', handles.axesTrack);
        hold off
        pause(1/11);
    end
end




% --- Executes during object creation, after setting all properties.
function editCam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editCam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function sliderCam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderCam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in pbNext.
function pbNext_Callback(hObject, eventdata, handles)
% hObject    handle to pbNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam.currentFrame = handles.cam.currentFrame + 1;
handles = updateImage(handles);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in pbNext2.
function pbNext2_Callback(hObject, eventdata, handles)
% hObject    handle to pbNext2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam.currentFrame = handles.cam.currentFrame + 20;
handles = updateImage(handles);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in pbPrev.
function pbPrev_Callback(hObject, eventdata, handles)
% hObject    handle to pbPrev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam.currentFrame = handles.cam.currentFrame - 1;
handles = updateImage(handles);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in pbPrev2.
function pbPrev2_Callback(hObject, eventdata, handles)
% hObject    handle to pbPrev2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam.currentFrame = handles.cam.currentFrame - 20;
handles = updateImage(handles);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in tbPlay.
function tbPlay_Callback(hObject, eventdata, handles)
% hObject    handle to tbPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbPlay
isPushed = get(hObject, 'Value');
while isPushed
    handles.cam.currentFrame = handles.cam.currentFrame + 1;
    handles = updateImage(handles);
    pause(1/11);
    isPushed = get(hObject, 'Value');
end
uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in tbPlayback.
function tbPlayback_Callback(hObject, eventdata, handles)
% hObject    handle to tbPlayback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbPlayback
isPushed = get(hObject, 'Value');
while isPushed
    handles.cam.currentFrame = handles.cam.currentFrame - 1;
    handles = updateImage(handles);
    pause(1/11);
    isPushed = get(hObject, 'Value');
end
uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on slider movement.
function sliderCam_Callback(hObject, eventdata, handles)
% hObject    handle to sliderCam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.cam.currentFrame = round(get(hObject, 'Value'));
handles = updateImage(handles);


uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in pbLoad.
function pbLoad_Callback(hObject, eventdata, handles)
% hObject    handle to pbLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc; 
handles.Person = [];
handles.tmpPerson = [];
handles.selPerson = [];

handles.cam.VideoFile = get(handles.editCam, 'String');
ind = strfind(handles.cam.VideoFile, '/');
handles.cam.VideoName = handles.cam.VideoFile(ind(end) + 1 : end - 4);
handles.cam.obj = VideoReader(handles.cam.VideoFile);
handles.cam.NumberOfFrames = handles.cam.obj.NumberOfFrames;
handles.cam.currentFrame = 1;
set(handles.sliderCam, 'Max', handles.cam.NumberOfFrames);
set(handles.sliderCam, 'SliderStep', [1/(handles.cam.NumberOfFrames -1) 0.1]);
set(handles.sliderCam, 'Value', 1);

handles = updateImage(handles);

uicontrol(hObject);
guidata(hObject, handles);


% --- Executes on button press in pbAddPerson.
function pbAddPerson_Callback(hObject, eventdata, handles)
% hObject    handle to pbAddPerson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(handles.tmpPerson)
    error('Finish last person first to begin a new one.');
end
handles.tmpPerson.VideoName = handles.cam.VideoName;
handles.tmpPerson.VideoFile = handles.cam.VideoFile;

% if isempty(handles.tmpPerson)
h1 = imrect(handles.axesCam, [10 10 100 100]);
% else
%     h1 = imrect(handles.axesCam, handles.tmpPerson.key(end, :));
% end
handles.tmpPerson.Id = length(handles.Person) + 1;
handles.tmpPerson.t = handles.cam.currentFrame;
tmpKey = wait(h1);
handles.tmpPerson.key = round(tmpKey);
handles.tmpPerson.region = {rectroi(handles.I, handles.tmpPerson.key([2 1 4 3]))};

% Update the rectAll and tAll according to key and t info
[handles.tmpPerson.rectAll handles.tmpPerson.tAll] = interRect(handles.tmpPerson.key, ...
    handles.tmpPerson.t);

setColor(h1, 'g');

handles.updateRegionId = length(handles.tmpPerson.t);
% handles = updateData(handles);

handles = updateRegion(handles);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in pbKeyPoint.
function pbKeyPoint_Callback(hObject, eventdata, handles)
% hObject    handle to pbKeyPoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.cam.currentFrame < handles.tmpPerson.t(end)
    % Which means we should have predicted data 
    ind = find(handles.tmpPerson.tAll == handles.cam.currentFrame);
    tmpRect = handles.tmpPerson.rectAll(ind, :);    
else
    tmpRect = handles.tmpPerson.key(end, :);        
end
h1 = imrect(handles.axesCam, tmpRect);
tmpKey = wait(h1);

tmpKey = round(tmpKey);
tmpRegion = {rectroi(handles.I, tmpKey([2 1 4 3]))};

handles.tmpPerson.Id = cat(1, handles.tmpPerson.Id, handles.tmpPerson.Id);
handles.tmpPerson.t = cat(1, handles.tmpPerson.t, handles.cam.currentFrame);
handles.tmpPerson.key = cat(1, handles.tmpPerson.key, tmpKey);
handles.tmpPerson.region = cat(1, handles.tmpPerson.region, tmpRegion);

[~, order] = sort(handles.tmpPerson.t);
handles = updateTmpPersonOrder(handles, order);
% handles.tmpPerson.Id = handles.tmpPerson.Id(order);
% handles.tmpPerson.t = handles.tmpPerson.t(order);
% handles.tmpPerson.key = handles.tmpPerson.key(order, :);
% handles.tmpPerson.region = handles.tmpPerson.region(:, :, :, order);
setColor(h1, 'g');

% handles = updateData(handles);

handles.updateRegionId = order(end);
handles = updateRegion(handles);

uicontrol(hObject);
guidata(hObject, handles);



% --- Executes on button press in pbDelkey.
function pbDelkey_Callback(hObject, eventdata, handles)
% hObject    handle to pbDelkey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if length(handles.tmpPerson.t) == 1
    % If only one occupation, DelKey equals to remove the person
    handles.tmpPerson = [];
    handles = updateRegion(handles);
else
    ind = find(handles.tmpPerson.t == handles.cam.currentFrame);
    if ~isempty(ind)
        leftInd = [1 : ind - 1 ind + 1 : length(handles.tmpPerson.t)];
        handles = updateTmpPersonOrder(handles, leftInd);
        handles.updateRegionId = length(handles.tmpPerson.t);
        handles = updateRegion(handles);
        handles = updateImage(handles);
    else
        error('There is no key on current frame.');
    end
end

uicontrol(hObject);
guidata(hObject, handles);
    

% --- Executes on button press in pbEndPerson.
function pbEndPerson_Callback(hObject, eventdata, handles)
% hObject    handle to pbEndPerson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Person = cat(1, handles.Person, handles.tmpPerson);
handles = updatePerson(handles);



handles.selPerson = handles.tmpPerson;
handles = showTmpPerson(handles);

handles.tmpPerson = [];
handles.selPerson = [];

handles = updateRegion(handles);

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes when selected cell(s) is changed in uitablePerson.
function uitablePerson_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitablePerson (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
handles.currSelection = eventdata.Indices(:,1);
if length(handles.currSelection) ~= 1
    error('You can only select one line.');
end

handles.selPerson = handles.Person(handles.currSelection);

% uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in tbShow.
function tbShow_Callback(hObject, eventdata, handles)
% hObject    handle to tbShow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbShow
isPushed = get(hObject, 'Value');
if ~isempty(handles.selPerson)
    while isPushed
        handles = showTmpPerson(handles);
        isPushed = get(hObject, 'Value');
    end    
end
handles.selPerson = [];

uicontrol(hObject);
guidata(hObject, handles);

% --- Executes on button press in pbSave.
function pbSave_Callback(hObject, eventdata, handles)
% hObject    handle to pbSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

str = ['Person_' handles.cam.VideoName ' = handles.Person;'];
eval(str);
save(['manLabel_' handles.cam.VideoName], ['Person_' handles.cam.VideoName]);


% --- Executes on button press in pbLoadData.
function pbLoadData_Callback(hObject, eventdata, handles)
% hObject    handle to pbLoadData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load(['manLabel_' handles.cam.VideoName]);
str = ['handles.Person = Person_' handles.camVideoName ';'];
eval(str);
handles = updatePerson(handles);

uicontrol(hObject);
guidata(hObject, handles);

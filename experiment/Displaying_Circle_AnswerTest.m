clear all;
close all;
%% Load Screen
Screen('Preference', 'SkipSyncTests', 1);
rng('Shuffle'); 
[window, rect] = Screen('OpenWindow', 0, [], []); % opening the screen
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); % allowing transparency in the photos 

HideCursor();
window_w = rect(3); % defining size of screen
window_h = rect(4);
 
x_center = window_w/2;
y_center = window_h/2;

cd('Face_Stimuli')

%% reading the transparency mask 

Mask_Plain = imread('mask.png'); %Load black circle on white background.  

Mask_Plain = 255-Mask_Plain(:,:,1); %use first layer 

%% loading the face stimuli 


for f = 1:147
    tmp_bmp = imread([num2str(f) '.PNG']); 
    tmp_bmp(:,:,4) = Mask_Plain;% 
    tid(f) = Screen('MakeTexture', window, uint8(tmp_bmp));
    Screen('DrawText', window, 'Loading...', x_center, y_center-25); % Write text to confirm loading of images
    Screen('DrawText', window, sprintf('%d%%',round(f*(100/147))), x_center, y_center+25); % Write text to confirm percentage complete
    Screen('Flip', window); % Display text
end

w_img = size(tmp_bmp, 2) * 0.5; % width of pictures
h_img = size(tmp_bmp, 1) * 0.5 ; % height of pictures

face_number  = 1:147; 
%% choosing the faces to show

faces = randsample(face_number, 6); % choosing 6 faces randomly from the loaded faces 

%% Calculating the Circle Locations

num_pts = 8; % number of elements
radius = 300; %distance from center
theta = linspace(360/num_pts, 360, num_pts); %angles equally spaced (returns equally spaced number of points along circle)

%Adjusted so that four locations (the corners) are given for each point
%along the circle
x_circle = window_w/2 + (cosd(theta) * radius);
y_circle = window_h/2 + (sind(theta) * radius);

%Adjusted so that the stimuli is centered 
xy_circle = [x_circle-w_img/2; y_circle-h_img/2; 
            x_circle+w_img/2; y_circle+h_img/2];

%% Displaying the chosen faces in a circle 

Screen('DrawTextures', window, tid(faces), [], xy_circle); % display the faces
Screen('Flip', window);

WaitSecs(1) 

Screen('CloseAll');
cd('../'); %Go back to original directory. 

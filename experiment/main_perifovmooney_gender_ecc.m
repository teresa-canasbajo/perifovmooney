function main_perifovmooney_gender_ecc

Screen('Preference', 'SkipSyncTests', 1);
commandwindow;
%% init

KbName('UnifyKeyNames')
RestrictKeysForKbCheck([]);
%% paths
mainpath = pwd;
designpath = [mainpath '/design'];
resultspath = [mainpath '/results'];
stimpath = [mainpath '/stim'];
practicestimpath = [mainpath '/practice'];


% get subject info
subidINIT = input('Subject Initials?:\n'); % in doubles, so need to add '' for initials.
subid = input('Subject Number?:\n');
who = input('Teresa (1) or Exp Room (3)\n');
% sizeImage = input('What image size?\n');
% subidINIT = 'TCB'; % in doubles, so need to add '' for initials.
% subid = 1;
% who = 3;
sizeImage = 6;
%% EXP params
[exp_params, column_coding, display] = expParams(who, sizeImage);

%% set up design
% load design mat
designtable = readtable('designtable.xlsx');


% generate subject design
subdesign = subjectdesign(subidINIT, subid, designtable, designpath, exp_params, column_coding);

% assign it to the results matrix:
results = {};

%% Set up PTB-3

%Choose a screen
AssertOpenGL;
screens = Screen('Screens');
screenNumber = max(screens);
Screen('Preference', 'SuppressAllWarnings', 1);
Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference','VisualDebuglevel', 0); % removes screen for donations
HideCursor();

%Get colors this just gets the numbers that represent black and white
%for this monitor
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grayCol = round((white+black)/2);


%Open a window and paint the background gray, [w1 h1 w2 h2]
[window, screenRect]=Screen('OpenWindow',screenNumber, grayCol); % [0 0 300 200]

HideCursor();
window_w = screenRect(3); % defining size of screen
window_h = screenRect(4);
x_center = window_w/2;
y_center = window_h/2;

third_scrn_horiz = floor(screenRect(3)/3);
half_scrn_horiz = floor(screenRect(3)/2);
half_scrn_vert = floor(screenRect(4)/2);

%% load and make textures
[UhighTexture, UlowTexture, IhighTexture, IlowTexture, Uhighallnames, Ulowallnames, Ihighallnames, Ilowallnames, w_img, h_img] = makeTextures(stimpath, window, mainpath, exp_params);
[UhighTexturePract, UlowTexturePract, IhighTexturePract, IlowTexturePract, UhighallnamesPract, UlowallnamesPract, IhighallnamesPract, IlowallnamesPract, w_img, h_img] = makeTextures(stimpath, window, mainpath, exp_params);
[Mask_Mem_Tex] = makeMaskTexture(window, x_center, y_center, w_img, h_img);

[num, txt, high_holistic_correct] = xlsread('high_holistic_correct.xlsx');
[num, txt, low_holistic_correct] = xlsread('low_holistic_correct.xlsx');
%% experiment parameters

% key mapping
spacebar = KbName('space');
femalekey = KbName('d');
malekey = KbName('l');

esckey = KbName('ESCAPE');


%% fixation point
fixation_dot = 0.2; % fixation dot diameter - 0.2 degrees
fixation_dot = exp_params.pixPerDeg * fixation_dot; % fixation dot diameter - 0.2 degrees
fix_rect = [third_scrn_horiz-(fixation_dot/2) half_scrn_vert-(fixation_dot/2) third_scrn_horiz+(fixation_dot/2) half_scrn_vert+(fixation_dot/2)] + [half_scrn_horiz-third_scrn_horiz 0 half_scrn_horiz-third_scrn_horiz 0];

% fix_rect = CenterRect([x_center y_center w_img h_img], screenRect);

%% practice loop
instructions = 1;
numpracticeTrials = 10;
if instructions
    load('practicedesign.mat')
    xy_circle = makecircle(0,window_w, window_h,'fovea', exp_params, display, x_center, y_center);
    display_instructions(spacebar, window, UhighTexturePract, IlowTexturePract, xy_circle, fix_rect, exp_params.pixPerDeg, black)

    for practicetrial = 1:numpracticeTrials
    %     xy_circle = makecircle(ecc,window_w, window_h, ', h_img_resized);

        % Displaying the chosen faces in a circle
        facetodisplayPRACT = practicedesign(practicetrial, 2); % get mooney number
        loctodisplayPRACT = practicedesign(practicetrial, 3);% get where to display
        uporinPRACT = practicedesign(practicetrial, 4); % is upright or inverted condition?
        disp(loctodisplayPRACT)


        if uporinPRACT == 1 % upright
            Screen('DrawTextures', window, UhighTexturePract{facetodisplayPRACT}, [], xy_circle(:,1)); % display the faces
        elseif uporinPRACT == 2 % inverted
            Screen('DrawTextures', window, IhighTexturePract{facetodisplayPRACT}, [], xy_circle(:,1)); % display the faces
        end

    % 
    %     % add fixation
    %     if ~strcmp(loctodisplayPRACT, 'fovea') % dont display fixation point if image in center
    %         Screen('FillOval', window, black, fix_rect);
    %     end

        Screen('Flip', window);
        WaitSecs(exp_params.imageTime )

        % mask + fixation
        Screen('DrawTexture', window, Mask_Mem_Tex, [], xy_circle(:,1))
    %     if ~strcmp(loctodisplayPRACT, 'fovea')  % dont display fixation point if image in center
    %     Screen('FillOval', window, black, fix_rect);
    %     end
        Screen('Flip', window);
        WaitSecs(exp_params.maskTime)



        % get subject response
        % remove images from screen
        Screen('FillOval', window, black, fix_rect);
        Screen('Flip', window);


        keyIsDown = 0;
        activeKeys = [femalekey malekey esckey spacebar];
        RestrictKeysForKbCheck(activeKeys);

        % record time of start
        tStart = GetSecs;
        %     rt = []; % create rt variable

        while ~keyIsDown % wait until subjects answers
            [keyIsDown,keyTime,keyCode] = KbCheck(-1);
            if keyIsDown
                if keyCode(femalekey)
                    response = 'female'; % leftl
                    rt = keyTime - tStart;

                    %fixation dot
                    Screen('FillOval', window, black, fix_rect); %fixation dot
                    Screen('Flip', window);
                    WaitSecs(0.250) % wait one second and then break
                    break
                end
                if keyCode(malekey)
                    response = 'male' ; % right
                    rt = keyTime - tStart;

                    %fixation dot
                    Screen('FillOval', window, black, fix_rect); %fixation dot
                    Screen('Flip', window); %it draws the rotating bar
                    WaitSecs(0.250) % wait one second and then break
                    break
                end


                %Abort if escape is pressed
                [keyIsDown,seconds,keyCode] = KbCheck(-1);
                if keyCode(esckey)
                    Screen('CloseAll');
                    break;
                end

            end
        end

        % between trials interval
        Screen('FillOval', window, black, fix_rect);
        Screen('Flip', window);
        WaitSecs(exp_params.btwTrialsT)

    end

    display_end_instructions(spacebar, window, exp_params.pixPerDeg, black, fix_rect)
end
%% trial loop

block = 0; % start block variable
for trial = 1:exp_params.NumTrials
    % Displaying the chosen faces in a circle
    
    facetodisplay = cell2mat(subdesign(trial, column_coding.MOONEYID)); % get mooney number
    loctodisplay = subdesign(trial, column_coding.LOC);% get where to display
    ecctodisplay = cell2mat(subdesign(trial, column_coding.ECCENTRICITY));
    uporin = subdesign(trial, column_coding.COND); % is upright or inverted codition?
    mooneycategory = subdesign(trial, column_coding.MOONEYCATEGORY);
    
    xy_circle = makecircle(ecctodisplay, window_w, window_h, loctodisplay, exp_params, display, x_center, y_center);
    
    if strcmp(mooneycategory, 'high holistic') && strcmp(uporin, 'upright')
        texture = UhighTexture;
        correct = high_holistic_correct(:, 3);
        
    elseif strcmp(mooneycategory, 'high holistic') && strcmp(uporin, 'inverted')
        texture = IhighTexture;
        correct = high_holistic_correct(:, 3);
        
    elseif strcmp(mooneycategory, 'low holistic') && strcmp(uporin, 'upright')
        texture = UlowTexture;
        correct = low_holistic_correct(:, 3);
        
    elseif strcmp(mooneycategory, 'low holistic') && strcmp(uporin, 'inverted')
        texture = IlowTexture;
        correct = low_holistic_correct(:, 3);
        
    end
    
    Screen('DrawTextures', window, texture{facetodisplay}, [], xy_circle(:,1)); % display the faces
    
    
    
    % add fixation
    if ~strcmp(loctodisplay, 'fovea')% dont display fixation point if image in center
        Screen('FillOval', window, black, fix_rect);
    end
    
    Screen('Flip', window);
    WaitSecs(exp_params.imageTime)
    
    % mask + fixation
    Screen('DrawTexture', window, Mask_Mem_Tex, [], xy_circle(:,1))
    % add fixation
    if ~strcmp(loctodisplay, 'fovea')% dont display fixation point if image in center
        Screen('FillOval', window, black, fix_rect);
    end
    Screen('Flip', window);
    WaitSecs(exp_params.maskTime)
    
    
    
    % get subject response
    % remove images from screen
    Screen('FillOval', window, black, fix_rect);
    Screen('Flip', window);
    
    
    keyIsDown = 0;
    activeKeys = [femalekey malekey esckey];
    RestrictKeysForKbCheck(activeKeys);
    
    % record time of start
    tStart = GetSecs;
    %     rt = []; % create rt variable
    
    while ~keyIsDown % wait until subjects answers
        [keyIsDown,keyTime,keyCode] = KbCheck(-1);
        if keyIsDown
            if keyCode(femalekey)
                response = 'female'; % leftl
                rt = keyTime - tStart;
                
                %fixation dot
                Screen('FillOval', window, black, fix_rect); %fixation dot
                Screen('Flip', window);
                WaitSecs(0.100) % wait one second and then break
                break
            end
            if keyCode(malekey)
                response = 'male'; % right
                rt = keyTime - tStart;
                
                %fixation dot
                Screen('FillOval', window, black, fix_rect); %fixation dot
                Screen('Flip', window); %it draws the rotating bar
                WaitSecs(0.100) % wait one second and then break
                break
            end
            
            
            %Abort if escape is pressed
            [keyIsDown,seconds,keyCode] = KbCheck(-1);
            if keyCode(esckey)
                Screen('CloseAll');
                break;
            end
            
        end
    end
    
    %% record accuracy
    
    % accuracy
    if strcmp(correct(facetodisplay),response)
        accuracy = 1;
    else
        accuracy = 0;
    end
    %
    % between trials interval
    Screen('FillOval', window, black, fix_rect);
    Screen('Flip', window);
    WaitSecs(exp_params.btwTrialsT)
    % save subject response
    
    
    % output data
    results(trial, column_coding.SUBID) = num2cell(subid);
    results(trial, column_coding.TRIAL) = num2cell(trial);
    results(trial, column_coding.MOONEYID) = num2cell(facetodisplay);
    results(trial, column_coding.MOONEYCATEGORY) = mooneycategory;
    results(trial, column_coding.LOC) = loctodisplay;
    results(trial, column_coding.COND) = uporin;
    results(trial, column_coding.MOONEY_NAME) = Uhighallnames(facetodisplay);
    results(trial, column_coding.MOONEY_GENDER) = correct(facetodisplay);
    results(trial, column_coding.RESPONSE) = {response};
    results(trial, column_coding.ECCENTRICITY) = num2cell(ecctodisplay);
    results(trial, column_coding.ACCURACY) = num2cell(accuracy);
    results(trial, column_coding.RT) = num2cell(rt);
    
    
    % save data
    save([resultspath '/' subidINIT '_perifovmooney_ecc.mat'], 'results');
    
    % check if it's time for a break!
    block = checkbreak(trial, spacebar, window, exp_params.pixPerDeg, block);
    
end % end of trial

%% end of experiment screen

instruct='You are all done! Thank you for participating.\n Please press any button to finish.';
%[nx, ny, bbox] = DrawFormattedText(w, instruct,'center', 'center', 0);
DrawFormattedText(window, instruct, 'center', 384-exp_params.pixPerDeg*7, 0);
Screen(window, 'TextSize',25);
Screen('FillOval', window, black, fix_rect); %fixation dot
%
% load('Calibration.mat') %loads file with photometer
% Screen('LoadNormalizedGammaTable', w, clut);

Screen('Flip',window);
RestrictKeysForKbCheck([]);
[keyIsDown,seconds,keyCode] = KbCheck(-1);
while ~keyCode(spacebar)
    [keyIsDown,seconds,keyCode] = KbCheck(-1);
end

FlushEvents;
ShowCursor();

Priority(0);
Screen('CloseAll');
end


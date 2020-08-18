function display_instructions(spacebar, w, UtargetPracticeTexture, ItargetPracticeTexture, xy_circle, fix_rect, pixPerDeg, black)
%DISPLAY_INSTRUCTIONS Displays instructions for perifovmooney experiment


instruct1 ='You are going to be presented with one face \n either upright or inverted.\n Press space to see an example.\n';
% [nx, ny, bbox] = DrawFormattedText(w, instruct,'center', 'center', 0);
DrawFormattedText(w, instruct1, 'center', 384-pixPerDeg*7, 0);
Screen(w, 'TextSize',25);
Screen('FillOval', w, black, fix_rect); %fixation dot

Screen('Flip',w);

[keyIsDown,seconds,keyCode] = KbCheck(-1);
while ~keyCode(spacebar)
    [keyIsDown,seconds,keyCode] = KbCheck(-1);
end


%% display the images
% face
Screen('DrawTextures', w, UtargetPracticeTexture{2}, [], xy_circle(:,1)); % display the faces
Screen('Flip',w);

WaitSecs(0.5)
% disappear
Screen('Flip',w);
WaitSecs(0.01)

%%
instruct1 ='The face could appear upside-down\n Press space to see an example.\n';
% [nx, ny, bbox] = DrawFormattedText(w, instruct,'center', 'center', 0);
DrawFormattedText(w, instruct1, 'center', 384-pixPerDeg*7, 0);
Screen(w, 'TextSize',25);
Screen('FillOval', w, black, fix_rect); %fixation dot

Screen('Flip',w);

[keyIsDown,seconds,keyCode] = KbCheck(-1);
while ~keyCode(spacebar)
    [keyIsDown,seconds,keyCode] = KbCheck(-1);
end
%% display the images
% face
Screen('DrawTextures', w, ItargetPracticeTexture{2}, [], xy_circle(:,1)); % display the faces
Screen('Flip',w);

WaitSecs(0.5)
% disappear
Screen('Flip',w);
WaitSecs(0.01)


%%
instruct2 = 'Regardless of the face orientation\n Your task is to report the gender of the face,\n female or male.\n If it is female, press D on the keyboard\n If it is male, press the L on the keyboard.\n During this task, please keep your eyes centered at the dot in the middle of the screen\n Press space bar to do 10 practice trials.';
DrawFormattedText(w, instruct2, 'center', 384-pixPerDeg*7, 0);
Screen(w, 'TextSize',25);
Screen('FillOval', w, black, fix_rect); %fixation dot

Screen('Flip',w);
[keyIsDown,seconds,keyCode] = KbCheck(-1);
while ~keyCode(spacebar)
    [keyIsDown,seconds,keyCode] = KbCheck(-1);
end

end


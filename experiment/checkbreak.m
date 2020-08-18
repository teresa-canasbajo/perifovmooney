function block = checkbreak(trial, spacebar, w, pixPerDeg, block)
%CHECKBREAK Checks if it's time for a break in the perifovmooney experiment
    trialbreaks = [130*1, 130*2, 130*3, 130*4, 130*5, 130*6, 130*7, 130*8, 130*9];
    if ismember(trial, trialbreaks)
        block = block + 1;
        total_block = 10;
        text_block= ['You have done ' num2str(block) ' blocks out of ' num2str(total_block) '\n.Please feel free to take a break.\n Press the Space bar when you want to start the new block.\n Remember to press D if face is female\n Press L if face is male\n'];
        DrawFormattedText(w, text_block, 'center', 384-pixPerDeg*7, 0);
        Screen(w, 'TextSize',25);
        Screen('Flip',w);
        
        activeKeys = spacebar;
        RestrictKeysForKbCheck(activeKeys);
        
        [keyIsDown,seconds,keyCode] = KbCheck(-1);
        while ~keyCode(spacebar)
            [keyIsDown,seconds,keyCode] = KbCheck(-1);
        end
    end
end



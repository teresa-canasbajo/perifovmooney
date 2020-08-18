function display_end_instructions(spacebar, w, pixPerDeg, black, fix_rect)

instruct1 ='Great job!\n Let the experimenter know if you have any questions.\n Otherwise, press space to start the actual experiment.\n Remember to press D if face is female\n Press L if face is male\n';
DrawFormattedText(w, instruct1, 'center', 384-pixPerDeg*7, 0);
Screen(w, 'TextSize',25);
Screen('Flip',w);

[keyIsDown,seconds,keyCode] = KbCheck(-1);
while ~keyCode(spacebar)
    [keyIsDown,seconds,keyCode] = KbCheck(-1);
end

function [exp_params, column_coding, display] = expParams(who, sizeImage)

%% set pixels per degree

display.dist = 40; % subject distance in cm
display.width = 40; %cm
if who == 1 
    display.resolution = 1920; % resolution X
elseif who == 3
    display.resolution = 1024;
end

%% EXP params
exp_params.pixPerDeg = angle2pix(display,1);
exp_params.numRepConds = 25;
exp_params.NumConds = 52;
exp_params.NumTrials = exp_params.numRepConds * exp_params.NumConds;
exp_params.sizeTarget = sizeImage;
exp_params.EccSizeRatio = 1.45;
exp_params.EccSizeRation_vert = 3.2;
exp_params.sizeTargetPix = exp_params.sizeTarget * exp_params.pixPerDeg;
% original_size = [160 230]; we need to maintain this relationship
exp_params.w_img_resized = exp_params.sizeTargetPix *0.697;
exp_params.h_img_resized = exp_params.sizeTargetPix;
exp_params.numImPerCond = 20;
exp_params.imageTime = 0.5;
exp_params.maskTime = 0.050; 
exp_params.btwTrialsT = 0.5;

%% column_coding
column_coding.SUBID = 1;
column_coding.TRIAL = 2;
column_coding.MOONEYID = 3;
column_coding.MOONEYCATEGORY = 4;
column_coding.LOC = 5;
column_coding.COND = 6;
column_coding.MOONEY_NAME = 7;
column_coding.MOONEY_GENDER = 8;
column_coding.ECCENTRICITY = 9;
column_coding.RESPONSE = 10;
column_coding.ACCURACY = 11;
column_coding.RT = 12;



%% display sizes:

end


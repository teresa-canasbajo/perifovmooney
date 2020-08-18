function subdesign = subjectdesign(subidINIT, subid, designtable, designpath, exp_params, column_coding)

% generate
% repeat the table a number of times, per how many repetitions for
% conditions
repeated_design = repelem(designtable,exp_params.numRepConds,1);
% subdesign = cell();
    
% subdesign = table();
subdesign(1:exp_params.NumTrials, column_coding.SUBID) = num2cell(repmat(subid, exp_params.NumTrials, 1), exp_params.NumTrials);
subdesign(1:exp_params.NumTrials, column_coding.TRIAL) = num2cell([1:exp_params.NumTrials]', exp_params.NumTrials);

% randomize design mat:
randdesign = repeated_design(randperm(size(repeated_design, 1)), :);

% add to main mat:
subdesign(1:exp_params.NumTrials, column_coding.MOONEYCATEGORY) = randdesign.MOONEYCATEGORY;
subdesign(1:exp_params.NumTrials, column_coding.LOC) = randdesign.ANGLE;
subdesign(1:exp_params.NumTrials, column_coding.ECCENTRICITY) = num2cell(randdesign.ECCENTRICITY);
subdesign(1:exp_params.NumTrials, column_coding.COND) = randdesign.CONDITION;
subdesign(1:exp_params.NumTrials, column_coding.MOONEYID) = num2cell(randi(exp_params.numImPerCond,[1, exp_params.NumTrials]));



% save design mat in design folder
cd(designpath)
save([subidINIT '_' num2str(subid) '_designmat.mat'], 'subdesign');
cd ..

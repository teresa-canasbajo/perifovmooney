function createdesignmat

% 9 locations, 8 peripheral + 1 foveal.

% 40 images --> most ambiguous?
% 6 repetitions each location
% 6 repetitions each condition, UPRIGHT and INVERTED

% total of 1440 trials


repsLoc = 4;
numLoc = 7;
repsCond = 2;
numCond = 2;

numIm=40;
trialsPerMooney = numLoc*(repsCond*numCond); % 28

% column coding:
MOONEYID = 1;
LOC = 2;

CONDITION = 3;


% create repetitions vector
a = repmat(1:numLoc, [repsLoc, 1]);
a = a(1:end)';

b = repmat(1:numCond, [1 trialsPerMooney/2]);
b = b(1:end)';

c = 0;
designmat = [];
for mooney = 1:numIm
    startrow = (trialsPerMooney*c) + 1;
    endrow = trialsPerMooney * (c+1);
    designmat(startrow:endrow, MOONEYID) = mooney; % add mooney number
    
    designmat(startrow:endrow, CONDITION) = b;
    
    designmat(startrow:endrow, LOC) = a;
    
    
    c = c + 1;
    
    
end

save('designmat.mat', 'designmat')
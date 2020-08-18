function [UtargetPracticeTexture, ItargetPracticeTexture, StargetPracticeTexture] = makePracticeTextures(practicepath, w)


%% load images and make textures

% three sets of images:
% upright
% upside down
% scrambled

cd(practicepath)
% upside targets

Utargetimagefiles = dir('U*.bmp');
nfiles = length(Utargetimagefiles);  % number of files found


% load and make textures of all of them

for ii = 1:nfiles
    Utargetcurrentfilename = Utargetimagefiles(ii).name;
    Utargetcurrentimage = imread(Utargetcurrentfilename);
    Utargetimages{ii} = Utargetcurrentimage;
    UtargetPracticeTexture{ii} = Screen('MakeTexture', w, Utargetimages{ii});
end

% inverted targets

Itargetimagefiles = dir('I*.bmp');
nfiles = length(Itargetimagefiles);  % number of files found


% load and make textures of all of them

for kk = 1:nfiles
    Itargetcurrentfilename = Itargetimagefiles(kk).name;
    Itargetcurrentimage = imread(Itargetcurrentfilename);
    Itargetimages{kk} = Itargetcurrentimage;
    ItargetPracticeTexture{kk} = Screen('MakeTexture', w, Itargetimages{kk});
end

% scrambled targets
Stargetimagefiles = dir('S*.bmp');
nfiles = length(Stargetimagefiles);  % number of files found


% load and make textures of all of them

for jj = 1:nfiles
    Stargetcurrentfilename = Stargetimagefiles(jj).name;
    Stargetcurrentimage = imread(Stargetcurrentfilename);
    Stargetimages{jj} = Stargetcurrentimage;
    StargetPracticeTexture{jj} = Screen('MakeTexture', w, Stargetimages{jj});
end


cd ..



end


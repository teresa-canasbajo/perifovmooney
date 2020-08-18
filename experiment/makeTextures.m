function [UhighTexture, UlowTexture, IhighTexture, IlowTexture, Uhighallnames, Ulowallnames, Ihighallnames, Ilowallnames, w_img, h_img] = makeTextures(stimpath, window, mainpath, exp_params)
%MAKETEXTURES makes textures for upright, inverted and scrambled mooneys

%% load images and make textures

% three sets of images:
% high holistc
% low holistic

highholisticppath = [stimpath '/high_holistic'];
lowholisticppath = [stimpath '/low_holistic'];


cd(highholisticppath)
% upside targets

Uhighimagefiles = dir('U*.bmp');
nfiles = length(Uhighimagefiles);  % number of files found

% create variable with mooney numbers and their matching file
mooney_matching = {};

% load and make textures of all of them
exp_params.mooneysPerCat = nfiles; 

for ii = 1:nfiles
    Uhighcurrentfilename = Uhighimagefiles(ii).name;
    Uhighcurrentimage = imread(Uhighcurrentfilename);
    Uhighimages{ii} = Uhighcurrentimage;
    UhighTexture{ii} = Screen('MakeTexture', window, Uhighimages{ii});
    Uhighallnames{ii} = Uhighcurrentfilename;
    
    
    mooney_matching{ii, 1} = ii;
    mooney_matching{ii, 2} = Uhighcurrentfilename;
    
end

w_img = size(Uhighcurrentimage, 2) * 0.5;
h_img = size(Uhighcurrentimage, 1) * 0.5;

Ihighimagefiles = dir('I*.bmp');
nfiles = length(Ihighimagefiles);  % number of files found

% create variable with mooney numbers and their matching file
mooney_matching = {};

% load and make textures of all of them
exp_params.mooneysPerCat = nfiles; 

for ii = 1:nfiles
    Ihighcurrentfilename = Ihighimagefiles(ii).name;
    Ihighcurrentimage = imread(Ihighcurrentfilename);
    Ihighimages{ii} = Ihighcurrentimage;
    IhighTexture{ii} = Screen('MakeTexture', window, Ihighimages{ii});
    Ihighallnames{ii} = Ihighcurrentfilename;
      
end
cd ..

cd(lowholisticppath)
% upside targets

Ulowimagefiles = dir('U*.bmp');
nfiles = length(Ulowimagefiles);  % number of files found

% create variable with mooney numbers and their matching file
mooney_matching = {};

% load and make textures of all of them

for ii = 1:nfiles
    Ulowcurrentfilename = Ulowimagefiles(ii).name;
    Ulowcurrentimage = imread(Ulowcurrentfilename);
    Ulowimages{ii} = Ulowcurrentimage;
    UlowTexture{ii} = Screen('MakeTexture', window, Ulowimages{ii});
    Ulowallnames{ii} = Ulowcurrentfilename;
    
    
    mooney_matching{ii, 1} = ii;
    mooney_matching{ii, 2} = Ulowcurrentfilename;
    
end

Ilowimagefiles = dir('I*.bmp');
nfiles = length(Ilowimagefiles);  % number of files found

% create variable with mooney numbers and their matching file

% load and make textures of all of them

for ii = 1:nfiles
    Ilowcurrentfilename = Ilowimagefiles(ii).name;
    Ilowcurrentimage = imread(Ilowcurrentfilename);
    Ilowimages{ii} = Ilowcurrentimage;
    IlowTexture{ii} = Screen('MakeTexture', window, Ilowimages{ii});
    Ilowallnames{ii} = Ilowcurrentfilename;
    
    
    
end
cd(mainpath)


    

end


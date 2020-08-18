function xy_circle = makecircle(ecc,window_w, window_h, side, exp_params, display, x_center, y_center)

%% circle parameters
eccAng = ecc; % degrees of visual angle
if eccAng == 0
    eccAng=100;
end
radius = angle2pix(display, eccAng); %distance from center
if strcmp(side, 'left')
    theta = 180; %angles equally spaced (returns equally spaced number of points along circle)
elseif strcmp(side, 'right')
    theta = 360; %angles equally spaced (returns equally spaced number of points along circle)
else
    theta = 0;
end

%Adjusted so that four locations (the corners) are given for each point
%along the circle
x_circle = window_w/2 + (cosd(theta) * radius);
y_circle = window_h/2 + (sind(theta) * radius);

%Adjusted so that the stimuli is centered
% xy_circle = [x_circle-w_img/2; y_circle-h_img/2;
%     x_circle+w_img/2; y_circle+h_img/2];
xy_circle = [x_circle-exp_params.w_img_resized/2; y_circle-exp_params.h_img_resized/2;
    x_circle+exp_params.w_img_resized/2; y_circle+exp_params.h_img_resized/2];

xy_center = [x_center-exp_params.w_img_resized/2; y_center-exp_params.h_img_resized/2;
    x_center+exp_params.w_img_resized/2; y_center+exp_params.h_img_resized/2];

% add center rect for seventh option
if strcmp(side, 'fovea')
    xy_circle = xy_center;
end
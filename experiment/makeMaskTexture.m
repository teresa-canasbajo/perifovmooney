function [ Mask_Mem_Tex ] = makeMaskTexture(window, x_center, y_center, w_img, h_img)
%MAKEMASKTEXTURE This function creates mask texture for perifovmooney exp
% It has the size of the mooney faces. 

mask_mem = (resizem(round(rand(300,200))*255, [w_img h_img]));
Mask_Mem_Tex = Screen('MakeTexture', window, mask_mem);


end


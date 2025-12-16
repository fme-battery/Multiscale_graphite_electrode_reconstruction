%% Electrode Meshing
% INPUTS -----------------
resolution = 1/3; % Resolution of the electrodes (um/pixel)
file_struct = " " ; % folder where the electrodes are located
folder_mesh = " " ; % folder where to save the meshes
% ------------------------


im01 = importdata(file_struct);
   
electrode2mesh = cat(3,im01,3*ones(90,90,20)) ;
[no,fc,el] = Iso2mesh(electrode2mesh,resolution,5,5) ; 

saveBDF(no,fc,el,[folder_mesh,'file name']) ;


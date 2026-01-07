%% Automatic stochastic generation and saving of electrodes with NMC811 particles and CBD as fibers
% -------------------------
% Developed by Dr Mehdi Chouchane under the supervision of Pr Y. Shirley Meng
% University of Chicago, 2023
% Please cite the following article:
% 'Improved rate capability for dry thick electodes through finite elements
% method and machine learning coupling', M.Chouchane et al. (2024)

% INPUTS -----------------
folder_struct = ''; % folder where to save the electrodes
filename_struct = 'Electrodexx' ; % Name of the saved file for the electrode

particle_cuboid = niftiread(" ");
particle_flake = niftiread(" ");
particle_prism = niftiread(" ");

%update the data structure
particle_cuboid = double(particle_cuboid);
particle_flake = double(particle_flake);
particle_prism = double(particle_prism);

%create the material library
lib = cell(3, 1);
lib{1,1} = particle_cuboid;
lib{2,1} = particle_flake;
lib{3,1} = particle_prism;

N = 1 ; % Number of electrodes to generate
dimension = [30 30 60] ; % x/y/z dimension of the electrode (um)
dimension(3) = dimension(3)*1.2 ; % To account for the cropping in ElectrodeGeneration
resolution = 1/3; % Resolution of the electrodes (um/pixel)
composition = [93 7]; % Weight ratio between AM and CBD
porosity = 0.25 ; % Porosity of the electrode
density_Graphite = 2.26 ;
density_CBD = 0.95 ;
% ------------------------
%% Electrode Generation
ratio_mass = (composition(:,1)*density_CBD) ./ (composition(:,2)*density_Graphite) ;
Vtotal = prod(dimension)/(resolution^3) ;
Vsol = Vtotal * (1 - porosity) ;
composition = [(Vsol/Vtotal)*ratio_mass/(1+ratio_mass) (Vsol/Vtotal)/(1+ratio_mass) porosity] ; % Volumetric composition of the electrode
actual_porosity = porosity + composition(2)*0.5 % Actual porosity of the electrode taking into account 50% porous CBD
for i = 1: N
    id = ['00',num2str(i)] ;
    id = id(end-1:end) ;
    [IM,im2] = ElectrodeGeneration(dimension,resolution,composition) ;
    save([folder_struct,id,'_',filename_struct,'.mat'],'IM') ;
end



## Repository cloning instructions

Repository uses Git large file storage (LFS) module, cloning repository without Git LFS module will lead to large nessesary files being replaced with pointers which cannot be used in executables.
  1) Download and install Git https://git-scm.com/ and Git LFS module https://git-lfs.com/
  2) Open Git Bash and type "git lfs install" in the terminal to initialize LFS module.
  3) Clone the repository with following command in Git Bash terminal "git clone **repository-url** <**Local/directory/path**>" will clone repsository to sepcified folder on device or cloud. 

     Example: Git clone  https://github.com/BatteryCoast/Multiscale_graphite_electrode_reconstruction.git "C:\folder"

# Electrode reconstruction
Multiscale graphite Electrode reconstruction toolbox is made by Weijia Gong mail:(weijiag@student.uia.no)

Project supervisor: Williams A. Appiah mail: (williams.a.appiah@uia.no)

This repository describes an approach of multi-scale graphite electrode reconstruction through graphite electrode particles made in 3D modeling software. The particle was created in 3D modelling software and exported as an engineering file (e.g., an STL file), containing the particle's surface mesh. The surface mesh was solidified by the Python scripts. To reconstruct the electrode in MATLAB, the solid mesh file was converted to a 3D image matrix (.nii file) with proper dimensions. The particles filled out the electrode dimension with a size distribution factor. To achieve the active materials fraction, particles that were cut in half were filled into the boundary of the electrode. The carbon binder domains, as the mixture of carbon black and binder, were distributed around the graphite particle. The separator was added in the mesh formation process, and the graphite cell mesh was exported as the .bdf file that can be used later in COMSOL Multiphysics.

The approach is composed of 3 parts: 1. Particles to matrix. 2. Electrode reconstruction. and 3. Cell mesh formation.
The workflow is as follows: 
## 1. Particles to matrix
  1) The particle mesh was made using 3D modelling software and exported as an STL file.
  2) The mesh can be either a surface mesh or a solid mesh. Solidify the surface mesh using "Solidify_the_surface_mesh.m".
  3) Convert the STL file into the 3D volumetric image, which is a binary matrix that can be used for further computation in MATLAB. The conversion process is done by the software "Slicer". In Slicer, upload the STL file as the source and go to the "Data" located on the toolbar to convert the source into a segmentation node. Edit the property of the segmentation node by clicking "specify the geometry". Set the size of the particle by the dimension of the particle controlled by the Oversampling factor. (Oversample factor of the cuboid particle: 0.25, flake particle: 0.3, prism particle: 0.25, and the default voxel size is 0.1 micrometer)
  4) Convert the updated segmentation node to the binary label map and export the file as nii format.
  5) Update the pixel dimension and spaceunit of the nii file by using "Update nii Parameter.ipynb".

## 2. Electrode reconstruction
  1) Fill the particle file address into the file "Electrode Generation.m" in the folder Part 2 Electrode Generation and "ElectrodeGerenation.m" in the folder toolbox.
  2) Add the folder toolbox and iso2mesh to the path. 
  3) Run the script "Electrode Generation.m" to get the electrode structure.

## 3. Cell Mesh formation
  1) Run the script "Cell_Mesh.m".

## COMSOL simulation guideline:
The discharging process simulation was conducted in 1C, 3C, and 5C. 
  1. Open one of the mph file(COMSOL 6.2) 
  2. Click on "Browse" in the Mesh/"Import" tab and select your mesh file (.bdf) 
  3. Don't click on "import" but click on "All Domains" in the Definitions/"Selections" tab 
  4. Once the mesh has been imported, tick "All domains" in Definitions/Selections/"All Domains" tab 
  5. Click on Definitions/Selections/"CBD", then click on "Add" ("+" sign) and add "ID 3 Import" 
  6. Click on Definitions/Selections/"Separator", then click on "Add" ("+" sign) and add "ID 21 Import 1" 
  7. Click on Definitions/Selections/"Graphite", then click on "Add" ("+" sign) and add all the items starting from "ID 1001 Import 1" to the bottom 
  8. Click on Definitions/"Current Collector", then click on "Geometry", then "Measure"  
  9. Click on Definitions/"Graphite", then click on "Geometry", then "Measure" 
  10. Click on Global Definitions/"Parameters", then copy paste the surface (displayed in the "Messages" tab) of the current collector into the "Surface_CC_Solid" variable, and the volume of the Graphite into the "VolumeGraphite" variable 
  11. Check the current rate, and the output time in Study/Step2: Time-Dependent, press "compute"
## Notes: 
1. If you are using an electrode with a different thickness, you have to modify in Definitions/Selections/"Box Li Foil" the parameter "z minimum" accordingly. Here the thickness of the separator is 6 µm. 
2. If you encounter a "self-intersecting face" error when importing a mesh, right-click on "Mesh", select Intersections and Partitions/"Detect Faces", add the ID of the faces self intersecting based on the error message, and put Maximum_neighbor_angle = 20°
## Link to original Battery Coast repository
https://github.com/BatteryCoast/Multiscale_graphite_electrode_reconstruction.git

This approach is developed based on the MATLAB code and COMSOL script done by Dr. Mehdi Chouchane and iso2mesh.

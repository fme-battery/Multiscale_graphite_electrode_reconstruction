## Repository cloning instructions

Repository uses Git large file storage (LFS) module, cloning repository without Git LFS module will lead to large nessesary files being replaced with pointers which cannot be used in executables.
  1) Download and install Git https://git-scm.com/ and Git LFS module https://git-lfs.com/
  2) Open Git Bash and type "git lfs install" in the terminal to initialize LFS module
  3) Clone the repository with following command in Git Bash terminal "git clone <repository-url> '<Local/directory/path>'" will clone repsository to sepcified local folder 

# GraphiteReconstruct
Graphite reconstruction toolbox is made by Weijia Gong mail:(weijiag@student.uia.no)

This repository describes an approach of graphite reconstruction through graphite particles made in 3D modeling software. The particle was created in 3D modelling software and exported as an engineering file (e.g., an STL file), containing the particle's surface mesh. The surface mesh was solidified by the Python scripts. To reconstruct the graphite electrode in MATLAB, the solid mesh file was converted to a 3D image matrix (nii file) with proper dimensions. The particles filled out the electrode dimension with a size distribution factor. To achieve the active materials fraction, particles that were cut in half were filled into the boundary of the electrode. The carbon binder domains, as the mixture of carbon black and binder, were distributed around the graphite particle. The separator was added in the mesh formation process, and the graphite cell mesh was exported as the bdf file that can be used later in COMSOL Multiphysics. 

The approach is composed of 3 parts: 1. Particles to matrix. 2. Electrode reconstruction. and 3. Cell mesh formation.
The workflow is as follows: 
## Particles to matrix
  1) The particle mesh was made using 3D modelling software and exported as an STL file.
  2) The mesh can be either a surface mesh or a solid mesh. Solidify the surface mesh using "Solidify_the_surface_mesh.m".
  3) Convert the STL file into the 3D volumetric image, which is a binary matrix that can be used for further computation in MATLAB. The conversion process is done by the software "Slicer". In Slicer, upload the STL file as the source and go to the "Data" located on the toolbar to convert the source into a segmentation node. Edit the property of the segmentation   node by clicking "specify the geometry". Set the size of the particle by the dimension of the particle controlled by the Oversampling factor. (Oversample factor of the cuboid particle: 0.25, flake particle: 0.3, prism particle: 0.25, and the default voxel size is 0.1 micrometer)
  4) Convert the updated segmentation node to the binary label map and export the file as nii format.
  5) Update the pixel dimension and spaceunit of the nii file by using "Update nii Parameter.ipynb".

## Electrode reconstruction
  1) Fill the particle file address into the file "Electrode Generation.m" in the folder Part 2 Electrode Generationand "ElectrodeGerenation.m" in the folder toolbox.
  2) Add the folder toolbox and iso2mesh to the path. 
  3) Run the script "Electrode Generation.m" to get the electrode structure.

## Cell Mesh formation
  1) Run the script "Cell_Mesh.m".

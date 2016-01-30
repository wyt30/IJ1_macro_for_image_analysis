# IJ1_macro_for_image_analysis
ImageJ Macro Program for biologists to quantify IHC/ICC pictures

*********************************
I wrote this ImageJ Macro program to automate quantification of my IHC images (fluorescent).
Any suggestions for improvement will be greatly appreciated!

All programs in this repository assumes that there is a main folder containing several subfolders, each of the subfolders contain the individual images.
*******************************
Main program: Quantify.ijm
      Purpose: quantification of immunofluorescent staining.
      Method: this program quantifies positively stained area in immunofluorescent staining microscopy pictures
        The intensity treshold is mannually defined by "Min" and "Max" at the begining of the program
        Any pixels with in the treshold will be counted as positively stained
        
Additonal programs:
1. Preprocessing.ijm
Purpose: 1. This program will display all images in subfolders in the specified folder, and ask the 
            user to check for presence of debris or bubbles and to mannually remove them.
         2. Usually I take microscopy images in several different channels, eg., Dapi, FITC, TRITC...
            If the images are always taken in the same order (eg. Dapi then FITC then TRITC), 
            this program can also allow you to select one of the channel and store them in a seperate folder 
            
2. Rename.ijm
Purpose: to rename image1-Image9 to image01-Image09
         I had a problem with "Preprocessing.ijm", because ImageJ thinks "Image2.tif" is after "Image10.tif",
         therefore messing up the order of the images. 
         By adding a "0" before the single digit index, ImageJ will be able to process the images in the corect order.
         Note: I had to save a copy of all the images in a separate folder in order to change the title of the images, which is probably not the smartest way to do it.
               Python would be able to change the title of the images directly without saving an additional copy.
               
3. Rename_Preprocessing.ijm
Purpose: This program is a combination of "rename.ijm" and "Prepreocessing.ijm".

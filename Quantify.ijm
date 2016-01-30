 //version 201601130
 //Purpose: quantification of immunofluorescent staining.
 //Method: this program quantifies positively stained area in immunofluorescent staining microscopy pictures
 //        The intensity treshold is mannually defined by "Min" and "Max" at the begining of the program
 //        Any pixels with in the treshold will be counted as positively stained
 
 //Note: you can also first remove dirt and bubbles using "20151207_removing_dirt.ijm"

// Set the arbitary thresdhold. 
// I chose 75 because it captures most of the positive staining while removes most of the background noise
Min=75;
Max=255;

// Set the scale. In my case, 386.74 pixels in the image correspond to 500 µm
pixelNumber=386.74 
knownDistance=500 
unit="µm"

// Set the colour channel to be either "blue", "green", or "red"
colour = "red"

i=1;
j=1;

//The program assumes that the specified folder contains a list of subfolders
//and each of the subfolders contain a set of images to be analyzed
directoryFolder= getDirectory("Please specify the folder containing the folders of images");
//print(directoryFolder);

nameFolder = File.getName(directoryFolder); //get name of the folder containing images
//print(nameFolder);

//The program automatically creates a folder to store the tresholded images after processing
directoryResult=substring(directoryFolder,0,lengthOf(directoryFolder)-lengthOf(nameFolder)-1)+nameFolder+"_result";
File.makeDirectory(directoryResult);
//print(directoryResult);

listFolder=getFileList(directoryFolder);
print("There are "+listFolder.length+" folders in "+ nameFolder+ ".");
//Array.print(listFolder);

for (i=0;i<listFolder.length;i++) {
//for (i=0;i<2;i++) {
   print(listFolder[i]);
   File.makeDirectory(directoryResult+"\\"+listFolder[i]);
   listSample=getFileList(directoryFolder+listFolder[i]);
   //print("There are "+listSample.length+" images in the sample image folder:");
   Array.print(listSample);

   for (j=0;j<listSample.length;j++){
   	open(directoryFolder+listFolder[i]+listSample[j]);
   	if ((i==0)&&(j==0)){
   		run("Set Scale...", "distance="+pixelNumber+" known="+knownDistance+" pixel=1 unit="+unit+" global");
   		run("Colors...", "foreground=black background=black selection=yellow");
   	}

   	//Select the correct colour channel
   	//After "Split Channels", the images will be sperated into three channels
   	//which are, from front to back, blue, green, and red
   	run("Split Channels");
   	if (colour == "green") {
   		close()
   	}
   	if (colour == "red") {
   		close();
   		close();
   	}
   
   	setThreshold(Min, Max);
   	run("Convert to Mask");
   	saveAs("Jpeg", directoryResult+"\\"+listFolder[i]+listSample[j]); 
        run("Analyze Particles...", "size=0-Infinity show=[Overlay Masks] summarize in_situ");	
        run("Close All");
   }

   //The analysis results are to be found at "Summary" window
 }


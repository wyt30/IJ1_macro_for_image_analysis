//version 20160130  
//This program is a combination of "rename.ijm" and "Prepreocessing.ijm".
//Purpose: 1. This program will display all images in subfolders in the specified folder, and ask the 
//            user to check for presence of debris or bubbles and to mannually remove them.
//         2. Usually I take microscopy images in several different channels, eg., Dapi, FITC, TRITC...
//            If the images are always taken in the same order (eg. Dapi then FITC then TRITC), 
//            this program can select one of the channel and store them in a seperate folder 
//         3. To rename image1-Image9 to image01-Image09
//            I had a problem with choosing the correct channel because ImageJ thinks "Image2.tif" is after "Image10.tif",
//            therefore messing up the order of the images. 
//            By adding a "0" before the single digit index, ImageJ will be able to process the images in the corect order.
//            Note: I had to save a copy of all the images in a separate folder in order to change the title of the images, which is probably not the smartest way to do it.
//                  Python would be able to change the title of the images directly without saving an additional copy.
        

// In my case, for each field of view, I first took an image in Dapi channel then another in TRITC channel
// Therefore, my total channel number is 2, and I want to analyze TRITC channel, which is number 2.
totalChannel = 2; // The total number of channels in which images are taken
channelOfInterest = 2; // The channel that is to be analyzed

directoryFolder= getDirectory("Please specify the folder containing the folders of images");
//print(directoryFolder);

nameFolder = File.getName(directoryFolder); //get name of the folder containing images
//print(nameFolder);

directoryResult=substring(directoryFolder,0,lengthOf(directoryFolder)-lengthOf(nameFolder)-1)+nameFolder+"_dirt_removed";
File.makeDirectory(directoryResult);
//print(directoryResult);

listFolder=getFileList(directoryFolder);
//print("There are "+listFolder.length+" folders in "+ nameFolder+ ".");
//Array.print(listFolder);

for (i=0;i<listFolder.length;i++) {
   File.makeDirectory(directoryResult+"\\"+listFolder[i]);
   listSample=getFileList(directoryFolder+listFolder[i]);
   //print("There are "+listSample.length+" images in the sample image folder "+listFolder[i]);
   //Array.print(listSample);

   for (j=0;j<listSample.length/totalChannel;j++){
   	open(directoryFolder+listFolder[i]+listSample[j*totalChannel+channelOfInterest-1]);
   	if (lengthOf(listSample[j*totalChannel+channelOfInterest-1])==10){
   		waitForUser("Please remove bubbles and dirts using drawing tool");
   		run("Select None");
   		saveAs("Tiff", directoryResult+"\\"+listFolder[i]+"\\Image0"+substring(listSample[j*totalChannel+channelOfInterest-1],5,9));
   		close();
   	}
   	else {  
   		waitForUser("Please remove bubbles and dirts using drawing tool");
   		run("Select None");
   		saveAs("Tiff", directoryResult+"\\"+listFolder[i]+"\\"+ listSample[j*totalChannel+channelOfInterest-1]);
   		close();
   	}
   }
}

//************ Common errors troubleshoot **********
//ERROR1: "Index out of range" 
//- Reason: total number of images are not multiples of totalChannel
//ERROR2: some images are from the wrong channels
//- Reason: possibly because of the naming of the images. ImageJ list files in alphabetical order,
//          which may be different from the order in which you took the images.
//          In my case, my images were names "ImageX.tif" where X is the index of the image.
//          As a result, "Image10.tif" is processed before "Image2.tif", causing the program to choose the wrong channel.
//          That is why I wrote the "Rename.ijm" to add a "0" before names of images with single digit index.



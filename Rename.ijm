//Version 20151207 
//Purpose: to rename image1-Image9 to image01-Image09
//         I had a problem with "Preprocessing.ijm", because ImageJ thinks "Image2.tif" is after "Image10.tif",
//         therefore messing up the order of the images. 
//         By adding a "0" before the single digit index, ImageJ will be able to process the images in the corect order.
//Note: I had to save a copy of all the images in a separate folder in order to change the title of the images, which is probably not the smartest way to do it.
//      Python would be able to change the title of the images directly without saving an additional copy.

directoryFolder= getDirectory("Please specify the folder containing the folders of images");
//print(directoryFolder);

nameFolder = File.getName(directoryFolder); //get name of the folder containing images
//print(nameFolder);

directoryResult=substring(directoryFolder,0,lengthOf(directoryFolder)-lengthOf(nameFolder)-1)+nameFolder+"_renamed";
File.makeDirectory(directoryResult);
//print(directoryResult);

listFolder=getFileList(directoryFolder);
//print("There are "+listFolder.length+" items in "+ nameFolder+ ".");
//Array.print(listFolder);

for (i=0;i<listFolder.length;i++) {
   File.makeDirectory(directoryResult+"\\"+listFolder[i]);
   listSample=getFileList(directoryFolder+listFolder[i]);
   //print("There are "+listSample.length+" images in the sample image folder:");
   //Array.print(listSample);

   for (j=0;j<listSample.length;j++){
   	open(directoryFolder+listFolder[i]+listSample[j]);
   	//My images are saved as "ImageX.tif", where X is the index of the image starting from 1.
   	//therefore, all images with single digit index (1,2,3,...,9) will have a title of length 10.
   	//I would then add a "0" before the index.
   	if (lengthOf(listSample[j])==10){
   		saveAs("Tiff", directoryResult+"\\"+listFolder[i]+"\\Image0"+substring(listSample[j],5,9));
   		close();
   	}
   	//If the image index is not single digit, I save it as it is. 
   	else {  
   		saveAs("Tiff", directoryResult+"\\"+listFolder[i]+"\\"+ listSample[j]);
   		close();
   	}
   }
}



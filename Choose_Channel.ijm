//version 20160130  
//Purpose: to rename image1-Image9 to image01-Image09
//	edit: process the red channel images only, and add "remove dirt" command. 

directoryFolder= getDirectory("Please specify the folder containing the folders of images");
//print(directoryFolder);

nameFolder = File.getName(directoryFolder); //get name of the folder containing images
print(nameFolder);

directoryResult=substring(directoryFolder,0,lengthOf(directoryFolder)-lengthOf(nameFolder)-1)+nameFolder+"_dirt_removed";
File.makeDirectory(directoryResult);
//print(directoryResult);

listFolder=getFileList(directoryFolder);
print("There are "+listFolder.length+" folders in "+ nameFolder+ ".");
//Array.print(listFolder);

for (i=0;i<listFolder.length;i++) {
//for (i=0;i<2;i++) {
   File.makeDirectory(directoryResult+"\\"+listFolder[i]);
   listSample=getFileList(directoryFolder+listFolder[i]);
   print("There are "+listSample.length+" images in the sample image folder "+listFolder[i]);
   Array.print(listSample);

   for (j=0;j<listSample.length/2;j++){
   	open(directoryFolder+listFolder[i]+listSample[j*2+1]);
   	if (lengthOf(listSample[j*2+1])==10){
   		waitForUser("Please remove bubbles and dirts using drawing tool");
   		run("Select None");
   		saveAs("Tiff", directoryResult+"\\"+listFolder[i]+"\\Image0"+substring(listSample[j*2+1],5,9));
   		close();
   	}
   	else {  
   		waitForUser("Please remove bubbles and dirts using drawing tool");
   		run("Select None");
   		saveAs("Tiff", directoryResult+"\\"+listFolder[i]+"\\"+ listSample[j*2+1]);
   		close();
   	}
   }
}



// Version 20160131
// Purpose: to remove white colored scale bar from images
// Method: removeScale(path): the main function. It looks into all the items in the folder specified by "path".
//         -If the item is a subfolder (see isFolder(path) function), it calls removeScale(path) on the subfolder.
//         -If the item is an TIFF image (see isTiff(path) function), it calls findScale(imageName) and clearArea(imageName) to remove any white colored area
//         findScale(imageName): it splits the image into HSB stacks (inspiration from "Color Threshold" plugin), and threshold any pixels with
//                               brightness = 255, then converts the threshold to selection and adds to ROI manager.
//         clearArea(imageName): it applies gussian blur filter 4 times in the ROI (inspiration from Angiogensis Analyzer tool set, Blurred Mask Tool).
// Note: only pure white scale bar works here. If your scale bar is another color, you may need to adjust the threshold in findScale() by running "Color Threshold" plugin 
//----------------------------------------------

directoryFolder= getDirectory("Please specify the folder containing the images");
//print(directoryFolder);
//list=getFileList(directoryFolder);
//Array.print(list);
dirLength = lengthOf(directoryFolder);

nameFolder = File.getName(directoryFolder); //get name of the folder containing images
//print(nameFolder);

directoryResult=substring(directoryFolder,0,lengthOf(directoryFolder)-lengthOf(nameFolder)-1)+nameFolder+"_scale_removed";
File.makeDirectory(directoryResult);
//print(directoryResult);

pathResult = directoryResult;

removeScale(directoryFolder);

print("************END OF PROGRAM***********");

//-----------------------------------------------
function removeScale(path) {
	length = lengthOf(path);
	//if the path refers to a folder, run removeScale function on each of the subfolders.
	//print(substring(path,length-4,length));
	if (isFolder(path)) {
		//print(path+" is a folder!");
		//pathResult = directoryResult +substring(path, dirLength-1, lengthOf(path));
		//File.makeDirectory(pathResult);
		//print("new directory made: "+pathResult);
		list = getFileList(path);
		for (i=0; i<list.length; i++) {
			subPath = substring(path,0,length-1)+"\\"+list[i];
			subLength = lengthOf(subPath);
			//print("Processing subfolder: "+subPath);
			if (isFolder(subPath)) {
				//print(subPath+" is a folder!");
				pathResult = directoryResult +substring(subPath, dirLength-1, lengthOf(subPath));
				File.makeDirectory(pathResult);
				print("new directory made: "+pathResult);

				removeScale(subPath);
			}
			else if (isTiff(subPath)) {
				//print(subPath+" is an image!");
				open(subPath);
				name = getTitle();
				print(name);
		
				findScale(name);
				clearArea(name);
				saveAs("Tiff", directoryResult+substring(subPath,dirLength-1,lengthOf(subPath)));
				run("Close All");
			}
			
		}
	}
	
}

function isFolder(path) {
	length = lengthOf(path);
	if (substring(path,length-1,length)=="/" || substring(path,length-1,length)=="\\") {
		return true;
	}
	else {
		return false;
	}
}

function isTiff(path) {
	length = lengthOf(path);
	if (substring(path,length-4,length)==".tif") {
		return true;
	}
	else {
		return false;
	}
}


function findScale(imageName) {
	if (roiManager("count") != 0) {
		roiManager("Delete");
	}

	selectWindow(imageName);
	
	run("Duplicate...", "title=forThresholding");
	run("HSB Stack");
	setSlice(3); // choose "brightness" slice
	setThreshold(255, 255);


	run("Create Selection");
	roiManager("add");
	close("forThresholding");
}

function clearArea (imageName) {

	selectWindow(imageName);
	roiManager("Select",0);

	run("Gaussian Blur...", "sigma=10");
	run("Gaussian Blur...", "sigma=10");
	run("Gaussian Blur...", "sigma=10");
	run("Gaussian Blur...", "sigma=10");
}


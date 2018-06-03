Red = 15;
Green = 18;
Max = 65535;

directoryFolder= getDirectory("Please specify the folder containing the folders of images");
//print(directoryFolder);

listSample=getFileList(directoryFolder);

directoryResult=directoryFolder + "result";
File.makeDirectory(directoryResult);
//print(directoryResult);

for (j=0;j<listSample.length;j++){
   	open(directoryFolder+listSample[j]);
   	

run("Stack to Images");
selectWindow("Blue");
close();
selectWindow("Red");
setThreshold(6670, 20000);
run("Convert to Mask");
run("Analyze Particles...", "size=4-500 show=[Overlay Masks] display include summarize in_situ");

run("16-bit");
setAutoThreshold("Default dark");
a=0;
b=0;
getThreshold(a,b);
print(a)
print(b)
a=getTitle()
print(indexOf(a,"3"));



function Quantify(){
	Red = 25;
	Green = 20;
	Max = 65535;
	
	title = getTitle();
	run("16-bit");
	setOption("BlackBackground", false);
	
	if(indexOf(title,"3")>0){
		setThreshold(Red, Max);
		waitForUser("OK");
		run("Convert to Mask");
	}

	if(indexOf(title,"2")>0){
		setThreshold(Green, Max);
		waitForUser("OK");
		run("Convert to Mask");
	}

	run("Watershed");
	run("Analyze Particles...", "size=4-2000 show=[Overlay Masks] display include summarize in_situ");
}

function Quantify(){
	Red = 25;
	Green = 20;
	Max = 65535;
	
	title = getTitle();
	run("16-bit");
	setOption("BlackBackground", false);
	
	setThreshold(Green, Max);
	waitForUser("OK");
	run("Convert to Mask");
		
	run("Watershed");
	run("Analyze Particles...", "size=10-2000 show=[Overlay Masks] display include summarize in_situ");
}

Quantify();
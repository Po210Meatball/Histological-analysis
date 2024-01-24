//open image and split channels removing unsued blue
run("Fly Brain");
run("Split Channels");

selectImage("flybrain.tif (blue)");
run("Close");

selectImage("flybrain.tif (red)");
run("Red");
rename("image_A");

selectImage("flybrain.tif (green)");
run("Green");
rename("image_B");

//run segmentation for image_A and image_B
run("DiAna_Segment", "img=image_A filter=median rad=1.0 thr=64-3-1000000-false-false");
run("DiAna_Segment", "img=image_B filter=median rad=1.0 thr=177-3-1000000-false-false");

//duplicated image_A to make image_C applying same filters as in segmentation
selectImage("image_A");
run("Duplicate...", "title=image_C duplicate");
selectImage("image_C");
run("Median...", "radius=1 stack");
setThreshold(64, 255);
run("Convert to Mask", "background=Dark calculate create");

//select mask of image_C to make summary table to for if statement for each slice
selectImage("MASK_image_C");
run("Invert", "stack");
run("Analyze Particles...", "summarize composite stack");

//for each slice if there is somesignal, create slection and make it one pixel smaller and subtract from slice

for (i = 1; i < nSlices+1; i++) {
	if (Table.get("%Area", i-1)<100){
	setSlice(i);
	run("Create Selection");
	run("Make Inverse");
	run("Enlarge...", "enlarge=-1 pixel");
	run("Make Inverse");
	run("Clear", "slice");
	run("Select None");
	}
	else {
	setSlice(i);
	}
}
run("Invert", "stack");
selectWindow("Summary of MASK_image_C"); 
run("Close" );

//run segmentation with MASK_image_C with no filters and threshold of 1
run("DiAna_Segment", "img=MASK_image_C filter=none rad=1.0 thr=1-3-1000000-false-false");

//run analysis of image_A and image_B
run("DiAna_Analyse", "img1=image_A img2=image_B lab1=image_A-labelled lab2=image_B-labelled coloc adja kclosest=1");
selectImage("coloc");
run("8-bit");
run("Cyan");
run("Merge Channels...", "c1=image_A c2=image_B c5=coloc create keep");
selectImage("Composite");
rename("colocAB");

//close unused windows
close("coloc");
close("image_A");
close("image_A-labelled");

selectWindow("AdjacencyResults"); 
saveAs("Results", "C:/Users/lipidomics/Desktop/AdjacencyResults_AB.csv");
run("Close" );

selectWindow("ColocResults"); 
run("Close" );

//run analysis of image_c and image_B
run("DiAna_Analyse", "img1=image_C img2=image_B lab1=MASK_image_C-labelled lab2=image_B-labelled coloc adja kclosest=1");

selectImage("coloc");
run("8-bit");
run("Cyan");
run("Merge Channels...", "c1=image_C c2=image_B c5=coloc create keep");
selectImage("Composite");
rename("colocCB");

//close unused windows and save data
close("coloc");
close("image_B");
close("image_B-labelled");
close("MASK_image_C");
close("MASK_image_C-labelled");
close("image_C");

selectWindow("AdjacencyResults"); 
saveAs("Results", "C:/Users/lipidomics/Desktop/AdjacencyResults_CB.csv");
run("Close" );

selectWindow("ColocResults"); 
run("Close" );

//open 3D viewer
run("3D Viewer");
call("ij3d.ImageJ3DViewer.setCoordinateSystem", "false");
call("ij3d.ImageJ3DViewer.add", "colocAB", "None", "colocAB", "0", "true", "true", "true", "2", "0");

//close coloc windows
close("colocAB")
close("colocCB");


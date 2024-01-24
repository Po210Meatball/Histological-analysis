# Histological-analysis

The ImageJ macro code (Macro.ijm) uses the sample image "Fly Brain" that comes with the program.
the program requires the following prerequisite Plugins: 3D ImageJ Suite, ImageScience (both found as a update site) and DiAna (found as DiAna_1.52.jar file in the Code file)
The program first segments the two channels (nc82 = green, GAL4 = red to create a mask of the 3D objects in each channel. 
It then creates a third image of GAL4 that is filtered the same way.
It then loops through each Z-stack slice and makes the GAL4 signal one pixel smaller if there is signal present.
The program then segments the edited GAL4 image.
The program then finds the closest object each GAL4 and nc82 has. 
The outputs are saved as .csv files (you need to update the path if you want to run this yourself)
Lastly the updated brain image is opened in the 3D viewer. A gif of the 3D brain is saved in Outputs and Figures file. 

The R file (Data_Manipulation.R) opens the two output files generated from the ImageJ macro code as a dataframe
The program then creates one unified and labelled dataframe
I then create a theme for the plot
I then create a histogram for both the unedited and edited fly brain. The histogram can be viewed in the Outputs and Figures file.



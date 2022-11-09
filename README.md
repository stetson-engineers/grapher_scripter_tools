# grapher_scripter_tools
 Editing and updating Grapher™ files and products.


<!-- ABOUT THE PROJECT -->
## About The Project

These are scripts for automating common updates related to creating and modifying graph figures through the Grapher™ program.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started
To use, Golden Software's [Grapher™](https://www.goldensoftware.com/products/grapher) installation is required. Grapher™ comes with an included script execution/automation platform "Scripter".  This is also required and may require some addtional configuration to set up.

Operating System is expected to be Windows. However, no other library requirements are currently identified.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- USAGE EXAMPLES -->
## Usage
General usage on these scripts is to place it in the directory with grapher files (.grf) in question, 
and then execute through the Scripter interface.  Scripter should open up Grapher then iterate through 
all of the grapher files in the directory and execute the requested commmand.

*Warning* 
Grapher files are in some ways like a HTML file in that they are a description of 
how data (and sometimes images) should be displayed, however acutal data, etc. exist in other linked 
files (e.g. Microsoft Excel files).  Depending on how things are organized, these linked files could 
be located anywhere (even on different volumes).

*Best Practices* 
are that all of the files required for a .grf are located in the same directory or 
a subdirectory.  Additionally (as of 2021) for maxium backwards compatablity, linked images should not be used,
rather images should be inserted into the file as Image Metafiles.

### Usage - Update_Grapher_Results.BAS
With the default settings, this will go through and generate Vector PDFs for each .grf file in 
the directory it is in.  Commented out code also includes support for generating PNG images.

### Usage - Update_Grapher_figure_numbers.BAS
With the default settings, this will go through and modify the figure number text
so that it matches the filename of the file.  Makes it easier to reorder a series of files.

To work, the figure text must be in a specific location (`file.Shapes.Item(1).Shapes.Item(5)`) in Grapher "Object Manager".  Grapher counts from the bottom up, so it must be in a group located at the bottom (item 1), and it must be the 5th item from the bottom in that group (item 5).

*Note* some of the PDF tools are designed to add the figure text automatically.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTACT -->
## Contact

Miles McCammon - milesm@stetsonengineers.com
Project Link: [https://github.com/stetson-engineers/grapher_scripter_tools](https://github.com/stetson-engineers/grapher_scripter_tools)
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

The need for this was originally developed in 2014 for the need to rapidly update PNG files as part of a chain to support and rapidly update the Camp Pendleton Groundwater Monitoring Program (GWMP) Binder. 

<p align="right">(<a href="#readme-top">back to top</a>)</p>

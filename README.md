Course: Geoinformation Systems (GIS) Application
--------------------------------

* Date: Monday -- Tuesday, **March 20-21, 2017**
* Time: **9.30 -- 16.30** 
* Location:  Building **E III**, room **PC-I** (in front of the Audimax).


## Lecturer

* [Dr. Avit K. Bhowmik](https://avitbhowmik.ml/)


## Before we start

### Install R

You may use the computers at PC-I, where R and necessary packages are already installed. However, I would encourage you to bring your own computers. If you don't already have R installed in your computers, please download and install it from [here](http://cran.rstudio.com/). 

You can use the code editor of your choice. However, I recommend using [RStudio Desktop](http://www.rstudio.com/products/rstudio/download/).


### Installing spatial packages

Packages extend the basic functionality of R and add functions and datasets.
For this course we will need a few extra packages developed for spatial analyses. Please install the following packages - simply paste and run this command in your R prompt:

```{R}
install.packages(c("maptools", "raster", "rgeos", "moments", "gstat"), 
                 dependencies = TRUE)
```


### Downloading course materials

1. [Click here](https://github.com/AvitBhowmik/gisapp17/archive/master.zip) to download the course materials.
2. Unzip the file - The unzipped folder contains all files and folders of this on-line repository.


## Structure of the course

The course constitutes theoretical and practical parts. In the theoretical part, I will cover:

* Introduction to Geographic Information Systems (GIS)
* Introduction to Spatial Statistics and Spatial Interpolation 
* Application of spatial interpolation to ecotoxicological analyses

In the practical part, I will demonstrate the application of spatial interpolation for the prediction of heavy metal concentrations in groundwater of Bangladesh using R. Subsequently, I will show the process of ecotoxicological risk mapping by comparing the predicted concentrations with guideline values.


## Participants' evaluation

The performance of the participants will be evaluated though [group projects](https://github.com/AvitBhowmik/gisapp17/tree/master/project). The projects and groups will be announced on Tuesday.


## Course evaluation

You will receive a course evaluation form from the university. However, I would appreciate your feedback on my part of the course. You comments will help me to improve the course. Please use [this form](https://goo.gl/forms/8JDk97hKWsUWLQYx1) for your feedback. **Your feedback will remain anonymous**.
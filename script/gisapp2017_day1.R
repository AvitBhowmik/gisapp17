
##########################################################################################
##########################################################################################
##							Spatial Interpolation with R 								##
##								GIS Application											##
##							   March 20-21, 2017										##
##							  Dr. Avit K. Bhowmik										##
##########################################################################################
##########################################################################################

##########################################################################################
##										Day 1			 								##
##									March 20, 2017										##
##########################################################################################

## Set the working directory

setwd("/Users/avitbhowmik/Teaching_Supervision/Teaching_Landau/GIS_Application_2017/gisapp17/data")


## Read and visualize "Shapefiles" - spatial objects

## Load the spatial package

library(maptools)

## Spatial Polygons, i.e. Area

bd.boundary <- readShapePoly("bd_boundary")

class(bd.boundary)

summary(bd.boundary)

bbox(bd.boundary)

## Visit http://spatialreference.org/ref/epsg/25832/

proj4string(bd.boundary) <-
CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")

## Access coordinates and data

bd.boundary@bbox

bd.boundary@data

bd.boundary@data$UNREG1


# Plot shapefile

plot(bd.boundary)

spplot(bd.boundary["UNREG1"])


## Point spatial data from comma-separated (or text) values. Visualizing on polygons.

bd.heavy.metal <- read.csv("bd_heavy_metal.csv", sep=",", header=TRUE)

class(bd.heavy.metal)

head(bd.heavy.metal)

tail(bd.heavy.metal)


######################################################

## Exercise 1: Is bd.heavy.metal a space-time data? ##
## If so, what are the space-time attributes of it? ##

######################################################

## Convert into SpatialPointsDataFrame and visualize them

coordinates(bd.heavy.metal) <- ~LONG_DEG+LAT_DEG
proj4string(bd.heavy.metal) <-
CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")

class(bd.heavy.metal)

head(bd.heavy.metal@coords)

head(bd.heavy.metal@data)

spplot(bd.heavy.metal, 4:ncol(bd.heavy.metal@data), xlim=c(87.9, 92.9), ylim=c(20.6, 26.8),
	sp.layout=list("sp.polygons", bd.boundary, col="gray"),
	col.regions=colorRampPalette(c("blue", "green", "yellow", "orange", "red"))(100),
	scales=list(draw=T), colorkey=T)
	
library(ggmap)
library(rgdal)
bd.map <- get_map(location = "bd", source="google", zoom = 7)

bd.metal <- spTransform(bd.heavy.metal, CRS("+init=epsg:3857"))

plot(bd.metal, bgMap = bd.map, pch = 16, cex = .5)

spplot(bd.metal, 4,
sp.layout = list(panel.ggmap, bd.map, first = TRUE),
col.regions=colorRampPalette(c("blue", "green", "yellow", "orange", "red"))(100),
scales=list(draw=T), colorkey=T)


## Save it as a shape file

writePointsShape(bd.heavy.metal, "bd_heavy_metal")


# Spatial Grids, i.e. Rasters

library(raster)

bd.elv <- raster("bd_elv.tif")

bd.elv[Which(bd.elv<=0, cells=TRUE)] <- NA

class(bd.elv)

plot(bd.elv)

plot(bd.boundary, add=T)

plot(bd.heavy.metal, add=T, col="red")

bd.elv.grid <- as(bd.elv, "SpatialGridDataFrame")

summary(bd.elv.grid)

spplot(bd.elv.grid, sp.layout=list("sp.lines", as(bd.boundary, "SpatialLines")),
	col.regions=topo.colors(100), scales=list(draw=T))


################################################################

## Exercise 2: Load the other rasters from the data directory ##
## Explore them from the plot ##

################################################################

bd.soc <- raster("bd_soc.tif")
bd.scc <- raster("bd_scc.tif")
bd.ph <- raster("bd_ph.tif")
bd.wc <- raster("bd_wc.tif")
bd.pop.dens <- raster("bd_pop_dens.tif")

## Extract values of the spatial predictors at the ground water sampling points

plot(bd.scc)

bd.heavy.metal@data$elv <- extract(bd.elv, bd.heavy.metal)
bd.heavy.metal@data$soc <- extract(bd.soc, bd.heavy.metal)

head(bd.heavy.metal@data)

#############################################################

## Exercise 3: Extract values of SCC, pH, WC and POP_DENS ##

#############################################################

bd.heavy.metal@data$scc <- extract(bd.scc, bd.heavy.metal)
bd.heavy.metal@data$ph <- extract(bd.ph, bd.heavy.metal)
bd.heavy.metal@data$wc <- extract(bd.wc, bd.heavy.metal)
bd.heavy.metal@data$popdens <- extract(bd.pop.dens, bd.heavy.metal)

## Remove duplicated from data

zerodist(bd.heavy.metal, zero=0.008333333)
bd.heavy.metal <- remove.duplicates(bd.heavy.metal)

writePointsShape(bd.heavy.metal, "bd_heavy_metal")

################################# End Day 1 #################################
#############################################################################
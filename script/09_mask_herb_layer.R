################################################################################
### Look at the height distribution of the herb layer (below 1.5 m)
### Rasterize all plots and then calculate average and SD

### First create a herb layer mask for each plot by setting all pixels 
### with values above 1.5 are set to NUll. This means that tree stumps, for example 
### are excluded from further calculations.

### In addition, create a vegetation mask (visible vegetation index) in order to
### remove roads, for example

################################################################################
library(lidR)
library(lasR)
library(terra)
library(sf)
library(car)
library(ggplot2)
###  Load normalized files
files_normalised <- list.files("data/05_las_normalised", pattern = ".las", full.names = TRUE, recursive = TRUE)

### Loading the master table for the overview 
data <- read.csv2("data/mastertable.csv")

#### Loading the coordinates 
coords <- read.csv2("data/coords.csv")
#### Format coordinates as sf object
coords <- st_as_sf(coords, coords = c("x", "y"))

### Work steps:
### Create herb mask
###     --> Rasterize LAS
###     --> cut to 80 m radius with coords
###     --> set values over 1.5 m to NA
###     --> set visible vegetation index with limit and everything without
###         set vegetation to NA
###     --> write out mask for each plot to mask the other files 
###         to mask with it

################################################################################


################################################################################
las <- readLAS(files_normalised[[11]])
head(las$R)
### strange RGB values
### seems to be 16 bit instead of 8 bit RGB Values

# returns the RGB values for the highest points https://stackoverflow.com/questions/66841801/creating-orthomosaic-from-las-point-cloud-in-r
RGBZ <- function(r,g,b,z) {
  bands = list(
    R = r[which.max(z)],
    G = g[which.max(z)],
    B = b[which.max(z)]
  )
  return(bands)
}

################################################################################
### calculation for the VDVI: (Biro et al)
par(mfrow=c(1,2))

las <- readLAS(files_normalised[[36]])
ortho <- pixel_metrics(las, ~RGBZ(R,G,B,Z), res = 1)
VDVI <- (2 * ortho$G - ortho$R - ortho$B) / 
  (2 * ortho$G + ortho$R + ortho$B)
plot(VDVI, range = c(0,0.4))

### replace values lower than x m with NA
vegetation <- app(VDVI, fun=function(x){ x[x < 0.1] <- NA; return(x)} )
plot(vegetation, range = c(0,0.4))

### try out optically for different plots and then set a limit value
### --> manual optical validation
### visually sensible limits for example plots: 
### 1: 0.1
### 8: 0.1, 0.15 also cuts out dry vegetation 
### 23: 0.1 
### 36: 0.1 also fits well here. Cuts out roads sensibly and leaves arable land in

### -> Write loop for all plots with 0.1 as limit value for the mask 

for (i in c(1:40)){
  las <- readLAS(files_normalised[[i]])
  ortho <- pixel_metrics(las, ~RGBZ(R,G,B,Z), res = 1)
  VDVI <- (2 * ortho$G - ortho$R - ortho$B) / 
    (2 * ortho$G + ortho$R + ortho$B)
  vegetation <- app(VDVI, fun=function(x){ x[x < 0.1] <- NA; return(x)} )
  
  max <- pixel_metrics(las, func = max(Z), res = 1)
  point <- vect(coords$geometry[[i]])                         ### Create point coordinate
  buffer <- buffer(point, width = 80)                         ### 80 m buffer around coordinate
  raster_crop <- crop(max, buffer)                            ### cut raster to the respective buffer
  raster_mask <- mask(raster_crop, buffer, inverse = FALSE)   ### mask raster to cut out more precisely
  height_1_5 <- app(raster_mask, fun=function(x){ x[x > 1.5] <- NA; return(x)} )
  
  crop_veg <- crop(vegetation, buffer)
  mask_kraut <- mask(height_1_5,crop_veg, inverse = FALSE)
  
  f <- paste0('data/07_krautschicht/krautschicht', i, '.tif')
  writeRaster(mask_kraut, filename=f, overwrite = TRUE)               
}



### Rename plots from xxx_1 to xxx_01!!!





################################################################################
################################################################################
### Perform calculations for the herb layer
str(data)
files_kraut <- list.files("data/07_krautschicht", pattern = ".tif", full.names = TRUE)

kraut_sd <- c()
kraut_mean <- c()
for(i in c(1:40)){
  tif <- rast(files_kraut[[i]])
  kraut_mean[i] <- mean(values(tif), na.rm = TRUE)
  kraut_sd[i] <- sd(values(tif), na.rm = TRUE)
}


data$kraut_mean <- kraut_mean
data$kraut_sd <- kraut_sd


### write out in master table

#write.csv2(data, "data/mastertable.csv")
################################################################################
################################################################################
################################################################################
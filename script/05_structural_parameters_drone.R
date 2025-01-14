#install.packages("lasR")
#install.packages("lidR")
#install.packages("terra")
#install.packages('lasR', repos = 'https://r-lidar.r-universe.dev')

library(lidR)
library(lasR)
library(terra)
library(sf)
library(raster)

### For each plot, a cropped point cloud is saved in the data/03_las_cropped folder.
### Those must be pre-processed in order to then calculate various structural parameters. 
### They were checked manually and error points were deleted in the programme 
### CloudCompare and saved in the folder 04_las_cloud_compare

#### Calculation of the structural parameters for the drone data:
#### Mean height
#### Standard deviation height
#### Maximum height
#### Height classes of the structure (herb, shrub and tree layer)
#### rumple Index (ground structure)
#### Standard deviation of the terrain model

################################################################################
### Loading the master table to get an overview and to combine it later with the drone data

data <- read.csv2("data/mastertable.csv")

### Read in file paths of the drone data
dateipfade <- list.files("data/04_las_cloud_compare", pattern = ".las", full.names = TRUE, recursive = TRUE)

################################################################################
### Calculate parameters for the first plot

################################################################################
#### Functions to calculate various parameters with lasR
meanz = function(data){ return(mean(data$Z)) }
sdz = function(data){ return(sd(data$Z)) }
maxz = function(data){ return(max(data$Z)) }

################################################################################
### In the first step, all read files are normalised in order to derive the 
### to derive the height structure
f <- file.path(dateipfade)
mesh  <- triangulate(filter = keep_ground())   ### create digital terrain model
trans <- transform_with(mesh, "-")             ### normalise point clouds
write <- write_las(paste0("data/05_las_normalised/","/*_normalised.las"),)
pipeline <- mesh + trans + write
ans <- exec(pipeline, on = f, with = list(progress = TRUE, ncore = 16))

################################################################################
### small loop to load normalised data, calculate parameters 
### and write parameters to master table

files_normalised <- list.files("data/05_las_normalised", pattern = ".las", full.names = TRUE, recursive = TRUE)

### mean height
mean_h_drone <- c()
for (i in c(1:40)){
  read = reader_las_circles(data$Lon[i], data$Lat[i], 80)
  call = callback(meanz, expose = "xyz")
  pipeline <- read + call 
  ans <- exec(pipeline, on = files_normalised[[i]])    
  mean_h_drone[i] <- ans[1]                          
}
mean_h_drone


### standard deviation height
sd_h_drone <- c()
for (i in c(1:40)){
  read = reader_las_circles(data$Lon[i], data$Lat[i], 80)
  call = callback(sdz, expose = "xyz")
  pipeline <- read + call 
  ans <- exec(pipeline, on = files_normalised[[i]])    
  sd_h_drone[i] <- ans[1]                          
}
sd_h_drone


### maximum height
max_h_drone <- c()
for (i in c(1:40)){
  read = reader_las_circles(data$Lon[i], data$Lat[i], 80)
  call = callback(maxz, expose = "xyz")
  pipeline <- read + call 
  ans <- exec(pipeline, on = files_normalised[[i]])    
  max_h_drone[i] <- ans[1]                          
}
max_h_drone

################################################################################
### add calculated parameters to the mastertable

data$mean_h_drone <- mean_h_drone
data$sd_h_drone <- sd_h_drone
data$max_h_drone <- max_h_drone



################################################################################
################################################################################
################################################################################
### Now we calculate the parameters of the soil structure. These are the rumple index
### and the standard deviation of the terrain model


### calculate the rumple Index 

data <- read.csv2("data/mastertable.csv")

### First, a Digital terrain model must be calculated for each plot!
### In order to compare the calculation with the official aerial survey, a 
### raster is created 

#### load the coordinates
coords <- read.csv2("data/coords.csv")
#### Format coordinates as sf object
coords <- st_as_sf(coords, coords = c("x", "y"))

### rumple index is calculated for each plot at 1 x 1 metre, as this allows a comparison
### with the data from the official aerial survey. A higher
### resolution would lead to higher values 

f <- file.path(dateipfade)
rumple_drone <- c()
for (i in c(1:40)){
  pipeline <- dtm(res = 1) 
  dtm_las <- exec(pipeline, on = f[i])
  point <- vect(coords$geometry[[i]])                         ### Create point coordinate
  buffer <- buffer(point, width = 80)                         ### 80 m buffer around coordinate
  raster_crop <- crop(dtm_las, buffer)                        ### crop DTM to the respective buffer
  raster_mask <- mask(raster_crop, buffer, inverse = FALSE)   ### mask DTM to cut out more precisely
  raster <- as(raster_mask, "Raster")                         ### Reshape masked DTM to ‘Raster
  rumple_drone[i] <- rumple_index(raster)                     ### calculate rumple index 
}
rumple_drone

### add to the mastertable
data$rumple_drone <- rumple_drone

### ground structure as standard deviation of the DTM

f <- file.path(dateipfade)
sd_dgm_drone <- c()
for (i in c(1:40)){
  read = reader_las_circles(data$Lon[i], data$Lat[i], 80)
  tri <- triangulate(filter = keep_ground()) 
  call = callback(sdz, expose = "xyz")
  pipeline <- read + tri + call
  ans <- exec(pipeline, on = f[i])
  sd_dgm_drone[i] <- ans[1] 
}
sd_dgm_drone

### add to the mastertable
data$sd_dgm_drone <- sd_dgm_drone

################################################################################
################################################################################

### calculate height classes
### can be calculated in lasR with summarise, using zwbin = ... as argument
### for the classes
### Which heights should be summarised to a class?
### Herb, shrub and tree layer as classes!
### But at what height should boundaries be drawn?
### -> Dierschke 1994 Plant sociology 
### Herb layer 1.5 m
### Shrub layer up to 5 m
### Tree layer above

files_normalised <- list.files("data/05_las_normalised", pattern = ".las", full.names = TRUE, recursive = TRUE)
read = reader_las_circles(data$Lon[1], data$Lat[1], 80)
m = summarise(filter = "drop_z_below 5")
pipeline = read + m
ans = exec(pipeline, on = files_normalised[1])
ans
ans$metrics
### does not work properly with desired intervals

### So access the point cloud directly with lidR

### Loop for calculating the height classes
Anteil_Kraut <- c()
Anteil_Strauch <- c()
Anteil_Baum <- c()
for (i in c(1:40)){
  test <- readLAS(files_normalised[i])
  Anteil_Kraut[i] <- sum(test$Z <= 1.5) / sum(test$X > 0)                    ### access test$X here, otherwise errors will occur
  Anteil_Strauch[i] <- sum(test$Z <= 5 & test$Z > 1.5) / sum(test$X >= 0)
  Anteil_Baum[i] <- sum(test$Z >5) / sum(test$X >= 0)
}

Anteil_Kraut
hist(Anteil_Strauch)

data$Anteil_Kraut_drone <- Anteil_Kraut
data$Anteil_Strauch_drone <- Anteil_Strauch
data$Anteil_Baum_drone <- Anteil_Baum

################################################################################
### write out the file

#write.csv2(data, "data/mastertable.csv")


################################################################################
################################################################################
################################################################################
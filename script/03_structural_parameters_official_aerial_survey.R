library(terra)
library(sf)
library(raster)

#### Calculation of the structural parameters for the official aerial survey
#### Mean height
#### Standard deviation height
#### Maximum height
#### Height classes of the structure (herb, shrub and tree layer)
#### rumple Index (ground structure)
#### Standard deviation of the terrain model


################################################################################
####  Loading the data
dom <- rast("data/amtliche_Befliegungen/dom_100.tif")
dgm <- rast("data/amtliche_Befliegungen/dgm_100.tif")
height <- rast("data/amtliche_Befliegungen/height.tif")

#### Loading the coordinates
coords <- read.csv2("data/coords.csv")
#### Format coordinates as sf object
coords <- st_as_sf(coords, coords = c("x", "y"))

#### Create point and 100m buffer geometry of the plots
point_vec <- vect(coords$geometry)
buff_80 <- buffer(point_vec, width = 80)


################################################################################
#### Calculation of structural parameters

#### mean height
coords$mheight <- extract(height, buff_80, fun = mean)

#### standard deviation of height
coords$sdheight <- extract(height, buff_80, fun = sd)

#### maximum height
coords$maxheight <- extract(height, buff_80, fun = max)

### loop to calculate the height classes
Anteil_Kraut <- c()
Anteil_Strauch <- c()
Anteil_Baum <- c()
for (i in c(1:40)){
  point <- vect(coords$geometry[[i]])                         ### Create point coordinate
  buffer <- buffer(point, width = 80)                         ### 80 m buffer around coordinate
  raster_crop <- crop(height, buffer)                         ### crop height to the respective buffer
  raster_mask <- mask(raster_crop, buffer, inverse = FALSE)   ### mask dgm to cut out more precisely
  Anteil_Kraut[i] <- sum(values(raster_mask) <= 1.5 & values(raster_mask) >= 0, na.rm = TRUE) / sum(values(raster_mask) >= 0, na.rm = TRUE)
  Anteil_Strauch[i] <- sum(values(raster_mask) <= 5 & values(raster_mask) > 1.5, na.rm = TRUE) / sum(values(raster_mask) >= 0, na.rm = TRUE)
  Anteil_Baum[i] <- sum(values(raster_mask) > 5, na.rm = TRUE) / sum(values(raster_mask) >= 0, na.rm = TRUE)
}

Anteil_Kraut
hist(Anteil_Kraut)


################################################################################
#### calculate parameters for the ground structure / roughness

#### rumple index: triangulate points, measure surface created, divide by projected surface
#### measure surface roughness of ground points
#### Build a loop to calculate the rumple index for each plot:

rumple <- c()
for (i in c(1:40)){
  point <- vect(coords$geometry[[i]])                         ### Create point coordinate
  buffer <- buffer(point, width = 80)                         ### 80 m buffer around coordinate
  raster_crop <- crop(dgm, buffer)                            ### crop dgm to the respective buffer
  raster_mask <- mask(raster_crop, buffer, inverse = FALSE)   ### mask dgm to cut out more precisely
  raster <- as(raster_mask, "Raster")                         ### Convert masked dgm to ‘Raster'
  rumple[i] <- rumple_index(raster)                           ### Calculate rumple index
}
rumple



#### Standard deviation of the DTM as second parameter for soil structure
coords$sd_dgm_flight <- extract(dgm, buff_80, fun = sd)



################################################################################
#### make a new table and write it out
str(coords)

###  load table again to split the geometry columns again
data <- read.csv2("data/coords.csv")

data$mheight <- coords$mheight$dom1_32_459_5618_1_he
data$sdheight <- coords$sdheight$dom1_32_459_5618_1_he
data$maxheight <- coords$maxheight$dom1_32_459_5618_1_he

data$rumple <- rumple
data$sd_dgm_flight <- coords$sd_dgm_flight$dgm1_32_459_5618_1_he

data$Anteil_Kraut_flight <- Anteil_Kraut
data$Anteil_Strauch_flight <- Anteil_Strauch
data$Anteil_Baum_flight <- Anteil_Baum


#### rename everything meaningfully 

names(data) <- c("ID", "Plot_name", "breeding", "Lon", "Lat", "mean_h_flight", 
                 "sd_h_flight", "max_h_flight", "rumple_flight","sd_dgm_flight",
                 "Anteil_Kraut_flight", "Anteil_Strauch_flight", "Anteil_Baum_flight")
str(data)
### column with ID and plotname combined
data$ID_name <- paste(data$ID, data$Plot_name)

#write.csv2(data,"data/mastertable.csv")

################################################################################
################################################################################


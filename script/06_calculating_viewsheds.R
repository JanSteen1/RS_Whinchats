################################################################################
library(terra)
library(sf)
library(lidR)
library(raster)
library(viewscape)
library(lasR)
#### Calculate viewshed
#### Whinchats need the highest possible visibility in the breeding area, therefore
#### the visibility in the breeding sites and on the control plots should be compared

### according to Kueblbek et al 2024
### observer height 1 m 
### target height 0.1 m -> predator looks 10 cm above vegetation
### 80 m radius, as whinchats show reactions to humans at this distance
### Calculation of the proportion of the visible area in the 80 m radius

#### Calculation of the viewshed for drones and aerial survey data

################################################################################
#### Loading the data

data <- read.csv2("data/mastertable.csv")

#### Loading the coordinates
coords <- read.csv2("data/coords.csv")
#### Format coordinates as sf object
coords <- st_as_sf(coords, coords = c("x", "y"))

### Load aerial survey data directly
dom <- rast("data/amtliche_Befliegungen/dom_80.tif")  ### Digital surface model
dgm <- rast("data/amtliche_Befliegungen/dgm_80.tif")  ### Digital terrain model

### Drone data does not have to be loaded but is processed directly (lasR)

################################################################################

### Loop with Terra for the flight data

prop_true <- c()
for (i in c(1:40)){
  
  point_vec <- vect(coords$geometry[i])
  buff_view <- buffer(point_vec, width = 80)
  
  dom1 <- crop(dom, buff_view)
  dom1 <- mask(dom1, buff_view) 
  
  view <- viewshed(dom1, c(data$Lon[i], data$Lat[i]), observer = 1 , output = "yes/no")
  
  table <- table(values(view))
  
  false_count <- table["FALSE"]
  true_count <- table["TRUE"]
  
  proportion_true <- true_count / sum(table)
  
  prop_true[i] <- proportion_true
  
}
prop_true

################################################################################

### Loop with Terra to process the drone data
### Drone data is processed via lasR

### Define file paths
dateipfade <- list.files("data/04_las_cloud_compare", pattern = ".las", full.names = TRUE, recursive = TRUE)

prop_true_drone <- c()
for (i in c(1:40)){
  ### Define centre point
  point_vec <- vect(coords$geometry[i])
  buff_view <- buffer(point_vec, width = 80)
  ### Calculate surface model from point cloud
  read = reader_las_circles(data$Lon[i], data$Lat[i], 80) 
  pipeline <- chm(res = 1)
  dom1 <- exec(pipeline, on = dateipfade[i])
  ### calculate viewshed 
  view <- viewshed(dom1, c(data$Lon[i], data$Lat[i]), observer = 1 , output = "yes/no")
  ### Retrieve values and calculate proportion of visible area
  table <- table(values(view))
  
  false_count <- table["FALSE"]
  true_count <- table["TRUE"]
  
  proportion_true <- true_count / sum(table)
  ### Write out values
  prop_true_drone[i] <- proportion_true
  
}
prop_true_drone

### calculated here with res = 1 m, as very small resolutions lead to very fragmented
### results

################################################################################
### Add results to the master table and save 

data$viewshed_flight <- prop_true
data$viewshed_drone <- prop_true_drone
#write.csv2(data, "data/mastertable.csv")

################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
library(sf)
library(mapview)
library(terra)
library(dplyr)
#install.packages("gridExtra")
library(gridExtra)
#install.packages("ggpubr")
library(ggpubr)

################################################################################
### Distances to the nearest roads, buildings and intensively used fields are to be calculated.
### OpenStreetMap is used as the basis for this

data <- read.csv2("data/mastertable.csv")

#### Loading the coordinates 
coords <- read.csv2("data/coords.csv")
dom <- rast("data/amtliche_Befliegungen/dom_100.tif")  ### Digital surface model

#### Format coordinates as sf object
coords <- st_as_sf(coords, coords = c("x", "y"))
coords <- coords %>% st_set_crs(st_crs(dom))


################################################################################
#### Land use as polygons
landuse <- st_read("data/hessen-latest-free.shp/gis_osm_landuse_a_free_1.shp")
#mapview(landuse)  
table(landuse$fclass)

#### Roads as lines
roads <- st_read("data/hessen-latest-free.shp/gis_osm_roads_free_1.shp")
#mapview(roads)
table(roads$fclass)

#### Buildings as polygons
buildings <- st_read("data/hessen-latest-free.shp/gis_osm_buildings_a_free_1.shp")
#mapview(buildings)
table(buildings$fclass)


################################################################################
### bring everything into the same coordinate system

landuse <- st_transform(landuse, crs = st_crs(coords))
buildings<- st_transform(buildings, crs = st_crs(coords))
roads <- st_transform(roads, crs = st_crs(coords))

################################################################################
###


roaddist <- st_distance(coords$geometry[1], roads)
min(roaddist[1,][as.numeric(roaddist[1,])>0])

builddist <- c()
for(i in c(1:40)){
  dist <- st_distance(coords$geometry[i], buildings)
  builddist[i] <- min(dist[1,][as.numeric(dist[1,])>0])
}
builddist


roaddist <- c()
for(i in c(1:40)){
  dist <- st_distance(coords$geometry[i], roads)
  roaddist[i] <- min(dist[1,][as.numeric(dist[1,])>0])
}
roaddist


table(landuse$fclass)
### here explanations of the tags https://wiki.openstreetmap.org/wiki/DE:Key:landuse
### farmland -> agriculturally utilised areas such as fields

farmland <- landuse[landuse$fclass == "farmland",]

farmdist <- c()
for(i in c(1:40)){
  dist <- st_distance(coords$geometry[i], farmland)
  farmdist[i] <- min(dist[1,][as.numeric(dist[1,])>0])
}
farmdist

################################################################################
### Add everything to the master table

data$builddist <- builddist
data$roaddist <- roaddist
data$farmdist <- farmdist

#write.csv2(data, "data/mastertable.csv")
################################################################################

library(terra)
library(sf)

#### Loading of the merged official flights and initial calculations with them
#### Work steps:
#### merge into a raster stack to simplify further steps
#### Cut out the survey areas with the appropriate coordinates
#### Calculation of target parameters

################################################################################
#### Load the previously merged files
dom <- rast("data/amtliche_Befliegungen/dom.tif")
dgm <- rast("data/amtliche_Befliegungen/dgm.tif")

#### merge both rasters into one raster stack

data <- c(dom,dgm)
data

#### load the table with coordinates of all plots
coords <- read.csv2("data/coords.csv")

#### Format coordinates as sf object
coords <- st_as_sf(coords, coords = c("x", "y"))

#### Test whether everything can be plotted
plot(coords$geometry)
plot(data$dom1_32_459_5618_1_he)
plot(coords$geometry, add = TRUE)

### --> looks good!
################################################################################
#### Create 100 metre radius for all coordinates and then mask dgm and dom

point_vec <- vect(coords$geometry)
buff_100 <- buffer(point_vec, width = 100)

#### Cut out DGM and DOM individually to shorten the calculation time

dgm_mask <- mask(dgm, buff_100)
plot(dgm_mask)
writeRaster(dgm_mask, "data/amtliche_Befliegungen/dgm_100.tif")

dom_mask <- mask(dom, buff_100)
plot(dom_mask)
writeRaster(dom_mask, "data/amtliche_Befliegungen/dom_100.tif")
################################################################################
#### Calculation of the height (difference DOM to DGM)

height <- dom - dgm
writeRaster(height, "data/amtliche_Befliegungen/height.tif")
################################################################################

################################################################################
#### Create 80 metre radius for all coordinates and then mask dgm and dom

point_vec <- vect(coords$geometry)
buff_80 <- buffer(point_vec, width = 80)

#### Cut out DGM and DOM individually to shorten the calculation time

dgm_mask <- mask(dgm, buff_80)
plot(dgm_mask)
writeRaster(dgm_mask, "data/amtliche_Befliegungen/dgm_80.tif")

dom_mask <- mask(dom, buff_80)
plot(dom_mask)
writeRaster(dom_mask, "data/amtliche_Befliegungen/dom_80.tif")






















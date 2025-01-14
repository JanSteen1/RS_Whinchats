library(lasR)
library(lidR)
library(ggplot2)
library(car)
################################################################################

### Perching sites are very important for whinchats in the breeding area.
### in lasR, tree crowns can be recognised in LiDAR images of forests. 
### This function is to be modified in order to recognise perches, which 
### naturally have significantly smaller distances to the surroundings than tree crowns

### All images were cropped to a 25 sqm square, because in this 
### radius the perches were recorded manually for all areas

### Perches are objects that protrude above the existing vegetation
### What height do you use for this? 1m? or 80 cm? 
### min_height cannot be less than 1 m in lasR
### or do you choose the normalised las file and take everything that is e.g. 20 cm 
### higher? 

################################################################################
### in lidR for better visualisation as a point cloud

### -> in lidR hmin can be less than 1 m! so better for our application
### perhaps with a formula that uses a different windowsize for taller trees
### than for bushes and single plants

### formula f
f <- function(x) {
  y <- 2.6 * (-(exp(-0.08*(x-2)) - 1)) + 3
  y[x < 1] <- 1.5
  y[x > 3] <- 5
  y[1 <= x & x <= 3] <- 3
  return(y)
}
heights <- seq(-2,5,0.5)
ws <- f(heights)
plot(heights, ws, type = "l",  ylim = c(0,5))
### for hmin less than 1 ws = 3 m, for hmin between 1 and 3 m ws = 4 m, for hmin
### over 3 m ws = 5 m --> In the case of bushes, outer components are not
### as individual treetops and perches on the ground remain separated from each other even at 
### smaller distance from each other

################################################################################
### Loading the .las files
files <- list.files("data/06_25sqm_normalised", pattern = ".las", full.names = TRUE, recursive = TRUE)
las <- readLAS(files[23])

### calculate canopy height model, resolution to 0.1 m
chm <- rasterize_canopy(las, 0.2, pitfree(subcircle = 0.25))

### Calculation of seat locations with locate_trees(), with formula f and variable hmin
ttops <- locate_trees(las, lmf(f, hmin = 0.2))

### Plotting of both for control and visualisation
plot(chm, col = height.colors(50))
plot(sf::st_geometry(ttops), add = TRUE, pch = 18, cex = 1.5)

### look at ttops and write out the number of seats
ttops$Z
length(ttops$treeID)

################################################################################
### and automatic:
files <- list.files("data/06_25sqm_normalised", pattern = ".las", full.names = TRUE, recursive = TRUE)

for (i in c(1:40)){
  las <- readLAS(files[i])
  chm <- rasterize_canopy(las, 0.2, pitfree(subcircle = 0.25))
  ttops <- locate_trees(las, lmf(f, hmin = 0.15))
  sitzwarten_25sqm[i] <- length(ttops$treeID)                         
}
sitzwarten_25sqm

################################################################################
### Add number of perches to the master table


data <- read.csv2("data/mastertable.csv")

data$sitzwarten_25sqm <- sitzwarten_25sqm

################################################################################
### write out the master table

#write.csv2(data, "data/mastertable.csv")

################################################################################
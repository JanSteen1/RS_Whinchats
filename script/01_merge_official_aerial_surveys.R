library(terra)

#### Download the official aerial surveys via the following link: https://gds.hessen.de/INTERSHOP/web/WFS/HLBG-Geodaten-Site/de_DE/-/EUR/ViewDownloadcenter-Start
#### Digital terrain model (DTM/DGM) and Digital surface model (DSM/DOM) are available in 1 m resolution as a data set for each municipality
#### The sites are located in the following municipalities:
#### Lauterbach, Grebenhain, Lohra, Münchhausen, Steffenberg, Breidenbach,
#### Driedrof, Hohenahr und Bischoffen

#### Download the files and save them in a folder for DTMs and one for DOMs
#### Now we want to merge all DTMs and DOMs into one large raster

################################################################################
#### Load files DGM - digital terrain model

# Read file paths
dateipfade <- list.files("data/amtliche_Befliegungen/DGMs/", pattern = ".tif", full.names = TRUE, recursive = TRUE)

# Load all files and check them briefly
dgm_all <- lapply(dateipfade, rast)
plot(dgm_all[[3]])

#### merge everything, first as spatRasterCollection and then merge it
dgm_list <- sprc(dgm_all)
dgm <- merge(dgm_list)

plot(dgm)

## Write out merged spatRaster
writeRaster(dgm, "data/amtliche_Befliegungen/dgm.tif",
            overwrite = TRUE)

################################################################################
#### Load files DOM - digital surface model

# Read file paths
dateipfade <- list.files("data/amtliche_Befliegungen/DOMs/", pattern = ".tif", full.names = TRUE, recursive = TRUE)

# Load all files and check them briefly
dom_all <- lapply(dateipfade, rast)
plot(dom_all[[3]])

#### merge everything, first as spatRasterCollection and then merge it
dom_list <- sprc(dom_all)
dom <- merge(dom_list)

plot(dom)

## Write out merged spatRaster
writeRaster(dom, "data/amtliche_Befliegungen/dom.tif",
            overwrite = TRUE)

################################################################################

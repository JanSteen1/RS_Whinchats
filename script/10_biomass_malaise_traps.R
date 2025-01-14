### here the biomass data from the Malaise traps are added and
### averaged and logarithmitized.
### Finally, the data is written out 

### The biomass data is available for four points in time. For simplification and because
### some traps have broken, an average value is calculated

data <- read.csv2("data/mastertable_kopie_Biomasse.csv")

mean_biomass <- rowMeans(data[,35:38] , na.rm = TRUE)
mean_biomass

data$mean_biomass <- mean_biomass

### logarithmize biomass

data$mean_biomass_log <- log(data$mean_biomass)
?log

#write.csv2(data,"data/mastertable.csv")

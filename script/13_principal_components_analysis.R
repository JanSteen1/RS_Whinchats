library(vegan)
library(ggplot2)
library(ggbiplot)
library(gridExtra)
### loading the master table
data <- read.csv2("data/mastertable.csv")
str(data)

### We assign the values 0 and 1 to the categories:
data$breeding[data$breeding=="ja"] <- "yes"
data$breeding[data$breeding=="nein"] <- "no"

data$breeding <- factor(data$breeding, levels = c("yes", "no"))
### clear outlier in SD terrain model drone at plot no. 38
### remove this for calculations or check again
data$sd_dgm_drone[38] <- NA
data <- data[c(1:37,39,40),]



### Perform a principal components analysis to weight the large number of variables
### to weight and standardize them

### PCA can be calculated either in base R or in vegan. 
### with the base R function I can at least calculate PERMANOVAs, in vegan 
### I can create better plots...
################################################################################
### Give all variables good english names as they are plotted below

names(data)
names(data)[names(data) == "Lon"] <- "Longitude"
names(data)[names(data) == "Lat"] <- "Latitude"
names(data)[names(data) == "Anteil_Kraut_flight"] <- "share_herbs_flight"
names(data)[names(data) == "Anteil_Strauch_flight"] <- "share_shrubs_flight"
names(data)[names(data) == "Anteil_Baum_flight"] <- "share_trees_flight"
names(data)[names(data) == "Anteil_Kraut_drone"] <- "share_herbs_drone"
names(data)[names(data) == "Anteil_Strauch_drone"] <- "share_shrubs_drone"
names(data)[names(data) == "Anteil_Baum_drone"] <- "share_trees_drone"
names(data)[names(data) == "sitzwarten_25sqm"] <- "perches_25sqm"
names(data)[names(data) == "Gewicht.17.5"] <- "Weight_biomass_17_5"
names(data)[names(data) == "Gewicht.31.5"] <- "Weight_biomass_31_5"
names(data)[names(data) == "Gewicht.14.6"] <- "Weight_biomass_14_6"
names(data)[names(data) == "Gewicht.1.7"] <- "Weight_biomass_01_7"
names(data)


################################################################################
### rda with vegan package
### all variables can be plotted in a PCA

# official flight: 10:18, drone: 20:28,32:34

### Trim data set to only variables
### Normalize afterwards 
data_drone <- data[,c(3,10:18,20:28,32:34,39)]

### get rid of doubling/uninportant variables
#data_drone <- data_drone[, c(1:10,14:16,17)]

### scale data 
data_drone[, -1] <- scale(data_drone[, -1],
                          center = T, scale = T)

### calculate PCA 
PCA_drone <- rda(data_drone[,-1], scale = TRUE, center = TRUE)

### further analysis
summary(PCA_drone)

################################################################################

### with base package
### applying the PCA
drone_base <- prcomp(data_drone[, -1], center = TRUE, scale = TRUE)

names(drone_base)
drone_base$rotation
drone_base$sdev

# In order to get the variance explained by each principal component 
# we square the standard deviation.

drone_base_var <- drone_base$sdev^2

# To compute the proportion of variance explained by each principal component,
# we simply divide the variance explained by each principal component by the 
# total variance explained by all principal components:

drone_base_ve <- drone_base_var / sum(drone_base_var)
drone_base_ve

head(drone_base$x, 10)

### Variables of the drone and the official flight have the same everywhere 
### Alignment in the PCA 

### Comparison of vegan and base R calculations
summary(PCA_drone) # vegan package
summary(drone_base)#  base R 

### -> Proportion of Variance is identical for the PCA axes 
### I can use vegan for plotting and the other for statistics

### Screeplot shows the relative importance of the axes
screeplot(drone_base, bstick=TRUE)
### Only the first two axes are relevant!

ggbiplot(drone_base,
         choices = c(1,2),
         varname.size = 4,
         varname.color = "red",
         groups = data_drone$breeding,
         ellipse= TRUE, ellipse.alpha =0.1,
         ellipse.prob = 0.68)+
  labs(colour = "Breeding Occurrence", x = "PC1 (48.2%)", y = "PC2 (16.3%)") +
  theme_bw()+  
  xlim(c(-2.9, 2.3))


### Extract PCA scores in order to calculate a PERMANOVA
### PERMANOVA calculates group differences of the PCA axes
pca.scores <- data.frame(drone_base$x, breeding = data_drone$breeding)
adonis2(pca.scores$PC1 ~ breeding, data  = pca.scores, method = "euc")
adonis2(pca.scores$PC2 ~ breeding, data  = pca.scores, method = "euc")


### -> significant differences on the PC2 axis

### PC2 axis is mainly positively correlated with: Viewshed (0.7), next best still mean height with 0.36
### PC 2 is negatively correlated with: SD DGM(-0.8) and rumple index (-0.8). kraut mean and sd still with -0.5

### mean biomass negligible on both axes
### most structural variables are negatively correlated with PC 1. Here, however, no significant differences between the groups

### Plotting the differences on the axes
a <- ggplot(data = pca.scores, aes(x = breeding, y = PC1)) +
  geom_boxplot() +
 # geom_jitter(aes(colour = breeding), width = 0.2, height = 0) +
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=19)"))+
  xlab("Breeding site")+
  ylab("PC1")+
  theme_minimal()+
  theme(legend.position = "none")
a

b <- ggplot(data = pca.scores, aes(x = breeding, y = PC2)) +
  geom_boxplot() +
 # geom_jitter(aes(colour = breeding), width = 0.2, height = 0) +
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=19)"))+
  xlab("Breeding site")+
  ylab("PC2")+
  theme_minimal()+
  theme(legend.position = "none")+
  geom_text(label = "p < 0.05", x= 1.5, y = 2.5)
b

y <- list(a,b)

grid.arrange(
  grobs = y,
  layout_matrix = rbind(c(1,2)),
  top = ""
)

### The plots with whinchats thus have significantly higher values in the 
### positively correlated with PC2 and lower values in the 
### negatively correlated with PC2 

################################################################################
################################################################################
################################################################################
################################################################################
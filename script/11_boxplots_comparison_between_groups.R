library(car)
library(ggplot2)
#install.packages("gridExtra")
library(gridExtra)
#install.packages("ggpubr")
library(ggpubr)

### Comparison of structural parameters between drone flights and official flights 
### official aerial survey flights and comparison within the groups between
### breeding sites and KOntroll areas

### Statistical calculations

data <- read.csv2("data/mastertable.csv")
#write.csv2(data, "data/mastertable.csv")
str(data)

data$breeding <- as.factor(data$breeding)

################################################################################
### mean height
### official aerial survey

a <- ggplot(data=data, aes(x=breeding, y=mean_h_flight))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("mean height (m)")+
  theme_minimal()+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) +
  # ggtitle(" ", subtitle = "official aerial survey")+
  ylim(0,2)

shapiro.test(data$mean_h_flight) 
# not normally distributed -> p < 0.001
leveneTest(data$mean_h_flight, data$breeding)
# Variance homogeneity is present

wilcox.test(data$mean_h_flight ~ data$breeding)
#no sinificant differences between groups


### LiDAR drone 

b <- ggplot(data=data, aes(x=breeding, y=mean_h_drone))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("")+
  theme_minimal()+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) +
  # ggtitle( " " , subtitle = "LiDAR drone ")+
  ylim(0,2)

shapiro.test(data$mean_h_drone) 
# not normally distributed -> p < 0.001
leveneTest(data$mean_h_drone, data$breeding)
# Variance homogeneity is present

wilcox.test(data$mean_h_drone ~ data$breeding)
# no significant differences between groups

y <- list(a,b)

grid.arrange(
  grobs = y,
  layout_matrix = rbind(c(1,2)),
  top = "Durchschnittliche Strukturhöhe"
)

################################################################################
### Standardabweichung Höhe
### official aerial survey

c <- ggplot(data=data, aes(x=breeding, y=sd_h_flight))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("Standard deviation height (m)")+
  theme_minimal()+
  ylim(0,5)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) 
# + ggtitle(" ", subtitle = "official aerial survey")

shapiro.test(data$sd_h_flight) 
# not normally distibuted -> p < 0.001
leveneTest(data$sd_h_flight, data$breeding)
# Variance homogeneity is present

wilcox.test(data$sd_h_flight ~ data$breeding)
# no significant differences between groups

### LiDAR drone 

d <- ggplot(data=data, aes(x=breeding, y=sd_h_drone))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("")+
  theme_minimal()+
  ylim(0,5)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) 
#+ ggtitle(" ", subtitle = "LiDAR drone ")

shapiro.test(data$sd_h_drone) 
# not normally distibuted -> p < 0.001
leveneTest(data$sd_h_drone, data$breeding)
# Variance homogeneity is present

wilcox.test(data$sd_h_drone ~ data$breeding)
# no significant differences between groups

y <- list(c,d)

grid.arrange(
  grobs = y,
  layout_matrix = rbind(c(1,2)),
  top = "Standardabweichung Strukturhöhe"
)

################################################################################
### maximum height
### official aerial survey

e <- ggplot(data=data, aes(x=breeding, y=max_h_flight))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("maximum height (m)")+
  theme_minimal()+
  ylim(0,40)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) +
 #  ggtitle(" ", subtitle = "official aerial survey")+
  # geom_text(label = ".", x= 1.5, y = 42.5, size = 6)+
  geom_text(label = "p < 0.1", x= 1.5, y = 40)

shapiro.test(data$max_h_flight) 
#  normally distibuted -> p > 0.001
leveneTest(data$max_h_flight, data$breeding)
# Variance homogeneity is present

t.test(data$max_h_flight ~ data$breeding)
# no significant differences between groups
### quite close wuíth p = 0.068

### LiDAR drone 

f <- ggplot(data=data, aes(x=breeding, y=max_h_drone))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("")+
  theme_minimal()+
  ylim(0,40)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) 
 #  ggtitle(" ", subtitle = "LiDAR drone ")
  # geom_text(label = ".", x= 1.5, y = 42.5, size = 6)+
 # geom_text(label = "p < 0.1", x= 1.5, y = 40)

shapiro.test(data$max_h_drone) 
# normally distibuted -> p < 0.05
leveneTest(data$max_h_drone, data$breeding)
# Variance homogeneity is present

t.test(data$max_h_drone ~ data$breeding)
# no significant differences between groups
### also quite close p = 0.058

y <- list(e,f)

grid.arrange(
  grobs = y,
  layout_matrix = rbind(c(1,2)),
  top = "Maximale Strukturhöhe"
)


################################################################################
### rumple index 
### official aerial survey

g <- ggplot(data=data, aes(x=breeding, y=rumple_flight))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("Rumple Index")+
  theme_minimal()+
  ylim(1,1.02)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) +
 # ggtitle(" ", subtitle = "official aerial survey")+
  # geom_text(label = "*", x= 1.5, y = 1.02)+
  geom_text(label = "p < 0.05", x= 1.5, y = 1.02)

shapiro.test(data$rumple_flight) 
# not normally distibuted -> p > 0.001
leveneTest(data$rumple_flight, data$breeding)
# Variance homogeneity is present

wilcox.test(data$rumple_flight ~ data$breeding)
# significant differences between groups


h <- ggplot(data=data, aes(x=breeding, y=rumple_drone))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("")+
  theme_minimal()+
  ylim(1,1.02)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) +
 #  ggtitle(" ", subtitle = "LiDAR drone ")+
  #  geom_text(label = "*", x= 1.5, y = 1.02)+
  geom_text(label = "p < 0.05", x= 1.5, y = 1.02)

shapiro.test(data$rumple_drone) 
# not normally distibuted -> p > 0.05
leveneTest(data$rumple_drone, data$breeding)
# Variance homogeneity is present

wilcox.test(data$rumple_drone ~ data$breeding)
# significant differences between groups

y <- list(g,h)

grid.arrange(
  grobs = y,
  layout_matrix = rbind(c(1,2)),
  top = "Bodenstruktur - rumple Index"
)

################################################################################
#### ground structure - standard deviation of DGM
### official aerial survey

i <- ggplot(data=data, aes(x=breeding, y=sd_dgm_flight))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("SD terrain model")+
  theme_minimal()+
  ylim(0,6.5)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) +
  #ggtitle(" ", subtitle = "official aerial survey")+
  # geom_text(label = "*", x= 1.5, y = 1.02)+
  geom_text(label = "p < 0.05", x= 1.5, y = 6)

shapiro.test(data$sd_dgm_flight) 
# normally distibuted -> p < 0.05
leveneTest(data$sd_dgm_flight, data$breeding)
# Variance homogeneity is present

t.test(data$sd_dgm_flight ~ data$breeding)
# significant differences between groups

### LiDAR drone  

### Plot 38 with a strange outlier (sd = 31) therfore = NA
data$sd_dgm_drone[38] <- NA

j <- ggplot(data=data, aes(x=breeding, y=sd_dgm_drone))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("")+
  theme_minimal()+
  ylim(0,6.5)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=19)")) +
  #ggtitle(" ", subtitle = "LiDAR drone ")+
  #  geom_text(label = "*", x= 1.5, y = 1.02)+
  geom_text(label = "p < 0.05", x= 1.5, y = 6)

shapiro.test(data$sd_dgm_drone) 
#not normally distibuted -> p < 0.05
leveneTest(data$sd_dgm_drone, data$breeding)
# Variance homogeneity is present

wilcox.test(data$sd_dgm_drone ~ data$breeding)

# significant differences between groups

y <- list(i,j)

grid.arrange(
  grobs = y,
  layout_matrix = rbind(c(1,2)),
  top = "Bodenstruktur - Standardabweichung - DGM"
)


################################################################################
###viewshed

### official aerial survey

k <- ggplot(data=data, aes(x=breeding, y=viewshed_flight))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("viewshed")+
  theme_minimal()+
  ylim(0,1)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) 
 # ggtitle(" ", subtitle = "official aerial survey")

shapiro.test(data$viewshed_flight) 
#  normally distibuted -> p > 0.001
leveneTest(data$viewshed_flight, data$breeding)
# Variance homogeneity is present

t.test(data$viewshed_flight ~ data$breeding)
# no significant differences between groups

### LiDAR drone 

l <- ggplot(data=data, aes(x=breeding, y=viewshed_drone))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("")+
  theme_minimal()+
  ylim(0,1)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) +
  #ggtitle(" ", subtitle = "LiDAR drone ")+
  #  geom_text(label = "*", x= 1.5, y = 1)+
  geom_text(label = "p<0.05", x= 1.5, y = 0.9)

shapiro.test(data$viewshed_drone) 
# normally distibuted -> p > 0.001
leveneTest(data$viewshed_drone, data$breeding)
# Variance homogeneity is present

t.test(data$viewshed_drone ~ data$breeding)
# significant differences between groups!!

y <- list(k,l)

grid.arrange(
  grobs = y,
  layout_matrix = rbind(c(1,2)),
  top = "Sichtweite - Viewshed"
)

################################################################################
#### height classes - herb, shrub and tree layer

### official aerial survey

m <- ggplot(data=data, aes(x=breeding, y=Anteil_Kraut_flight))+
  geom_boxplot()+
  ylab("Herb Layer (%)")+
  xlab("Breeding site")+
  theme_minimal()+
  ylim(0.8,1)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) 
 # ggtitle(" ", subtitle = "official aerial survey")

shapiro.test(data$Anteil_Kraut_flight) 
# not normally distibuted -> p < 0.001
leveneTest(data$Anteil_Kraut_flight, data$breeding)
# Variance homogeneity is present

wilcox.test(data$Anteil_Kraut_flight ~ data$breeding)
# no significant differences between groups

### LiDAR drone 

n <- ggplot(data=data, aes(x=breeding, y=Anteil_Kraut_drone))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("")+
  theme_minimal()+
  ylim(0.8,1)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) 
  #ggtitle(" ", subtitle = "LiDAR drone ")
#  geom_text(label = "*", x= 1.5, y = 1)+
# geom_text(label = "p<0.05", x= 1.5, y = 0.9)

shapiro.test(data$Anteil_Kraut_drone) 
# not normally distibuted -> p < 0.001
leveneTest(data$Anteil_Kraut_drone, data$breeding)
# Variance homogeneity is present

wilcox.test(data$Anteil_Kraut_drone ~ data$breeding)
# no differences between groups

y <- list(m,n)

grid.arrange(
  grobs = y,
  layout_matrix = rbind(c(1,2)),
  top = "Anteil der Punkte in Krautschicht"
)

################################################################################
### percentage shrub layer 

### official aerial survey

o <- ggplot(data=data, aes(x=breeding, y=Anteil_Strauch_flight))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("Shrub Layer (%)")+
  theme_minimal()+
  ylim(0,0.1)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) 
#  ggtitle(" ", subtitle = "official aerial survey")

shapiro.test(data$Anteil_Strauch_flight) 
# not normally distibuted -> p < 0.001
leveneTest(data$Anteil_Strauch_flight, data$breeding)
# Variance homogeneity is present

wilcox.test(data$Anteil_Strauch_flight ~ data$breeding)
# no significant differences between groups

### LiDAR drone 

p <- ggplot(data=data, aes(x=breeding, y=Anteil_Strauch_drone))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("")+
  theme_minimal()+
  ylim(0,0.1)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) 
#  ggtitle(" ", subtitle = "LiDAR drone ")
#  geom_text(label = "*", x= 1.5, y = 1)+
# geom_text(label = "p<0.05", x= 1.5, y = 0.9)

shapiro.test(data$Anteil_Strauch_drone) 
# not normally distibuted -> p < 0.001
leveneTest(data$Anteil_Strauch_drone, data$breeding)
# Variance homogeneity is present

wilcox.test(data$Anteil_Strauch_drone ~ data$breeding)
# no differences between groups

y <- list(o,p)

grid.arrange(
  grobs = y,
  layout_matrix = rbind(c(1,2)),
  top = "Anteil der Punkte in Strauchschicht"
)

################################################################################
### percentage of tree layer 
### official aerial survey

q <- ggplot(data=data, aes(x=breeding, y=Anteil_Baum_flight))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("Tree Layer (%)")+
  theme_minimal()+
  ylim(0,0.18)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) 
 # ggtitle(" ", subtitle = "official aerial survey")

shapiro.test(data$Anteil_Baum_flight) 
# not normally distibuted -> p < 0.001
leveneTest(data$Anteil_Baum_flight, data$breeding)
# Variance homogeneity is present

wilcox.test(data$Anteil_Baum_flight ~ data$breeding)
# no significant differences between groups

### LiDAR drone 

r <- ggplot(data=data, aes(x=breeding, y=Anteil_Baum_drone))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("")+
  theme_minimal()+
  ylim(0,0.18)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) 
 # ggtitle(" ", subtitle = "LiDAR drone ")
#  geom_text(label = "*", x= 1.5, y = 1)+
# geom_text(label = "p<0.05", x= 1.5, y = 0.9)

shapiro.test(data$Anteil_Baum_drone) 
# not normally distibuted -> p < 0.001
leveneTest(data$Anteil_Baum_drone, data$breeding)
# Variance homogeneity is present

wilcox.test(data$Anteil_Baum_drone ~ data$breeding)
# no significant differences between groups

y <- list(q,r)

grid.arrange(
  grobs = y,
  layout_matrix = rbind(c(1,2)),
  top = "Anteil der Punkte in Baumschicht"
)

################################################################################
### distance to buildings

s <- ggplot(data=data, aes(x=breeding, y=builddist))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("Distanz zu Gebäuden (m)")+
  theme_minimal()+
  ylim(0,850)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) +
  ggtitle(" ", subtitle = "Gebäude")
#  geom_text(label = "*", x= 1.5, y = 1)+
# geom_text(label = "p<0.05", x= 1.5, y = 0.9)

shapiro.test(data$builddist) 
# normally distibuted -> p > 0.001
leveneTest(data$builddist, data$breeding)
# Variance homogeneity is present

t.test(data$builddist ~ data$breeding)
# # no significant differences between groups

################################################################################
### distance to roads

t <- ggplot(data=data, aes(x=breeding, y=roaddist))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("Distanz zu Straßen (m)")+
  theme_minimal()+
  ylim(0,200)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) +
  ggtitle(" ", subtitle = "Straßen")+
  #  geom_text(label = "*", x= 1.5, y = 1)+
  geom_text(label = "p<0.05", x= 1.5, y = 190)

shapiro.test(data$roaddist) 
# not normally distibuted -> p < 0.001
leveneTest(data$roaddist, data$breeding)
# Variance homogeneity is present

wilcox.test(data$roaddist ~ data$breeding)
# differences!!! Sites with whinchats are significantly further away from roads

################################################################################
### distance to intensive agriculture

u <- ggplot(data=data, aes(x=breeding, y=farmdist))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("Distanz zu intensiven Äckern (m)")+
  theme_minimal()+
  ylim(0,3500)+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) +
  ggtitle(" ", subtitle = "Äcker")
#  geom_text(label = "*", x= 1.5, y = 1)+
# geom_text(label = "p<0.05", x= 1.5, y = 0.9)

shapiro.test(data$farmdist) 
# not normally distibuted -> p < 0.05
leveneTest(data$farmdist, data$breeding)
# Variance homogeneity is present

wilcox.test(data$farmdist ~ data$breeding)
### # no significant differences between groups, but also generally very high distances in comparison,
### how far the individual plots are from each other

y <- list(s,t,u)

grid.arrange(
  grobs = y,
  layout_matrix = rbind(c(1,2,3)),
  top = "Distanzen zu möglicherweise störenden Faktoren"
)

################################################################################
### number of perches

v <- ggplot(data=data, aes(x=breeding, y=sitzwarten_25sqm))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("Number of perches")+
  theme_minimal()+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) +
 #  ggtitle("Anzahl Sitzwarten")+
  # geom_text(label = ".", x= 1.5, y = 1)+
  geom_text(label = "p < 0.1", x= 1.5, y = 7.5)+
  ylim(0,8)
v

shapiro.test(data$sitzwarten_25sqm) 
# not normally distibuted -> p < 0.05
leveneTest(data$sitzwarten_25sqm, data$breeding)
# Variance homogeneity is present

wilcox.test(data$sitzwarten_25sqm ~ data$breeding)
# closely not significant
################################################################################
### differnces in height of herb layer 

### SD Krautschicht
w <- ggplot(data=data, aes(x=breeding, y=kraut_sd))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("SD height herb layer")+
  theme_minimal()+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) +
  # ggtitle(" ", subtitle = "official aerial survey")+
  ylim(0,0.25)

shapiro.test(data$kraut_sd) 
#  normally distibuted -> p > 0.05
leveneTest(data$kraut_sd, data$breeding)
# Variance homogeneity is present

t.test(data$kraut_sd ~ data$breeding)
# no significant differences between groups


################################################################################
### mean height herb layer 
x <- ggplot(data=data, aes(x=breeding, y=kraut_mean))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("mean height herb layer")+
  theme_minimal()+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) +
  # ggtitle(" ", subtitle = "official aerial survey")+
  ylim(0,0.3)

shapiro.test(data$kraut_mean) 
# normally distibuted -> p > 0.05
leveneTest(data$kraut_mean, data$breeding)
# Variance homogeneity is present

t.test(data$kraut_mean ~ data$breeding)
# no significant differences between groups

y <- list(w,x)

grid.arrange(
  grobs = y,
  layout_matrix = rbind(c(1,2)),
  top = "Struktur der Krautschicht"
)


################################################################################
### Unterschiede in der Biomasse in den Malaisefallen, komplett und log

### mean Biomasse
aa <- ggplot(data=data, aes(x=breeding, y=mean_biomass))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("mean biomass")+
  theme_minimal()+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) +
  # ggtitle(" ", subtitle = "official aerial survey")+
  ylim(0,120)

shapiro.test(data$mean_biomass) 
#  not normally distibuted -> p < 0.05
leveneTest(data$mean_biomass, data$breeding)
# Variance homogeneity is present

wilcox.test(data$mean_biomass ~ data$breeding)
# no significant differences between groups


################################################################################
### mean biomass (log)
ab <- ggplot(data=data, aes(x=breeding, y=mean_biomass_log))+
  geom_boxplot()+
  xlab("Breeding site")+
  ylab("mean biomass (log")+
  theme_minimal()+
  scale_x_discrete(labels= c("yes\n(n=20)", "no\n(n=20)")) +
  # ggtitle(" ", subtitle = "official aerial survey")+
  ylim(2,5)

shapiro.test(data$mean_biomass_log) 
# not normally distibuted -> p < 0.05
leveneTest(data$mean_biomass_log, data$breeding)
# Variance homogeneity is present

wilcox.test(data$mean_biomass_log ~ data$breeding)
# no significant differences between groups

y <- list(aa,ab)

grid.arrange(
  grobs = y,
  layout_matrix = rbind(c(1,2)),
  top = "Unterschiede in der Biomasse normal und log"
)


################################################################################
################################################################################
################################################################################
################################################################################
################################################################################

############## Overview significant differences  ###############################


#### maximum height with 0.1 > p > 0.05
#### Areas with whinchats have lower heights

#### rumple index with p < 0.05
#### Areas with whinchat with lower values -> less soil structure

#### SD DTM with p < 0.05
#### Areas with whinchat with lower values -> less soil structure

#### viewshed with p < 0.05 
#### Areas with whinchat with higher viewshed

#### except viewshed, data from the aerial surveys and drone are equally significant
#### for viewshed only the drone data

#### Distance to roads with p < 0.05
#### Areas with whinchats with more distance to roads

#### Number of perches on 25 sqm with 0.1 > p > 0.05
#### Areas with whinchats have more perches

################################################################################
################################################################################


### Plotting the final plots for the thesis

### significant differences between groups are in the following variables
### maximum height (only flight)
### rumple index (both)
### sd dgm (both)
### viewshed (only drone)
### number of perches (only available for drone)

### plot names are:
### e+f, g+h, i+j, k+l, v

library(grid)

y <- list(e,f,
          g,h,
          i,j,
          k,l,
          v)

grid.arrange(
  grobs = y,
  layout_matrix = rbind(c(1,2),
                        c(3,4),
                        c(5,6),
                        c(7,8),
                        c(NA,9)),
  top = "       official aerial survey                        LiDAR drone data"
)

# Add horizontal lines between rows using segmentsGrob
# Adjust the "y" positions to add lines between each row

#grid::grid.rect(gp = gpar(col = "white", fill = "white"))  # To clear any borders

# Function to draw a horizontal line between rows
draw_lines <- function(y_position) {
  grid::grid.lines(
    x = unit(c(0, 1), "npc"),  # From left to right of the plot area
    y = unit(y_position, "npc"),  # Position where the line should go
    gp = gpar(col = "black", lwd = 1)  # Line color and thickness
  )
}

# Draw horizontal lines between the rows
draw_lines(0.782)  # Between row 1 and 2
draw_lines(0.585)  # Between row 2 and 3
draw_lines(0.39)  # Between row 3 and 4
draw_lines(0.195)  # Between row 4 and 5

################################################################################

### make all the other plots for the supplemental

### a+b, c+d, m+n, o+p, q+r, w+x


y <- list(a,b,
          c,d,
          m,n,
          o,p,
          q,r,
          w,x)

grid.arrange(
  grobs = y,
  layout_matrix = rbind(c(1,2,3,4),
                        c(5,6,7,8),
                        c(9,10,11,12)),
  top = "        official aerial survey                                                                               LiDAR drone data"
) 

# Function to draw a horizontal line between rows
draw_lines <- function(y_position) {
  grid::grid.lines(
    x = unit(c(0, 1), "npc"),  # From left to right of the plot area
    y = unit(y_position, "npc"),  # Position where the line should go
    gp = gpar(col = "black", lwd = 1)  # Line color and thickness
  )
}
# Function to draw a vertical line
draw_vertical_line <- function(x_position) {
  grid::grid.lines(
    x = unit(x_position, "npc"),  # Position of the vertical line (relative to plot area)
    y = unit(c(0, 1), "npc"),     # The line goes from top to bottom
    gp = gpar(col = "black", lwd = 1)  # Line color and thickness
  )
}


draw_lines(0.648)  # Between row 1 and 2
draw_lines(0.325)  # Between row 2 and 3
draw_vertical_line(0.5) 


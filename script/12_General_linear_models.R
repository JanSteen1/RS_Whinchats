library(car)
library(lme4)
library(MASS)
library(DHARMa)
library(glmmTMB)
library(performance)

#### First, a data exploration is carried out in order to, among other things
#### correlating data and then calculate univariate models

#### GLMs can be calculated with breeding as a binary variable or with breeding success as a
#### variable

### loading the master table
data <- read.csv2("data/mastertable.csv")
#write.csv2(data, "data/mastertable.csv")
str(data)

### We assign the values 0 and 1 to the categories:
data$breeding[data$breeding=="ja"] <- 1
data$breeding[data$breeding=="nein"] <- 0

data$breeding <- as.factor(data$breeding)

# Regression analysis roadmap

#a) Research question: 

### 1. does the structure differ between breeding habitats and control plots?
### -> First boxplots of the calculated variables (in previous scripts)
### -> then calculate GLMs to compare different variables with each other 
### -> explanatory variable is 1. breeding site yes/no and 2. breeding success (num)
### -> what best explains the differences between the breeding habitats and 
### control plots?

### 2. to what extent are remote sensing data suitable for recording and characterizing potential habitats? 
### and characterize potential habitats
### -> to answer this question I can't really carry out my own
### own analyses but it is only a discussion 
### of the other question

### 3. is high-resolution drone data necessary to answer the questions 
### or is data from official aerial surveys sufficient?
### -> Comparison of the boxplots and GLMs of the different data bases
### again rather a discussion of the results of the 1st question 

### 4. make recommendations for renaturation measures
### -> can I derive concrete values from my models that can be used to
### of restoration measures in the breeding areas? 

#b) Experimental/study design

#c) Presentation of the experimental design

#d) Data exploration: 8 steps - see below
# -> Outliers

################################################################################
# Outliers
################################################################################
### Calculate outliers for the following variables:
### airplane: mean_h_flight, sd_h_flight, max_h_flight, fraction_herb_flight,
### share_shrub_flight, share_tree_flight, rumple_flight,
### sd_dgm_flight, viewshed_flight
### drone: mean_h_drone, sd_h_drone, max_h_drone, rumple_drone,
### share_shrub_drone, rumple_drone, sd_dgm_drone, viewshed_drone, 
### sitzwarten_25sqm, kraut_mean, kraut_sd
### both: builddist, roaddist, farmdist


### Outliers official flights:
par(mfrow=c(3,3), mar=c(3,3,3,1))
dotchart(data$mean_h_flight, main="Mean height (aerial)",groups = data$breeding, pch=16)
dotchart(data$sd_h_flight, main="SD height (aerial)", groups = data$breeding,pch=16)
dotchart(data$max_h_flight, main="Maximum height (aerial)", groups = data$breeding,pch=16)
dotchart(data$Anteil_Kraut_flight, main="Percentage of herb layer (aerial)", groups = data$breeding,pch=16)
dotchart(data$Anteil_Strauch_flight, main="Percentage of shrub layer (aerial)", groups = data$breeding,pch=16)
dotchart(data$Anteil_Baum_flight, main="Percentage of tree layer (aerial)", groups = data$breeding,pch=16)
dotchart(data$rumple_flight, main="Rumple Index (aerial)", groups = data$breeding,pch=16)
dotchart(data$sd_dgm_flight, main="SD terrain modell (aerial)", groups = data$breeding,pch=16)
dotchart(data$viewshed_flight, main="Viewshed (aerial)", groups = data$breeding,pch=16)

### No clear outliers present

### Outlier drone flight
par(mfrow=c(4,3), mar=c(3,3,3,1))
dotchart(data$mean_h_drone, main="Mean height (drone)", groups = data$breeding,pch=16)
dotchart(data$sd_h_drone, main="SD height (drone)", groups = data$breeding,pch=16)
dotchart(data$max_h_drone, main="Maximum height (drone)", groups = data$breeding,pch=16)
dotchart(data$Anteil_Kraut_drone, main="Percentage of herb layer (drone)", groups = data$breeding,pch=16)
dotchart(data$Anteil_Strauch_drone, main="Percentage of shrub layer (drone)", groups = data$breeding,pch=16)
dotchart(data$Anteil_Baum_drone, main="Percentage of tree layer (drone)", groups = data$breeding,pch=16)
dotchart(data$rumple_drone, main="Rumple Index (drone)", groups = data$breeding,pch=16)
dotchart(data$sd_dgm_drone, main="SD terrain model (drone)", groups = data$breeding,pch=16)
dotchart(data$viewshed_drone, main="Viewshed (drone)", groups = data$breeding,pch=16)
dotchart(data$sitzwarten_25sqm, main="Number of perches in 25 sqm", groups = data$breeding,pch=16)
dotchart(data$kraut_mean, main="mean height of herb layer", groups = data$breeding,pch=16)
dotchart(data$kraut_sd, main="SD height of herb layer ", groups = data$breeding,pch=16)


### clear outlier in SD terrain model drone at plot no. 38
### remove this for calculations or check again
data <- data[c(1:37,39,40),]


### Outliers other:
par(mfrow=c(1,3), mar=c(3,3,3,1))
dotchart(data$builddist, main="Entfernung zu Gebäuden", groups = data$breeding,pch=16)
dotchart(data$roaddist, main="Entfernung zu Straßen", groups = data$breeding,pch=16)
dotchart(data$farmdist, main="Entfernung zu intensiver Landwirtschaft", groups = data$breeding,pch=16)

### Distances are not included in the models, as the areas were not selected at random. 
### The control plots are closer to roads, as they should remain accessible for mapping


### no outliers present!

################################################################################
### Normal distribution? 
### not really relevant when calculating GLMs 
### Many data are not normally distributed anyway or often skewed to one side

################################################################################
### -> multicorrelinearity
### presumably many of the variables correlate with each other
### Therefore we test for multicorrelativity


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
### First, let's see if the data from the official aerial survey correlate with each other

names(data)
source(file = "script/HighstatLib.R")   ### Source Zuur et al. 2010: Formulas for calculating multicorrelativity
pairs(data[,c(10:18)], lower.panel = panel.smooth2, 
      upper.panel = panel.cor,
      diag.panel = panel.hist)


### strong correlation between all height and structural data 
### rumple and sd dgm correlate
### viewshed is OK
### So model with max_h_flight, as differences between the groups were shown here in the boxplot
### sd_dgm_flight and viewshed, rumple also correlated with viewshed
### plus proportion of the herb layer

pairs(data[,c(12,14,17,18)], lower.panel = panel.smooth2, 
      upper.panel = panel.cor,
      diag.panel = panel.hist)

#Variance inflation factor as an alternative/addition to the correlation table
corvif(data[,c(12,14,17,18)])   #all ok (<2)
################################################################################
### Now let's take a look at the data from the drone flight

names(data)
pairs(data[,c(20:28,32:34)], lower.panel = panel.smooth2, 
      upper.panel = panel.cor,
      diag.panel = panel.hist)

### here again strong correlation between all structural variables
### rumple correlates more strongly with everything than sd_dgm
### again keep maximum height and remove others first
### structure within the herb layer correlates strongly with each other
### which one do we keep?  
pairs(data[,c(22,27,28,32,33)], lower.panel = panel.smooth2, 
      upper.panel = panel.cor,
      diag.panel = panel.hist)

#Variance inflation factor as an alternative/addition to the correlation table
corvif(data[,c(22,27,28,32,33)])   #all ok (<2)

#max_h_drone     
#sd_dgm_drone     
#viewshed_drone   
#sitzwarten_25sqm 
#kraut_mean

### here are the variables that can be included in the model

################################################################################

#e) Modeling

### Two different dependent variables can be tested

### either hatchery yes/no as binary variable
### a (multiple) logistic regression is calculated here, i.e. with 
### family = binomial 

### or we take the breeding success as the dependent variable with integers
### here the dependent variable is metric 

### zero inflated models! since more than half of the plots have no breeding success?
### data are count data, so family = poisson or negative binomial
### If the model cannot handle the many zeros
### -> zero inflated models
### Source: The World of Zero-Inflated Models Volume 1: Using GLM, Zuur et al 2021

### Plot as random effect! There is a block design, each with two
### spatially grouped plots of which one is a breeding site and one is not


################################################################################
### Let's start with models for the dependent variable hatchery yes/no, so that
### we don't have to worry about zero-inflation for the time being

### we calculate 2 x models, one for the drone data and one for the data
### of the official aerial survey. The distribution is binomial in each case. 


### Models of official aerial survey:
################################################################################

### Plot as random effect

data$Plot_name <- as.factor(data$Plot_name)
#mixed general linear models (with random effect)
#all discrete distributions (gaussian, binomial, gamma, poisson, quasipoisson) 
# with known discrete dispersion parameter
?lme4::glmer

mod <- glmer(breeding ~ 
               max_h_flight 
             + sd_dgm_flight 
            # + share_shrubs_flight
            # + viewshed_flight
           # + mean_biomass
          #  + Weight_biomass_17_5
          #  + Weight_biomass_31_5
          #  + Weight_biomass_14_6
          #  + Weight_biomass_01_7
             + (1|Plot_name), data= data, family = binomial())
summary(mod)
Anova(mod)
### complete model:   AIC = 52.8
### without viewshed: AIC = 51.1
### without viewshed  AIC = 49.8 --> best model

### model validation!
par(mfrow=c(1,2))
plot(residuals(mod), fitted(mod))#variance hmogeneity
qqnorm(resid(mod))#normally distributed
qqline(resid(mod))
#### -> seems ok

mod_flight_breeding_REffect <- mod

## Check for over/underdispersion in the model
check_overdispersion(mod)

### second model nearly perfect -> 1.01
### model with random Effect Plot should be better


################################################################################
### Breeding success with random effect plot

?glmmTMB::glmmTMB

data$juvenile_2024
### NA at line 25 -> will be removed
data_juv <- data[c(1:24,26:39),]

var<- var(data_juv$juvenile_2024)
mean<- mean(data_juv$juvenile_2024)

var/mean # 1.8, above 1 --> we should use a Quasipoisson distribution!
?glmer

# This is where the fun begins. glmer() does not support the quasipoisson family. 
# Since the negative binomial distribution converges to the Poisson distribution for some parameter settings,
# we take it - even if our data is not sufficiently skewed.
# These are the compromises that have to be made.
# Function glmmTMB has this option. 

mod <- glmmTMB(juvenile_2024 ~ 
                 max_h_flight 
               + sd_dgm_flight 
             #  + share_shrubs_flight
             #  + viewshed_flight
               + (1|Plot_name)
               , data= data_juv, family = nbinom1())
car::Anova(mod, Type="III")
summary(mod) 
AIC(mod)

#Model validation!!!
par(mfrow=c(1,2))
plot(residuals(mod), fitted(mod))
qqnorm(resid(mod))
qqline(resid(mod))
par(mfrow=c(1,1))
#### looks a bit wild, but also okay

### complete model:   AIC -> 110.12
### without viewshed: AIC -> 108.16
### without viewshed: AIC -> 107.02 --> best model

### slightly underdispersed

DHARMa::testZeroInflation(mod)
check_zeroinflation(mod)
### ->maybe slightly Zero Inflation
mod_flight_juvenile2024_REffect <- mod

### Summary of models for official flights
### everywhere the best model is breeding/juvenile_2023 ~ max_h_flight + sd_dgm_flight
### no matter if with or without random effect


### 1.
mod_flight_breeding_REffect
summary(mod_flight_breeding_REffect)
Anova(mod_flight_breeding_REffect, Type = "III")

### 2. 
mod_flight_juvenile2024_REffect
summary(mod_flight_juvenile2024_REffect)
Anova(mod_flight_juvenile2024_REffect, Type = "III")

################################################################################
################################################################################
### Models for drone data

### after correlation test independent variables are:
### max_h_drone, sd_dgm_drone, viewshed_drone, sitzwarten_25sqm, kraut_mean
### and theoretically: builddist, roaddist, farmdist      

mod <- glmer(breeding ~ 
           #    max_h_drone
             + sd_dgm_drone
           #  + viewshed_drone
             + perches_25sqm
           #  + kraut_mean
             + (1|Plot_name), data= data, family = binomial())
summary(mod)
Anova(mod, Type = "III")
### complete model: AIC = 51.1
### without kraut_mean    AIC = 49.4
### without max_h         AIC = 47.6
### without viewshed      AIC = 47.4 -> best model

#Model validation!!
par(mfrow=c(1,2))
plot(residuals(mod), fitted(mod))
qqnorm(resid(mod))
qqline(resid(mod))
#### ->seems to be ok, residuals a bit strange

mod_drone_breeding_REffect <- mod
################################################################################
### now with juvenile_2023 as target variable
### again with random effect plot
mod <- glmmTMB(juvenile_2024 ~ 
              #     max_h_drone
                 + sd_dgm_drone
               #  + viewshed_drone
                 + perches_25sqm
               #  + kraut_mean
               + (1|Plot_name)
               , data= data_juv, family = nbinom2)
car::Anova(mod, Type="III")
summary(mod) 
AIC(mod)

# model validation
par(mfrow=c(1,2))
plot(residuals(mod), fitted(mod))
qqnorm(resid(mod))
qqline(resid(mod))
par(mfrow=c(1,1))

### complete model: AIC -> 113.20
### without viewshed      AIC -> 111.25
### without max_h         AIC -> 109.36
### without kraut_mean    AIC -> 108.71 --> best model
DHARMa::testZeroInflation(mod) ## no zero inflation

mod_drone_juvenile2024_REffect <- mod

################################################################################
################################################################################
### Summary of drone data models

### As with the official survey data, sd_dgm is one of the most important
### variables. The maximum height was often quickly discarded during model optimization 
### and is not significant
### However, the number of perches correlates positively with breeding success
### This could not be determined during the official aerial surveys

### No differences could be found in the various target variables 
### were found.

### 1.
mod_drone_breeding_REffect
summary(mod_drone_breeding_REffect)
Anova(mod_drone_breeding_REffect, Type = "III")

### 2. 
mod_drone_juvenile2024_REffect
summary(mod_drone_juvenile2024_REffect)
Anova(mod_drone_juvenile2024_REffect, Type = "III")



#f) Validation
### is included in each case

#h) Model adjustment & re-validation if necessary
### is included above

################################################################################
#i) Result extraction and presentation

# Writing out the fitted regression lines based on the models
# Plot the results (scatterplot with regression lines)

### compare r2 of the models of drone data and official aerial survey
### to see if they have similar predictive power or one is better

### for breeding as target variable a glmer was calculated with binomial distribution

mod_drone_breeding_REffect
mod_flight_breeding_REffect


model_performance(mod_drone_breeding_REffect)
model_performance(mod_flight_breeding_REffect)


### for juvenile as target variable a glmmTMB was calculated with a negative binomial distribution,
### because glmer does not work for quasipoisson distributions
mod_drone_juvenile2024_REffect
mod_flight_juvenile2024_REffect

model_performance(mod_drone_juvenile2024_REffect)
model_performance(mod_flight_juvenile2024_REffect)

r2(mod_drone_juvenile2024_REffect, tolerance = 0)
r2(mod_flight_juvenile2024_REffect, tolerance = 0)

################################################################################

compare_performance(mod_drone_breeding_REffect, mod_flight_breeding_REffect,
                    mod_drone_juvenile2024_REffect, mod_flight_juvenile2024_REffect
                   # ,rank = TRUE
                    )
################################################################################

#j) Result interpretation


?compare_performance

################################################################################
################################################################################
################################################################################
################################################################################
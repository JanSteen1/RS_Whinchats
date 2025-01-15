# Remote sensing of grassland habitat parameters to assess whinchat breeding grounds

This repository contains the R-scripts used in the master thesis "Remote sensing of grassland habitat parameters to assess whinchat breeding grounds" by Jan Steen. 

The project should be opened via [RS_Whinchats.Rproj](RS_Whinchats.Rproj) to ensure the proper relative file paths. 
Following contents can be found in the repository:

- [data:](data) Contains the mastertable with all variables necessary to run the statistical analysis and generate the respective plots
- [script:](script) Contains all R-scripts written for this thesis
  + script 01 - 03 are used for processing the official aerial survey data which can be downloaded here: https://gds.hessen.de/ The data used in the thesis was downloaded on 03.05.2024
  + script 04 - 10 are used for processing the drone data and calculating additional variables. The drone flights were conducted using a L1 LiDAR sensor mounted on a DJI Matrice 300 RTK drone between 27.-29.05.2024
  + script 11 - 13 contain the statistical analysis of the data and generate the respective plots

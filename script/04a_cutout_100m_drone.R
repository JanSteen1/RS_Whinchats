library(lidR)
library(lasR)

### cut out a 100 m radius for each plot and create a new las file 
### write out

################################################################################

coords <- read.csv2("data/mastertable.csv")
coords$Lon[[1]]
### only one decimal place or none for Lat...
### therefore: Copy exact coordinates from CSV table


################################################################################
# f <- file.path("data", "02_las_files", "")
# read = reader_las_circles(lon , lat , 100)
# write = write_las("data/03_las_cropped/...")
# pipeline = read + write
# ans = exec(pipeline, on = f)

################################################################################
### 1 Eisenbach - Solarpark  
f <- file.path("data", "02_las_files", "1_2_Eisenbach_Solarpark.las")
read = reader_las_circles(525890.78, 5604575.92, 100)
write = write_las("data/03_las_cropped/01_Eisenbach_Solarpark.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 2 Eisenbach - Solarpark
f <- file.path("data", "02_las_files", "1_2_Eisenbach_Solarpark.las")
read = reader_las_circles(526108.15, 5604666.83, 100)
write = write_las("data/03_las_cropped/02_Eisenbach_Solarpark.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 3 Crainfeld - Lüderaue 
f <- file.path("data", "02_las_files", "3_4_Crainfeld_Luederaue.las")
read = reader_las_circles(525850.47, 5592973.44, 100)
write = write_las("data/03_las_cropped/03_Crainfeld_Luederaue.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 4 Crainfeld - Lüderaue
f <- file.path("data", "02_las_files", "3_4_Crainfeld_Luederaue.las")
read = reader_las_circles(525861.47, 5593106.32, 100)
write = write_las("data/03_las_cropped/04_Crainfeld_Luederaue.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 5 Crainfeld - Lüderaue 2
f <- file.path("data", "02_las_files", "5_6_Crainfeld_Luederaue_2.las")
read = reader_las_circles(526270.05, 5593614.93, 100)
write = write_las("data/03_las_cropped/05_Crainfeld_Luederaue_2.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 6 Crainfeld - Lüderaue 2
f <- file.path("data", "02_las_files", "5_6_Crainfeld_Luederaue_2.las")
read = reader_las_circles(526432.58, 5593779.15, 100)
write = write_las("data/03_las_cropped/06_Crainfeld_Luederaue_2.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 7 Grebenhain - Waaggraben
f <- file.path("data", "02_las_files", "7_8_Grebenhain_Waaggraben.las")
read = reader_las_circles(524727.01, 5593048.18, 100)
write = write_las("data/03_las_cropped/07_Grebenhain_Waaggraben.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 8 Grebenhain - Waaggraben
f <- file.path("data", "02_las_files", "7_8_Grebenhain_Waaggraben.las")
read = reader_las_circles(524559.77, 5592900.68, 100)
write = write_las("data/03_las_cropped/08_Grebenhain_Waaggraben.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 9 Kirchvers    
f <- file.path("data", "02_las_files", "9_10_Kirchvers.las")
read = reader_las_circles(471859.75, 5614997.41, 100)
write = write_las("data/03_las_cropped/09_Kirchvers.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 10 Kirchvers
f <- file.path("data", "02_las_files", "9_10_Kirchvers.las")
read = reader_las_circles(471820.52, 5614792.65, 100)
write = write_las("data/03_las_cropped/10_Kirchvers.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 11 Niederasphe
f <- file.path("data", "02_las_files", "11_12_Niederasphe.las")
read = reader_las_circles(477202.78, 5644912.89, 100)
write = write_las("data/03_las_cropped/11_Niederasphe.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 12 Niederasphe   
f <- file.path("data", "02_las_files", "11_12_Niederasphe.las")
read = reader_las_circles(477454.28, 5644914.53, 100)
write = write_las("data/03_las_cropped/12_Niederasphe.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 13 Ober- und Niederhoerlen
f <- file.path("data", "02_las_files", "13_14_Ober_Niederhoerlen.las")
read = reader_las_circles(460021.14, 5632265.34, 100)
write = write_las("data/03_las_cropped/13_Ober_Niederhoerlen.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 14 Ober- und Niederhoerlen
f <- file.path("data", "02_las_files", "13_14_Ober_Niederhoerlen.las")
read = reader_las_circles(460004.20, 5632447.79, 100)
write = write_las("data/03_las_cropped/14_Ober_Niederhoerlen.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 15 Oberdieten
f <- file.path("data", "02_las_files", "15_16_Oberdieten.las")
read = reader_las_circles(457582.96, 5633736.08, 100)
write = write_las("data/03_las_cropped/15_Oberdieten.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 16 Oberdieten
f <- file.path("data", "02_las_files", "15_16_Oberdieten.las")
read = reader_las_circles(457777.75, 5633718.22, 100)
write = write_las("data/03_las_cropped/16_Oberdieten.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 17 Driedorf: Münchhausen - Ost
f <- file.path("data", "02_las_files", "17_18_Driedorf_Muenchhausen_Ost.las")
read = reader_las_circles(443925.72, 5607431.57, 100)
write = write_las("data/03_las_cropped/17_Driedorf_Muenchhausen_Ost.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 18 Driedorf: Münchhausen - Ost  
f <- file.path("data", "02_las_files", "17_18_Driedorf_Muenchhausen_Ost.las")
read = reader_las_circles(443892.84, 5607585.24, 100)
write = write_las("data/03_las_cropped/18_Driedorf_Muenchhausen_Ost.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 19 Driedorf: Münchhausen - West
f <- file.path("data", "02_las_files", "19_20_Driedorf_Muenchhausen_West.las")
read = reader_las_circles(442233.52, 5607655.45, 100)
write = write_las("data/03_las_cropped/19_Driedorf_Muenchhausen_West.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 20 Driedorf: Münchhausen - West
f <- file.path("data", "02_las_files", "19_20_Driedorf_Muenchhausen_West.las")
read = reader_las_circles(442112.93, 5607763.56, 100)
write = write_las("data/03_las_cropped/20_Driedorf_Muenchhausen_West.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 21 Driedorf: Mademühlen - Süd 1  
f <- file.path("data", "02_las_files", "21_22_Driedorf_Mademuehlen_Sued_1.las")
read = reader_las_circles(441115.55, 5606644.46, 100)
write = write_las("data/03_las_cropped/21_Driedorf_Mademuehlen_Sued_1.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 22 Driedorf: Mademühlen - Süd 1
f <- file.path("data", "02_las_files", "21_22_Driedorf_Mademuehlen_Sued_1.las")
read = reader_las_circles(441269.03, 5606721.20, 100)
write = write_las("data/03_las_cropped/22_Driedorf_Mademuehlen_Sued_1.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 23 Driedorf: Mademühlen - Süd 2
f <- file.path("data", "02_las_files", "23_24_Driedorf_Mademuehlen_Sued_2.las")
read = reader_las_circles(440764.51, 5607370.72, 100)
write = write_las("data/03_las_cropped/23_Driedorf_Mademuehlen_Sued_2.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 24 Driedorf: Mademühlen - Süd 2  
f <- file.path("data", "02_las_files", "23_24_Driedorf_Mademuehlen_Sued_2.las")
read = reader_las_circles(440909.66, 5607352.62, 100)
write = write_las("data/03_las_cropped/24_Driedorf_Mademuehlen_Sued_2.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 25 Driedorf: Mademühlen - Süd 3
f <- file.path("data", "02_las_files", "25_Driedorf_Mademuehlen_Sued_3_1.las")
read = reader_las_circles(439909.29, 5606875.54, 100)
write = write_las("data/03_las_cropped/25_Driedorf_Mademuehlen_Sued_3.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 26 Driedorf: Mademühlen - Süd 3
f <- file.path("data", "02_las_files", "26_Driedorf_Mademuehlen_Sued_3_2.las")
read = reader_las_circles(440397.77, 5606809.39, 100)
write = write_las("data/03_las_cropped/26_Driedorf_Mademuehlen_Sued_3.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 27 Hohenroth: Aue           
f <- file.path("data", "02_las_files", "27_28_Hohenroth_Aue.las")
read = reader_las_circles(439099.32, 5609606.61, 100)
write = write_las("data/03_las_cropped/27_Hohenroth_Aue.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 28 Hohenroth: Aue
f <- file.path("data", "02_las_files", "27_28_Hohenroth_Aue.las")
read = reader_las_circles(439163.49, 5609749.96, 100)
write = write_las("data/03_las_cropped/28_Hohenroth_Aue.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 29 Hohenahr: Altenkirchen
f <- file.path("data", "02_las_files", "29_30_Hohenahr_Altenkirchen.las")
read = reader_las_circles(461274.25, 5613335.57, 100)
write = write_las("data/03_las_cropped/29_Hohenahr_Altenkirchen.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 30 Hohenahr: Altenkirchen      
f <- file.path("data", "02_las_files", "29_30_Hohenahr_Altenkirchen.las")
read = reader_las_circles(461053.95, 5613375.32, 100)
write = write_las("data/03_las_cropped/30_Hohenahr_Altenkirchen.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 31 Hohenahr: Stadterbach
f <- file.path("data", "02_las_files", "31_32_Hohenahr_Stadterbach.las")
read = reader_las_circles(463643.23, 5612671.06, 100)
write = write_las("data/03_las_cropped/31_Hohenahr_Stadterbach.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 32 Hohenahr: Stadterbach
f <- file.path("data", "02_las_files", "31_32_Hohenahr_Stadterbach.las")
read = reader_las_circles(463586.96, 5612545.85, 100)
write = write_las("data/03_las_cropped/32_Hohenahr_Stadterbach.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 33 Hohenahr: Hollerbach-Seitental
f <- file.path("data", "02_las_files", "33_34_Hohenahr_Hollerbach_Seitental.las")
read = reader_las_circles(464392.07, 5612957.61, 100)
write = write_las("data/03_las_cropped/33_Hohenahr_Hollerbach_Seitental.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 34 Hohenahr: Hollerbach-Seitental
f <- file.path("data", "02_las_files", "33_34_Hohenahr_Hollerbach_Seitental.las")
read = reader_las_circles(464446.81, 5612859.99, 100)
write = write_las("data/03_las_cropped/34_Hohenahr_Hollerbach_Seitental.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 35 Hohenahr: Erdaer Kreuz
f <- file.path("data", "02_las_files", "35_36_Hohenahr_Erdaer_Kreuz.las")
read = reader_las_circles(465274.76, 5613145.65, 100)
write = write_las("data/03_las_cropped/35_Hohenahr_Erdaer_Kreuz.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 36 Hohenahr: Erdaer Kreuz        
f <- file.path("data", "02_las_files", "35_36_Hohenahr_Erdaer_Kreuz.las")
read = reader_las_circles(465494.89, 5613189.84, 100)
write = write_las("data/03_las_cropped/36_Hohenahr_Erdaer_Kreuz.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 37 Hohenahr: Wilsbach-Pferdeweide
f <- file.path("data", "02_las_files", "37_38_Hohenahr_Wilsbach_Pferdeweide.las")
read = reader_las_circles(467391.95, 5616978.25, 100)
write = write_las("data/03_las_cropped/37_Hohenahr_Wilsbach_Pferdeweide.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 38 Hohenahr: Wilsbach-Pferdeweide
f <- file.path("data", "02_las_files", "37_38_Hohenahr_Wilsbach_Pferdeweide.las")
read = reader_las_circles(467425.28, 5617121.65, 100)
write = write_las("data/03_las_cropped/38_Hohenahr_Wilsbach_Pferdeweide.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 39 Hohenahr: Wilsbach-Rinderweide
f <- file.path("data", "02_las_files", "39_40_Hohenahr_Wilsbach_Rinderweide.las")
read = reader_las_circles(467814.67, 5616873.62, 100)
write = write_las("data/03_las_cropped/39_Hohenahr_Wilsbach_Rinderweide.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 40 Hohenahr: Wilsbach-Rinderweide
f <- file.path("data", "02_las_files", "39_40_Hohenahr_Wilsbach_Rinderweide.las")
read = reader_las_circles(467702.08, 5616880.80, 100)
write = write_las("data/03_las_cropped/40_Hohenahr_Wilsbach_Rinderweide.las")
pipeline = read + write
ans = exec(pipeline, on = f)

################################################################################

#### All 40 plots are cut out and saved individually!









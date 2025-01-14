library(lidR)
library(lasR)



###Problem: evaluation by the planning office is carried out on 5 x 5 metres, i.e.
### 25 m^2. calculate the corner points for all plots and then cut them out

### Calculation of the perches is then carried out on the new 25 sqm plots


################################################################################

################################################################################
# f <- file.path("data", "05_las_normalised", "")
# read = reader_las_rectangles(lon , lat , 10)
# write = write_las("data/07_25sqm_normalised/...")
# pipeline = read + write
# ans = exec(pipeline, on = f)

################################################################################
### 1 Eisenbach - Solarpark  
f <- file.path("data", "05_las_normalised", "01_Eisenbach_Solarpark_normalised.las")
read = reader_las_rectangles(525890.78 - 2.5, 5604575.92 -2.5, 525890.78 + 2.5, 5604575.92 + 2.5)
write = write_las("data/07_25sqm_normalised/01_Eisenbach_Solarpark_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 2 Eisenbach - Solarpark
f <- file.path("data", "05_las_normalised", "02_Eisenbach_Solarpark_normalised.las")
read = reader_las_rectangles(526108.15 - 2.5, 5604666.83 - 2.5, 526108.15 + 2.5, 5604666.83 + 2.5)
write = write_las("data/07_25sqm_normalised/02_Eisenbach_Solarpark_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 3 Crainfeld - Lüderaue 
f <- file.path("data", "05_las_normalised", "03_Crainfeld_Luederaue_normalised.las")
read = reader_las_rectangles(525850.47 - 2.5, 5592973.44 - 2.5, 525850.47 + 2.5, 5592973.44 + 2.5)
write = write_las("data/07_25sqm_normalised/03_Crainfeld_Luederaue_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 4 Crainfeld - Lüderaue
f <- file.path("data", "05_las_normalised", "04_Crainfeld_Luederaue_normalised.las")
read = reader_las_rectangles(525861.47 - 2.5, 5593106.32 - 2.5, 525861.47 + 2.5, 5593106.32 + 2.5)
write = write_las("data/07_25sqm_normalised/04_Crainfeld_Luederaue_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 5 Crainfeld - Lüderaue 2
f <- file.path("data", "05_las_normalised", "05_Crainfeld_Luederaue_2_normalised.las")
read = reader_las_rectangles(526270.05 - 2.5, 5593614.93 - 2.5, 526270.05 + 2.5, 5593614.93 + 2.5)
write = write_las("data/07_25sqm_normalised/05_Crainfeld_Luederaue_2_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 6 Crainfeld - Lüderaue 2
f <- file.path("data", "05_las_normalised", "06_Crainfeld_Luederaue_2_normalised.las")
read = reader_las_rectangles(526432.58 - 2.5, 5593779.15 - 2.5, 526432.58 + 2.5, 5593779.15 + 2.5)
write = write_las("data/07_25sqm_normalised/06_Crainfeld_Luederaue_2_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 7 Grebenhain - Waaggraben
f <- file.path("data", "05_las_normalised", "07_Grebenhain_Waaggraben_normalised.las")
read = reader_las_rectangles(524727.01 - 2.5, 5593048.18 - 2.5, 524727.01 + 2.5, 5593048.18 + 2.5)
write = write_las("data/07_25sqm_normalised/07_Grebenhain_Waaggraben_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 8 Grebenhain - Waaggraben
f <- file.path("data", "05_las_normalised", "08_Grebenhain_Waaggraben_normalised.las")
read = reader_las_rectangles(524559.77 - 2.5, 5592900.68 - 2.5, 524559.77 + 2.5, 5592900.68 + 2.5)
write = write_las("data/07_25sqm_normalised/08_Grebenhain_Waaggraben_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 9 Kirchvers    
f <- file.path("data", "05_las_normalised", "09_Kirchvers_normalised.las")
read = reader_las_rectangles(471859.75 - 2.5, 5614997.41 - 2.5, 471859.75 + 2.5, 5614997.41 + 2.5)
write = write_las("data/07_25sqm_normalised/09_Kirchvers_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 10 Kirchvers
f <- file.path("data", "05_las_normalised", "10_Kirchvers_normalised.las")
read = reader_las_rectangles(471820.52 - 2.5, 5614792.65 - 2.5, 471820.52 + 2.5, 5614792.65 + 2.5)
write = write_las("data/07_25sqm_normalised/10_Kirchvers_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 11 Niederasphe
f <- file.path("data", "05_las_normalised", "11_Niederasphe_normalised.las")
read = reader_las_rectangles(477202.78 - 2.5, 5644912.89 - 2.5, 477202.78 + 2.5, 5644912.89 + 2.5)
write = write_las("data/07_25sqm_normalised/11_Niederasphe_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 12 Niederasphe   
f <- file.path("data", "05_las_normalised", "12_Niederasphe_normalised.las")
read = reader_las_rectangles(477454.28 - 2.5, 5644914.53 - 2.5, 477454.28 + 2.5, 5644914.53 + 2.5)
write = write_las("data/07_25sqm_normalised/12_Niederasphe_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 13 Ober- und Niederhoerlen
f <- file.path("data", "05_las_normalised", "13_Ober_Niederhoerlen_normalised.las")
read = reader_las_rectangles(460021.14 - 2.5, 5632265.34 - 2.5, 460021.14 + 2.5, 5632265.34 + 2.5)
write = write_las("data/07_25sqm_normalised/13_Ober_Niederhoerlen_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 14 Ober- und Niederhoerlen
f <- file.path("data", "05_las_normalised", "14_Ober_Niederhoerlen_normalised.las")
read = reader_las_rectangles(460004.20 - 2.5, 5632447.79 - 2.5, 460004.20 + 2.5, 5632447.79 + 2.5)
write = write_las("data/07_25sqm_normalised/14_Ober_Niederhoerlen_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 15 Oberdieten
f <- file.path("data", "05_las_normalised", "15_Oberdieten_normalised.las")
read = reader_las_rectangles(457582.96 - 2.5, 5633736.08 - 2.5, 457582.96 + 2.5, 5633736.08 + 2.5)
write = write_las("data/07_25sqm_normalised/15_Oberdieten_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 16 Oberdieten
f <- file.path("data", "05_las_normalised", "16_Oberdieten_normalised.las")
read = reader_las_rectangles(457777.75 - 2.5, 5633718.22 - 2.5, 457777.75 + 2.5, 5633718.22 + 2.5)
write = write_las("data/07_25sqm_normalised/16_Oberdieten_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 17 Driedorf: Münchhausen - Ost
f <- file.path("data", "05_las_normalised", "17_Driedorf_Muenchhausen_Ost_normalised.las")
read = reader_las_rectangles(443925.72 - 2.5, 5607431.57 - 2.5, 443925.72 + 2.5, 5607431.57 + 2.5)
write = write_las("data/07_25sqm_normalised/17_Driedorf_Muenchhausen_Ost_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 18 Driedorf: Münchhausen - Ost  
f <- file.path("data", "05_las_normalised", "18_Driedorf_Muenchhausen_Ost_normalised.las")
read = reader_las_rectangles(443892.84 - 2.5, 5607585.24 - 2.5, 443892.84 + 2.5, 5607585.24 + 2.5)
write = write_las("data/07_25sqm_normalised/18_Driedorf_Muenchhausen_Ost_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 19 Driedorf: Münchhausen - West
f <- file.path("data", "05_las_normalised", "19_Driedorf_Muenchhausen_West_normalised.las")
read = reader_las_rectangles(442233.52 - 2.5, 5607655.45 - 2.5, 442233.52 + 2.5, 5607655.45 + 2.5)
write = write_las("data/07_25sqm_normalised/19_Driedorf_Muenchhausen_West_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 20 Driedorf: Münchhausen - West
f <- file.path("data", "05_las_normalised", "20_Driedorf_Muenchhausen_West_normalised.las")
read = reader_las_rectangles(442112.93 - 2.5, 5607763.56 - 2.5, 442112.93 + 2.5, 5607763.56 + 2.5)
write = write_las("data/07_25sqm_normalised/20_Driedorf_Muenchhausen_West_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 21 Driedorf: Mademühlen - Süd 1  
f <- file.path("data", "05_las_normalised", "21_Driedorf_Mademuehlen_Sued_1_normalised.las")
read = reader_las_rectangles(441115.55 - 2.5, 5606644.46 - 2.5, 441115.55 + 2.5, 5606644.46 + 2.5)
write = write_las("data/07_25sqm_normalised/21_Driedorf_Mademuehlen_Sued_1_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 22 Driedorf: Mademühlen - Süd 1
f <- file.path("data", "05_las_normalised", "22_Driedorf_Mademuehlen_Sued_1_normalised.las")
read = reader_las_rectangles(441269.03 - 2.5, 5606721.20 - 2.5, 441269.03 + 2.5, 5606721.20 + 2.5)
write = write_las("data/07_25sqm_normalised/22_Driedorf_Mademuehlen_Sued_1_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 23 Driedorf: Mademühlen - Süd 2
f <- file.path("data", "05_las_normalised", "23_Driedorf_Mademuehlen_Sued_2_normalised.las")
read = reader_las_rectangles(440764.51 - 2.5, 5607370.72 - 2.5, 440764.51 + 2.5, 5607370.72 + 2.5)
write = write_las("data/07_25sqm_normalised/23_Driedorf_Mademuehlen_Sued_2_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 24 Driedorf: Mademühlen - Süd 2  
f <- file.path("data", "05_las_normalised", "24_Driedorf_Mademuehlen_Sued_2_normalised.las")
read = reader_las_rectangles(440909.66 - 2.5, 5607352.62 - 2.5, 440909.66 + 2.5, 5607352.62 + 2.5)
write = write_las("data/07_25sqm_normalised/24_Driedorf_Mademuehlen_Sued_2_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 25 Driedorf: Mademühlen - Süd 3
f <- file.path("data", "05_las_normalised", "25_Driedorf_Mademuehlen_Sued_3_normalised.las")
read = reader_las_rectangles(439909.29 - 2.5, 5606875.54 - 2.5, 439909.29 + 2.5, 5606875.54 + 2.5)
write = write_las("data/07_25sqm_normalised/25_Driedorf_Mademuehlen_Sued_3_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 26 Driedorf: Mademühlen - Süd 3
f <- file.path("data", "05_las_normalised", "26_Driedorf_Mademuehlen_Sued_3_normalised.las")
read = reader_las_rectangles(440397.77 - 2.5, 5606809.39 - 2.5, 440397.77 + 2.5, 5606809.39 + 2.5)
write = write_las("data/07_25sqm_normalised/26_Driedorf_Mademuehlen_Sued_3_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 27 Hohenroth: Aue           
f <- file.path("data", "05_las_normalised", "27_Hohenroth_Aue_normalised.las")
read = reader_las_rectangles(439099.32 - 2.5, 5609606.61 - 2.5, 439099.32 + 2.5, 5609606.61 + 2.5)
write = write_las("data/07_25sqm_normalised/27_Hohenroth_Aue_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 28 Hohenroth: Aue
f <- file.path("data", "05_las_normalised", "28_Hohenroth_Aue_normalised.las")
read = reader_las_rectangles(439163.49 - 2.5, 5609749.96 - 2.5, 439163.49 + 2.5, 5609749.96 + 2.5)
write = write_las("data/07_25sqm_normalised/28_Hohenroth_Aue_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 29 Hohenahr: Altenkirchen
f <- file.path("data", "05_las_normalised", "29_Hohenahr_Altenkirchen_normalised.las")
read = reader_las_rectangles(461274.25 - 2.5, 5613335.57 - 2.5, 461274.25 + 2.5, 5613335.57 + 2.5)
write = write_las("data/07_25sqm_normalised/29_Hohenahr_Altenkirchen_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 30 Hohenahr: Altenkirchen      
f <- file.path("data", "05_las_normalised", "30_Hohenahr_Altenkirchen_normalised.las")
read = reader_las_rectangles(461053.95 - 2.5, 5613375.32 - 2.5, 461053.95 + 2.5, 5613375.32 + 2.5)
write = write_las("data/07_25sqm_normalised/30_Hohenahr_Altenkirchen_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 31 Hohenahr: Stadterbach
f <- file.path("data", "05_las_normalised", "31_Hohenahr_Stadterbach_normalised.las")
read = reader_las_rectangles(463643.23 - 2.5, 5612671.06 - 2.5, 463643.23 + 2.5, 5612671.06 + 2.5)
write = write_las("data/07_25sqm_normalised/31_Hohenahr_Stadterbach_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 32 Hohenahr: Stadterbach
f <- file.path("data", "05_las_normalised", "32_Hohenahr_Stadterbach_normalised.las")
read = reader_las_rectangles(463586.96 - 2.5, 5612545.85 - 2.5, 463586.96 + 2.5, 5612545.85 + 2.5)
write = write_las("data/07_25sqm_normalised/32_Hohenahr_Stadterbach_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 33 Hohenahr: Hollerbach-Seitental
f <- file.path("data", "05_las_normalised", "33_Hohenahr_Hollerbach_Seitental_normalised.las")
read = reader_las_rectangles(464392.07 - 2.5, 5612957.61 - 2.5, 464392.07 + 2.5, 5612957.61 + 2.5)
write = write_las("data/07_25sqm_normalised/33_Hohenahr_Hollerbach_Seitental_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 34 Hohenahr: Hollerbach-Seitental
f <- file.path("data", "05_las_normalised", "34_Hohenahr_Hollerbach_Seitental_normalised.las")
read = reader_las_rectangles(464446.81 - 2.5, 5612859.99 - 2.5, 464446.81 + 2.5, 5612859.99 + 2.5)
write = write_las("data/07_25sqm_normalised/34_Hohenahr_Hollerbach_Seitental_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 35 Hohenahr: Erdaer Kreuz
f <- file.path("data", "05_las_normalised", "35_Hohenahr_Erdaer_Kreuz_normalised.las")
read = reader_las_rectangles(465274.76 - 2.5, 5613145.65 - 2.5, 465274.76 + 2.5, 5613145.65 + 2.5)
write = write_las("data/07_25sqm_normalised/35_Hohenahr_Erdaer_Kreuz_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 36 Hohenahr: Erdaer Kreuz        
f <- file.path("data", "05_las_normalised", "36_Hohenahr_Erdaer_Kreuz_normalised.las")
read = reader_las_rectangles(465494.89 - 2.5, 5613189.84 - 2.5, 465494.89 + 2.5, 5613189.84 + 2.5)
write = write_las("data/07_25sqm_normalised/36_Hohenahr_Erdaer_Kreuz_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 37 Hohenahr: Wilsbach-Pferdeweide
f <- file.path("data", "05_las_normalised", "37_Hohenahr_Wilsbach_Pferdeweide_normalised.las")
read = reader_las_rectangles(467391.95 - 2.5, 5616978.25 - 2.5, 467391.95 + 2.5, 5616978.25 + 2.5)
write = write_las("data/07_25sqm_normalised/37_Hohenahr_Wilsbach_Pferdeweide_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 38 Hohenahr: Wilsbach-Pferdeweide
f <- file.path("data", "05_las_normalised", "38_Hohenahr_Wilsbach_Pferdeweide_normalised.las")
read = reader_las_rectangles(467425.28 - 2.5, 5617121.65 - 2.5, 467425.28 + 2.5, 5617121.65 + 2.5)
write = write_las("data/07_25sqm_normalised/38_Hohenahr_Wilsbach_Pferdeweide_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 39 Hohenahr: Wilsbach-Rinderweide
f <- file.path("data", "05_las_normalised", "39_Hohenahr_Wilsbach_Rinderweide_normalised.las")
read = reader_las_rectangles(467814.67 - 2.5, 5616873.62 - 2.5, 467814.67 + 2.5, 5616873.62 + 2.5)
write = write_las("data/07_25sqm_normalised/39_Hohenahr_Wilsbach_Rinderweide_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)


### 40 Hohenahr: Wilsbach-Rinderweide
f <- file.path("data", "05_las_normalised", "40_Hohenahr_Wilsbach_Rinderweide_normalised.las")
read = reader_las_rectangles(467702.08 - 2.5, 5616880.80 - 2.5, 467702.08 + 2.5, 5616880.80 + 2.5)
write = write_las("data/07_25sqm_normalised/40_Hohenahr_Wilsbach_Rinderweide_25sqm.las")
pipeline = read + write
ans = exec(pipeline, on = f)

################################################################################

#### All 40 plots are cut out and saved individually




library(sf)
library(tmap)
library(skimr)
library(visdat)
library(lubridate) # for as_date()
library(tidyverse)
library(viridis)
library(ggrepel)
library(ggspatial)
library(ggpubr)
library(xlsx)
library(s2)
library(tiff)
library(raster)
library(terra)
library(tidyterra)
library(dplyr)
library(ordinal)
library(emmeans)
library(gridExtra)

```

## Climate change mapping data
This script:    
  i) reads in, explores data provided by Craig Nitchke looking at climate change projections.  
ii) ....

```{Loading data and shp files, r warning=FALSE}
MW_bound <- terra::vect("~/uomShare/wergProj/VegVisions/Mapping/MW Catchments/HWS_Catchments2.shp")
Al.vertCC90.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/AllVer_CC_90.tif")
Al.vert.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/AllVer.tif")
Al.vertCC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_AllVert_CC.tif")
Al.vert.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_AllVert.tif")
Ga.siebCC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_GaSieb_CC.tif")
Ga.siebCC90.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/GahSei_CC_90.tif")
Ga.sieb.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_GaSieb.tif")
Ga.sieb.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/GahSei.tif")
plot(Al.vertCC90.taca)
plot(Al.vert.sdm)
origin(Al.vertCC90.taca)
#Al.vert.sdm_ext = resample(Al.vert.sdm, Al.vertCC90.taca)
diff_Al.vert_MW = Al.vert.taca - Al.vertCC90.taca
table(values(diff_Al.vert_MW))
plot(diff_Al.vert_MW)

Al.vert_CCsdm <- ggplot() +
  geom_spatraster(data = Al.vertCC90.sdm)+
  scale_fill_terrain_c(direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Allocasuarina verticillata 2090 climate SDM")

Al.vert_sdm <- ggplot() +
  geom_spatraster(data = Al.vert.sdm)+
  scale_fill_terrain_c(direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Allocasuarina verticillata current climate SDM")

Al.vert_CCtaca <- ggplot() +
  geom_spatraster(data = Al.vertCC90.taca)+
  scale_fill_terrain_c(direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Allocasuarina verticillata 2090 climate TACA")

Al.vert_taca <- ggplot() +
  geom_spatraster(data = Al.vert.taca)+
  scale_fill_terrain_c(direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Allocasuarina verticillata current climate TACA")

diff_Al.vert_MW_taca = Al.vert.taca - Al.vertCC90.taca
Al.vert_Diff_taca <- ggplot() +
  geom_spatraster(data = diff_Al.vert_MW_taca)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = 1, limits=c(),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Allocasuarina verticillata Taca model difference")

diff_Al.vert_MW_SDM = Al.vert.sdm - Al.vertCC90.sdm
Al.vert_Diff_sdm <- ggplot() +
  geom_spatraster(data = diff_Al.vert_MW_SDM)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = 1, limits=c(),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Allocasuarina verticillata SDM model difference")

grid.arrange(Al.vert_sdm, Al.vert_taca, Al.vert_CCsdm, Al.vert_CCtaca, Al.vert_Diff_sdm, Al.vert_Diff_taca, nrow = 3)

Ga.sieb_CCsdm <- ggplot() +
  geom_spatraster(data = Ga.siebCC90.sdm)+
  scale_fill_terrain_c(direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Gahnia sieberiana 2090 climate SDM")

Ga.sieb_sdm <- ggplot() +
  geom_spatraster(data = Ga.sieb.sdm)+
  scale_fill_terrain_c(direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Gahnia sieberiana current climate SDM")

Ga.sieb_CCtaca <- ggplot() +
  geom_spatraster(data = Ga.siebCC90.taca)+
  scale_fill_terrain_c(direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Gahnia sieberiana 2090 climate TACA")

Ga.sieb_taca <- ggplot() +
  geom_spatraster(data = Ga.sieb.taca)+
  scale_fill_terrain_c(direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Gahnia sieberiana current climate TACA")

diff_Ga.sieb_MW_taca = Ga.sieb.taca - Ga.siebCC90.taca
Ga.sieb_Diff_taca <- ggplot() +
  geom_spatraster(data = diff_Ga.sieb_MW_taca)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = 1, limits=c(),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Gahnia sieberiana TACA model difference")

diff_Ga.sieb_MW_sdm = Ga.sieb.sdm - Ga.siebCC90.sdm
Ga.sieb_Diff_sdm <- ggplot() +
  geom_spatraster(data = diff_Ga.sieb_MW_sdm)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = 1, limits=c(),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Gahnia sieberiana SDM model difference")

grid.arrange(Ga.sieb_sdm, Ga.sieb_taca, Ga.sieb_CCsdm, Ga.sieb_CCtaca, Ga.sieb_Diff_sdm, Ga.sieb_Diff_taca, nrow = 3)

Ga.sieb_Diff_sdm <- ggplot() +
  geom_spatraster(data = diff_Ga.sieb_MW_sdm)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = 1, limits=c())+
  geom_spatraster(data = diff_Ga.sieb_MW_taca)+
  scale_fill_terrain_c()

  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = 1, limits=c(),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Gahnia sieberiana SDM model difference")


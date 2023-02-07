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
Al.vertCC90.taca_reproj <- terra::project(Al.vertCC90.taca,crs(MW_bound))
Al.vert.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/AllVer.tif")
Al.vert.taca_reproj <- terra::project(Al.vert.taca,crs(MW_bound))
Al.vertCC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_AllVert_CC.tif")
Al.vertCC90.sdm_reproj <- terra::project(Al.vertCC90.sdm,crs(MW_bound))
Ga.siebCC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_GaSieb_CC.tif")
Ga.siebCC90.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/GahSei_CC_90.tif")
plot(Al.vertCC90.taca)
plot(Al.vert.taca)

Al.vert_sdm <- ggplot() +
  geom_spatraster(data = Al.vertCC90.sdm_reproj)+
  scale_fill_whitebox_c(
    palette = "deep", direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate niche (SDM)")

Al.vert_taca <- ggplot() +
  geom_spatraster(data = Al.vertCC90.taca_reproj)+
  scale_fill_whitebox_c(
    palette = "deep", direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate niche (TACA)")

grid.arrange(Al.vert_sdm, Al.vert_taca, nrow = 1)

Ga.sieb_sdm <- ggplot() +
  geom_spatraster(data = Ga.siebCC90.sdm)+
  scale_fill_whitebox_c(
    palette = "deep", direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate niche (SDM)")

Ga.sieb_taca <- ggplot() +
  geom_spatraster(data = Ga.siebCC90.taca)+
  scale_fill_whitebox_c(
    palette = "deep", direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate niche (TACA)")

grid.arrange(Ga.sieb_sdm, Ga.sieb_taca, nrow = 1)


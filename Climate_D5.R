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
Al.vertCC90.sdm_ext = resample(Al.vertCC90.sdm, Al.vertCC90.taca)
diff_CCtaca_CCSDM = Al.vertCC90.taca - Al.vertCC90.sdm_ext
table(values(fdiff))
plot(diff)
plot(fdiff)

Al.vert_CCsdm <- ggplot() +
  geom_spatraster(data = Al.vertCC90.sdm)+
  scale_fill_terrain_c(direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate niche", title = "Allocasuarina verticillata 2090 climate SDM")

Al.vert_sdm <- ggplot() +
  geom_spatraster(data = Al.vert.sdm)+
  scale_fill_terrain_c(direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate niche", title = "Allocasuarina verticillata current climate SDM")

Al.vert_CCtaca <- ggplot() +
  geom_spatraster(data = Al.vertCC90.taca)+
  scale_fill_terrain_c(direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate niche", title = "Allocasuarina verticillata 2090 climate TACA")

Al.vert_taca <- ggplot() +
  geom_spatraster(data = Al.vert.taca)+
  scale_fill_terrain_c(direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate niche", title = "Allocasuarina verticillata current climate TACA")

Al.vertCC90.sdm_ext = resample(Al.vertCC90.sdm, Al.vertCC90.taca)
diff_CCtaca_CCSDM = Al.vertCC90.taca - Al.vertCC90.sdm_ext
table(values(diff_CCtaca_CCSDM))

Al.vert_Diff_CC <- ggplot() +
  geom_spatraster(data = diff_CCtaca_CCSDM)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate niche", title = "Allocasuarina verticillata 2090 model difference")

Al.vert.sdm_ext = resample(Al.vert.sdm, Al.vert.taca)
diff_taca_SDM = Al.vert.taca - Al.vert.sdm_ext

Al.vert_Diff_current <- ggplot() +
  geom_spatraster(data = diff_taca_SDM)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate niche", title = "Allocasuarina verticillata current model difference")

grid.arrange(Al.vert_sdm, Al.vert_CCsdm, Al.vert_taca, Al.vert_CCtaca, Al.vert_Diff_current, Al.vert_Diff_CC, nrow = 3)

Ga.sieb_CCsdm <- ggplot() +
  geom_spatraster(data = Ga.siebCC90.sdm)+
  scale_fill_terrain_c(direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate niche", title = "Gahnia sieberiana 2090 climate SDM")

Ga.sieb_sdm <- ggplot() +
  geom_spatraster(data = Ga.sieb.sdm)+
  scale_fill_terrain_c(direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate niche", title = "Gahnia sieberiana current climate SDM")

Ga.sieb_CCtaca <- ggplot() +
  geom_spatraster(data = Ga.siebCC90.taca)+
  scale_fill_terrain_c(direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate niche", title = "Gahnia sieberiana 2090 climate TACA")

Ga.sieb_taca <- ggplot() +
  geom_spatraster(data = Ga.sieb.taca)+
  scale_fill_terrain_c(direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate niche", title = "Gahnia sieberiana current climate TACA")

Ga.siebCC90.sdm_ext = resample(Ga.siebCC90.sdm, Ga.siebCC90.taca)
Ga.sieb_diff_CCtaca_CCSDM = Ga.siebCC90.taca - Ga.siebCC90.sdm_ext
table(values(Ga.sieb_diff_CCtaca_CCSDM))

Ga.sieb_Diff_CC <- ggplot() +
  geom_spatraster(data = Ga.sieb_diff_CCtaca_CCSDM)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate niche", title = "Gahnia sieberiana 2090 model difference")

Ga.sieb.sdm_ext = resample(Ga.sieb.sdm, Ga.sieb.taca)
Ga.sieb_diff_taca_SDM = Ga.sieb.taca - Ga.sieb.sdm_ext

Ga.sieb_Diff_current <- ggplot() +
  geom_spatraster(data = Ga.sieb_diff_taca_SDM)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = 1, limits=c(0,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate niche", title = "Gahnia sieberiana current model difference")

grid.arrange(Ga.sieb_sdm, Ga.sieb_CCsdm, Ga.sieb_taca, Ga.sieb_CCtaca, Ga.sieb_Diff_current, Ga.sieb_Diff_CC, nrow = 3)


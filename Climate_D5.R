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
library(grid)

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
E.vimCC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_EucaVim_CC.tif")
E.vimCC90.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/EucVim_CC_90.tif")
E.vim.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_EucaVim.tif")
E.vim.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/EucVim.tif")
E.vim.SEA.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/EucaVim.tif")
E.vim.SEACC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/EucaVim_CC.tif")

Al.vert.SEA.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/AllVert.tif")
Al.vert.SEACC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/AllVert_CC.tif")
Ac.vert.SEA.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/AcVert.tif")
Ac.vert.SEACC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/AcVert_CC.tif")
Ac.vert.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_AcVert.tif")
Ac.vertCC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_AcVert_CC.tif")

Ac.melCC90.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/AcMel_CC_90.tif")
Ac.mel.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/AcMel.tif")
Ac.melCC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_AcMela_CC.tif")
Ac.mel.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_AcMela.tif")
Ac.mel.SEA.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/AcMela.tif")
Ac.mel.SEACC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/AcMela_CC.tif")

Ac.meaCC90.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/AcMea_CC_90.tif")
Ac.mea.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/AcMea.tif")
Ac.meaCC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_AcMear_CC.tif")
Ac.mea.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_AcMear.tif")
Ac.mea.SEA.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/AcMear.tif")
Ac.mea.SEACC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/AcMear_CC.tif")

Ac.impCC90.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/AcImp_CC_90.tif")
Ac.imp.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/AcImp.tif")
Ac.impCC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_AcImpl_CC.tif")
Ac.imp.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_AcImpl.tif")
Ac.imp.SEA.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/AcImpl.tif")
Ac.imp.SEACC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/AcImpl_CC.tif")

Ac.deaCC90.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/Acdea_CC_90.tif")
Ac.dea.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/Acdea.tif")
Ac.deaCC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_AD_CC.tif")
Ac.dea.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_AD.tif")
Ac.dea.SEA.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/Ac_Deal.tif")
Ac.dea.SEACC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/AcDeal_CC.tif")

B.spinCC90.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/BurSpi_CC_90.tif")
B.spin.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/BurSpi.tif")
B.spinCC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_BurSpin_CC.tif")
B.spin.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_BurSpin.tif")
B.spin.SEA.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/BurSpin.tif")
B.spin.SEACC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/BurSpin_CC.tif")

Ga.sieb.SEA.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/GaSieb.tif")
Ga.sieb.SEACC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/GaSieb_CC.tif")

O.lirCC90.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/OleLir_CC_90.tif")
O.lir.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/OleLir.tif")
O.lirCC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_OleLir_CC.tif")
O.lir.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_OleLir.tif")
O.lir.SEA.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/OleLir.tif")
O.lir.SEACC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/OleLir_CC.tif")

E.camCC90.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/EucCam_P0_CC_90.tif")
E.cam.taca <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/TACA_Maps/EucCam_P0.tif")
E.camCC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_EuCama_CC.tif")
E.cam.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/MW_EuCama.tif")
E.cam.SEA.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/EuCama.tif")
E.cam.SEACC90.sdm <- terra::rast("~/uomShare/wergProj/Climate_Reveg_D5/MW_Species Maps/SEA SDM/EuCama_CC.tif")

States <- terra::vect("~/uomShare/wergProj/Climate_Reveg_D5/VIc_NSW_ACT_bound.shp")
States_diss <- terra::vect("~/uomShare/wergProj/Climate_Reveg_D5/VIc_NSW_ACT_bound_diss.shp")

#change projection
newcrs <- "epsg:28355"
Al.vert.SEACC90.sdm_proj <- terra::project(Al.vert.SEACC90.sdm, newcrs)
Al.vert.SEA.sdm_proj <- terra::project(Al.vert.SEA.sdm, newcrs)
Ac.vert.SEACC90.sdm_proj <- terra::project(Ac.vert.SEACC90.sdm, newcrs)
Ac.vert.SEA.sdm_proj <- terra::project(Ac.vert.SEA.sdm, newcrs)
extent <- ext(-85046.55, 1653351, 5665321, 6868390)
MWextent <- ext(244753.2, 426253.2, 5730022, 5879522)
Al.vert.SEA.sdm_crop <- crop(Al.vert.SEA.sdm_proj, extent)
Al.vert.SEACC90.sdm_crop <- crop(Al.vert.SEACC90.sdm_proj, extent)
Al.vert.SEA.sdm_MWcrop <- crop(Al.vert.SEA.sdm_proj, MWextent)
Al.vert.SEACC90.sdm_MWcrop <- crop(Al.vert.SEACC90.sdm_proj, MWextent)

E.vim_CCsdm <- ggplot() +
  geom_spatraster(data = E.vimCC90.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM 2090
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
E.vim_sdm <- ggplot() +
  geom_spatraster(data = E.vim.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM current
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
E.vim_CCtaca <- ggplot() +
  geom_spatraster(data = E.vimCC90.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
E.vim_taca <- ggplot() +
  geom_spatraster(data = E.vim.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_E.vim_MW_taca = E.vimCC90.taca - E.vim.taca
E.vim_Diff_taca <- ggplot() +
  geom_spatraster(data = diff_E.vim_MW_taca)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_E.vim_MW_sdm = E.vimCC90.sdm - E.vim.sdm
E.vim_Diff_sdm <- ggplot() +
  geom_spatraster(data = diff_E.vim_MW_sdm)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
E.vim.SEACC90.sdm_proj <- terra::project(E.vim.SEACC90.sdm, newcrs)
E.vim.SEA.sdm_proj <- terra::project(E.vim.SEA.sdm, newcrs)
E.vim.SEACC90.sdm_crop <- crop(E.vim.SEACC90.sdm_proj, extent)
E.vim.SEA.sdm_crop <- crop(E.vim.SEA.sdm_proj, extent)
E.vim_SEA_sdm <- ggplot() +
  geom_spatraster(data = E.vim.SEA.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
E.vim_SEACC90_sdm <- ggplot() +
  geom_spatraster(data = E.vim.SEACC90.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
E.vim_map <- grid.arrange(E.vim_SEA_sdm, E.vim_SEACC90_sdm, E.vim_sdm, E.vim_CCsdm, E.vim_Diff_sdm, E.vim_taca, 
             E.vim_CCtaca, E.vim_Diff_taca, nrow = 3, 
             top = textGrob("Eucalyptus viminalis",gp=gpar(fontsize=16,font=3)),
            layout_matrix = rbind(c(1, 2, NA),c(3, 4, 5),c(6,7,8)))
ggsave('~/uomShare/wergProj/Climate_Reveg_D5/Outputs/Review/TACA/E.vim_map_map.png', 
       E.vim_map, device = "png", width = 20, height = 12, dpi = 300)

Ac.mel_CCsdm <- ggplot() +
  geom_spatraster(data = Ac.melCC90.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM 2090
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.mel_sdm <- ggplot() +
  geom_spatraster(data = Ac.mel.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM current
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.mel_CCtaca <- ggplot() +
  geom_spatraster(data = Ac.melCC90.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.mel_taca <- ggplot() +
  geom_spatraster(data = Ac.mel.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_Ac.mel_MW_taca = Ac.melCC90.taca - Ac.mel.taca
Ac.mel_Diff_taca <- ggplot() +
  geom_spatraster(data = diff_Ac.mel_MW_taca)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_Ac.mel_MW_sdm = Ac.melCC90.sdm - Ac.mel.sdm
Ac.mel_Diff_sdm <- ggplot() +
  geom_spatraster(data = diff_Ac.mel_MW_sdm)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.mel.SEACC90.sdm_proj <- terra::project(Ac.mel.SEACC90.sdm, newcrs)
Ac.mel.SEA.sdm_proj <- terra::project(Ac.mel.SEA.sdm, newcrs)
Ac.mel.SEACC90.sdm_crop <- crop(Ac.mel.SEACC90.sdm_proj, extent)
Ac.mel.SEA.sdm_crop <- crop(Ac.mel.SEA.sdm_proj, extent)
Ac.mel_SEA_sdm <- ggplot() +
  geom_spatraster(data = Ac.mel.SEA.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.mel_SEACC90_sdm <- ggplot() +
  geom_spatraster(data = Ac.mel.SEACC90.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.mel_map <- grid.arrange(Ac.mel_SEA_sdm, Ac.mel_SEACC90_sdm, Ac.mel_sdm, Ac.mel_CCsdm, Ac.mel_Diff_sdm, Ac.mel_taca, 
             Ac.mel_CCtaca, Ac.mel_Diff_taca, nrow = 3, 
             top = textGrob("Acacia melanoxylon",gp=gpar(fontsize=16,font=3)),
             layout_matrix = rbind(c(1, 2, NA),c(3, 4, 5),c(6,7,8)))
ggsave('~/uomShare/wergProj/Climate_Reveg_D5/Outputs/Review/TACA/Ac.mel_map.png', 
       Ac.mel_map, device = "png", width = 20, height = 12, dpi = 300)

Ac.mea_CCsdm <- ggplot() +
  geom_spatraster(data = Ac.meaCC90.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM 2090
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.mea_sdm <- ggplot() +
  geom_spatraster(data = Ac.mea.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM current
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.mea_CCtaca <- ggplot() +
  geom_spatraster(data = Ac.meaCC90.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.mea_taca <- ggplot() +
  geom_spatraster(data = Ac.mea.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_Ac.mea_MW_taca = Ac.meaCC90.taca - Ac.mea.taca
Ac.mea_Diff_taca <- ggplot() +
  geom_spatraster(data = diff_Ac.mea_MW_taca)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_Ac.mea_MW_sdm = Ac.meaCC90.sdm - Ac.mea.sdm
Ac.mea_Diff_sdm <- ggplot() +
  geom_spatraster(data = diff_Ac.mea_MW_sdm)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.mea.SEACC90.sdm_proj <- terra::project(Ac.mea.SEACC90.sdm, newcrs)
Ac.mea.SEA.sdm_proj <- terra::project(Ac.mea.SEA.sdm, newcrs)
Ac.mea.SEACC90.sdm_crop <- crop(Ac.mea.SEACC90.sdm_proj, extent)
Ac.mea.SEA.sdm_crop <- crop(Ac.mea.SEA.sdm_proj, extent)
Ac.mea_SEA_sdm <- ggplot() +
  geom_spatraster(data = Ac.mea.SEA.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.mea_SEACC90_sdm <- ggplot() +
  geom_spatraster(data = Ac.mea.SEACC90.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.mea_map <- grid.arrange(Ac.mea_SEA_sdm, Ac.mea_SEACC90_sdm, Ac.mea_sdm, Ac.mea_CCsdm, Ac.mea_Diff_sdm, Ac.mea_taca, 
             Ac.mea_CCtaca, Ac.mea_Diff_taca, nrow = 3, 
             top = textGrob("Acacia mearnsii",gp=gpar(fontsize=16,font=3)),
             layout_matrix = rbind(c(1, 2, NA),c(3, 4, 5),c(6,7,8)))
ggsave('~/uomShare/wergProj/Climate_Reveg_D5/Outputs/Review/TACA/Ac.mea_map.png', 
       Ac.mea_map, device = "png", width = 20, height = 12, dpi = 300)

Ac.imp_CCsdm <- ggplot() +
  geom_spatraster(data = Ac.impCC90.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM 2090
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.imp_sdm <- ggplot() +
  geom_spatraster(data = Ac.imp.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM current
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.imp_CCtaca <- ggplot() +
  geom_spatraster(data = Ac.impCC90.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.imp_taca <- ggplot() +
  geom_spatraster(data = Ac.imp.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_Ac.imp_MW_taca = Ac.impCC90.taca - Ac.imp.taca
Ac.imp_Diff_taca <- ggplot() +
  geom_spatraster(data = diff_Ac.imp_MW_taca)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_Ac.imp_MW_sdm = Ac.impCC90.sdm - Ac.imp.sdm
Ac.imp_Diff_sdm <- ggplot() +
  geom_spatraster(data = diff_Ac.imp_MW_sdm)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.imp.SEACC90.sdm_proj <- terra::project(Ac.imp.SEACC90.sdm, newcrs)
Ac.imp.SEA.sdm_proj <- terra::project(Ac.imp.SEA.sdm, newcrs)
Ac.imp.SEACC90.sdm_crop <- crop(Ac.imp.SEACC90.sdm_proj, extent)
Ac.imp.SEA.sdm_crop <- crop(Ac.imp.SEA.sdm_proj, extent)
Ac.imp_SEA_sdm <- ggplot() +
  geom_spatraster(data = Ac.imp.SEA.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM currcurrent
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.imp_SEACC90_sdm <- ggplot() +
  geom_spatraster(data = Ac.imp.SEACC90.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.imp_map <- grid.arrange(Ac.imp_SEA_sdm, Ac.imp_SEACC90_sdm, Ac.imp_sdm, Ac.imp_CCsdm, Ac.imp_Diff_sdm, Ac.imp_taca, 
             Ac.imp_CCtaca, Ac.imp_Diff_taca, nrow = 3, 
             top = textGrob("Acacia implexa",gp=gpar(fontsize=16,font=3)),
             layout_matrix = rbind(c(1, 2, NA),c(3, 4, 5),c(6,7,8)))
ggsave('~/uomShare/wergProj/Climate_Reveg_D5/Outputs/Review/TACA/Ac.imp_map.png', 
       Ac.imp_map, device = "png", width = 20, height = 12, dpi = 300)

Ac.dea_CCsdm <- ggplot() +
  geom_spatraster(data = Ac.deaCC90.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM 2090
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.dea_sdm <- ggplot() +
  geom_spatraster(data = Ac.dea.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM current
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.dea_CCtaca <- ggplot() +
  geom_spatraster(data = Ac.deaCC90.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.dea_taca <- ggplot() +
  geom_spatraster(data = Ac.dea.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_Ac.dea_MW_taca = Ac.deaCC90.taca - Ac.dea.taca
Ac.dea_Diff_taca <- ggplot() +
  geom_spatraster(data = diff_Ac.dea_MW_taca)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_Ac.dea_MW_sdm = Ac.deaCC90.sdm - Ac.dea.sdm
Ac.dea_Diff_sdm <- ggplot() +
  geom_spatraster(data = diff_Ac.dea_MW_sdm)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.dea.SEACC90.sdm_proj <- terra::project(Ac.dea.SEACC90.sdm, newcrs)
Ac.dea.SEA.sdm_proj <- terra::project(Ac.dea.SEA.sdm, newcrs)
Ac.dea.SEACC90.sdm_crop <- crop(Ac.dea.SEACC90.sdm_proj, extent)
Ac.dea.SEA.sdm_crop <- crop(Ac.dea.SEA.sdm_proj, extent)
Ac.dea_SEA_sdm <- ggplot() +
  geom_spatraster(data = Ac.dea.SEA.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ac.dea_SEACC90_sdm <- ggplot() +
  geom_spatraster(data = Ac.dea.SEACC90.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
A.deal_map <- grid.arrange(Ac.dea_SEA_sdm, Ac.dea_SEACC90_sdm, Ac.dea_sdm, Ac.dea_CCsdm, Ac.dea_Diff_sdm, Ac.dea_taca, 
             Ac.dea_CCtaca, Ac.dea_Diff_taca, nrow = 3, 
             top = textGrob("Acacia dealbata",gp=gpar(fontsize=16,font=3)),
             layout_matrix = rbind(c(1, 2, NA),c(3, 4, 5),c(6,7,8)))
ggsave('~/uomShare/wergProj/Climate_Reveg_D5/Outputs/Review/TACA/A.deal_map.png', 
       A.deal_map, device = "png", width = 20, height = 12, dpi = 300)

Al.vert_CCsdm <- ggplot() +
  geom_spatraster(data = Al.vertCC90.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM 2090
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Al.vert_sdm <- ggplot() +
  geom_spatraster(data = Al.vert.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM current
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Al.vert_CCtaca <- ggplot() +
  geom_spatraster(data = Al.vertCC90.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Al.vert_taca <- ggplot() +
  geom_spatraster(data = Al.vert.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_Al.vert_MW_taca = Al.vertCC90.taca - Al.vert.taca
Al.vert_Diff_taca <- ggplot() +
  geom_spatraster(data = diff_Al.vert_MW_taca)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_Al.vert_MW_sdm = Al.vertCC90.sdm - Al.vert.sdm
Al.vert_Diff_sdm <- ggplot() +
  geom_spatraster(data = diff_Al.vert_MW_sdm)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Al.vert.SEACC90.sdm_proj <- terra::project(Al.vert.SEACC90.sdm, newcrs)
Al.vert.SEA.sdm_proj <- terra::project(Al.vert.SEA.sdm, newcrs)
Al.vert.SEACC90.sdm_crop <- crop(Al.vert.SEACC90.sdm_proj, extent)
Al.vert.SEA.sdm_crop <- crop(Al.vert.SEA.sdm_proj, extent)
Al.vert_SEA_sdm <- ggplot() +
  geom_spatraster(data = Al.vert.SEA.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Al.vert_SEACC90_sdm <- ggplot() +
  geom_spatraster(data = Al.vert.SEACC90.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Al.vert_map <- grid.arrange(Al.vert_SEA_sdm, Al.vert_SEACC90_sdm, Al.vert_sdm, Al.vert_CCsdm, Al.vert_Diff_sdm, Al.vert_taca, 
                           Al.vert_CCtaca, Al.vert_Diff_taca, nrow = 3, 
                           top = textGrob("Allocasuarina verticillata",gp=gpar(fontsize=16,font=3)),
                           layout_matrix = rbind(c(1, 2, NA),c(3, 4, 5),c(6,7,8)))
ggsave('~/uomShare/wergProj/Climate_Reveg_D5/Outputs/Review/TACA/Al.vert_map.png', 
       Al.vert_map, device = "png", width = 20, height = 12, dpi = 300)

B.spin_CCsdm <- ggplot() +
  geom_spatraster(data = B.spinCC90.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM 2090
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
B.spin_sdm <- ggplot() +
  geom_spatraster(data = B.spin.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM current
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
B.spin_CCtaca <- ggplot() +
  geom_spatraster(data = B.spinCC90.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
B.spin_taca <- ggplot() +
  geom_spatraster(data = B.spin.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_B.spin_MW_taca = B.spinCC90.taca - B.spin.taca
B.spin_Diff_taca <- ggplot() +
  geom_spatraster(data = diff_B.spin_MW_taca)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_B.spin_MW_sdm = B.spinCC90.sdm - B.spin.sdm
B.spin_Diff_sdm <- ggplot() +
  geom_spatraster(data = diff_B.spin_MW_sdm)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
B.spin.SEACC90.sdm_proj <- terra::project(B.spin.SEACC90.sdm, newcrs)
B.spin.SEA.sdm_proj <- terra::project(B.spin.SEA.sdm, newcrs)
B.spin.SEACC90.sdm_crop <- crop(B.spin.SEACC90.sdm_proj, extent)
B.spin.SEA.sdm_crop <- crop(B.spin.SEA.sdm_proj, extent)
B.spin_SEA_sdm <- ggplot() +
  geom_spatraster(data = B.spin.SEA.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
B.spin_SEACC90_sdm <- ggplot() +
  geom_spatraster(data = B.spin.SEACC90.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
B.spin_map <- grid.arrange(B.spin_SEA_sdm, B.spin_SEACC90_sdm, B.spin_sdm, B.spin_CCsdm, B.spin_Diff_sdm, B.spin_taca, 
                            B.spin_CCtaca, B.spin_Diff_taca, nrow = 3, 
                            top = textGrob("Bursaria spinosa",gp=gpar(fontsize=16,font=3)),
                            layout_matrix = rbind(c(1, 2, NA),c(3, 4, 5),c(6,7,8)))
ggsave('~/uomShare/wergProj/Climate_Reveg_D5/Outputs/Review/TACA/B.spin_map.png', 
       B.spin_map, device = "png", width = 20, height = 12, dpi = 300)

Ga.sieb_CCsdm <- ggplot() +
  geom_spatraster(data = Ga.siebCC90.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM 2090
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ga.sieb_sdm <- ggplot() +
  geom_spatraster(data = Ga.sieb.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM current
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ga.sieb_CCtaca <- ggplot() +
  geom_spatraster(data = Ga.siebCC90.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ga.sieb_taca <- ggplot() +
  geom_spatraster(data = Ga.sieb.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_Ga.sieb_MW_taca = Ga.siebCC90.taca - Ga.sieb.taca
Ga.sieb_Diff_taca <- ggplot() +
  geom_spatraster(data = diff_Ga.sieb_MW_taca)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_Ga.sieb_MW_sdm = Ga.siebCC90.sdm - Ga.sieb.sdm
Ga.sieb_Diff_sdm <- ggplot() +
  geom_spatraster(data = diff_Ga.sieb_MW_sdm)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ga.sieb.SEACC90.sdm_proj <- terra::project(Ga.sieb.SEACC90.sdm, newcrs)
Ga.sieb.SEA.sdm_proj <- terra::project(Ga.sieb.SEA.sdm, newcrs)
Ga.sieb.SEACC90.sdm_crop <- crop(Ga.sieb.SEACC90.sdm_proj, extent)
Ga.sieb.SEA.sdm_crop <- crop(Ga.sieb.SEA.sdm_proj, extent)
Ga.sieb_SEA_sdm <- ggplot() +
  geom_spatraster(data = Ga.sieb.SEA.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ga.sieb_SEACC90_sdm <- ggplot() +
  geom_spatraster(data = Ga.sieb.SEACC90.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
Ga.sieb_map <- grid.arrange(Ga.sieb_SEA_sdm, Ga.sieb_SEACC90_sdm, Ga.sieb_sdm, Ga.sieb_CCsdm, Ga.sieb_Diff_sdm, Ga.sieb_taca, 
                           Ga.sieb_CCtaca, Ga.sieb_Diff_taca, nrow = 3, 
                           top = textGrob("Gahnia sieberiana",gp=gpar(fontsize=16,font=3)),
                           layout_matrix = rbind(c(1, 2, NA),c(3, 4, 5),c(6,7,8)))
ggsave('~/uomShare/wergProj/Climate_Reveg_D5/Outputs/Review/TACA/Ga.sieb_map.png', 
       Ga.sieb_map, device = "png", width = 20, height = 12, dpi = 300)

O.lir_CCsdm <- ggplot() +
  geom_spatraster(data = O.lirCC90.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM 2090
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
O.lir_sdm <- ggplot() +
  geom_spatraster(data = O.lir.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM current
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
O.lir_CCtaca <- ggplot() +
  geom_spatraster(data = O.lirCC90.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
O.lir_taca <- ggplot() +
  geom_spatraster(data = O.lir.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_O.lir_MW_taca = O.lirCC90.taca - O.lir.taca
O.lir_Diff_taca <- ggplot() +
  geom_spatraster(data = diff_O.lir_MW_taca)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_O.lir_MW_sdm = O.lirCC90.sdm - O.lir.sdm
O.lir_Diff_sdm <- ggplot() +
  geom_spatraster(data = diff_O.lir_MW_sdm)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
O.lir.SEACC90.sdm_proj <- terra::project(O.lir.SEACC90.sdm, newcrs)
O.lir.SEA.sdm_proj <- terra::project(O.lir.SEA.sdm, newcrs)
O.lir.SEACC90.sdm_crop <- crop(O.lir.SEACC90.sdm_proj, extent)
O.lir.SEA.sdm_crop <- crop(O.lir.SEA.sdm_proj, extent)
O.lir_SEA_sdm <- ggplot() +
  geom_spatraster(data = O.lir.SEA.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
O.lir_SEACC90_sdm <- ggplot() +
  geom_spatraster(data = O.lir.SEACC90.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
O.lir_map <- grid.arrange(O.lir_SEA_sdm, O.lir_SEACC90_sdm, O.lir_sdm, O.lir_CCsdm, O.lir_Diff_sdm, O.lir_taca, 
                            O.lir_CCtaca, O.lir_Diff_taca, nrow = 3, 
                            top = textGrob("Olearia lirata",gp=gpar(fontsize=16,font=3)),
                            layout_matrix = rbind(c(1, 2, NA),c(3, 4, 5),c(6,7,8)))
ggsave('~/uomShare/wergProj/Climate_Reveg_D5/Outputs/Review/TACA/O.lir_map.png', 
       O.lir_map, device = "png", width = 20, height = 12, dpi = 300)

E.cam_CCsdm <- ggplot() +
  geom_spatraster(data = E.camCC90.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM 2090
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
E.cam_sdm <- ggplot() +
  geom_spatraster(data = E.cam.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM current
climate suitability")+ theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
E.cam_CCtaca <- ggplot() +
  geom_spatraster(data = E.camCC90.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
E.cam_taca <- ggplot() +
  geom_spatraster(data = E.cam.taca)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_E.cam_MW_taca = E.camCC90.taca - E.cam.taca
E.cam_Diff_taca <- ggplot() +
  geom_spatraster(data = diff_E.cam_MW_taca)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "TACA difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
diff_E.cam_MW_sdm = E.camCC90.sdm - E.cam.sdm
E.cam_Diff_sdm <- ggplot() +
  geom_spatraster(data = diff_E.cam_MW_sdm)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = -1, limits=c(-1,1),
    labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SDM difference
in climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
E.cam.SEACC90.sdm_proj <- terra::project(E.cam.SEACC90.sdm, newcrs)
E.cam.SEA.sdm_proj <- terra::project(E.cam.SEA.sdm, newcrs)
E.cam.SEACC90.sdm_crop <- crop(E.cam.SEACC90.sdm_proj, extent)
E.cam.SEA.sdm_crop <- crop(E.cam.SEA.sdm_proj, extent)
E.cam_SEA_sdm <- ggplot() +
  geom_spatraster(data = E.cam.SEA.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM current
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
E.cam_SEACC90_sdm <- ggplot() +
  geom_spatraster(data = E.cam.SEACC90.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "SEA SDM 2090
climate suitability") + theme(legend.key.width= unit(0.5, 'cm'))+
  xlab("Longitude") + ylab("Latitude")
E.cam_map <- grid.arrange(E.cam_SEA_sdm, E.cam_SEACC90_sdm, E.cam_sdm, E.cam_CCsdm, E.cam_Diff_sdm, E.cam_taca, 
                          E.cam_CCtaca, E.cam_Diff_taca, nrow = 3, 
                          top = textGrob("Eucalyptus camaldulensis",gp=gpar(fontsize=16,font=3)),
                          layout_matrix = rbind(c(1, 2, NA),c(3, 4, 5),c(6,7,8)))
ggsave('~/uomShare/wergProj/Climate_Reveg_D5/Outputs/Review/TACA/E.cam_map.png', 
       E.cam_map, device = "png", width = 20, height = 12, dpi = 300)

species_risk <- read.csv("~/uomShare/wergProj/Climate_Reveg_D5/Sp_risk.csv")
reg_change <- read.csv("~/uomShare/wergProj/Climate_Reveg_D5/Reg_change.csv")
species_risk <- data.frame(group = c("SEA_SDM", "MW_SDM", "MW_TACA"),
                 Extreme = c(1,4,1),
                 Very_high = c(8,10,1),
                 High = c(26,12,7),
                 Moderate = c(0,7,1),
                 No_change = c(0,2,0))
sp_risk <- species_risk %>% gather(key = Risk, value = Value, Extreme:No_change)
sp_risk
ggplot(sp_risk, aes(Risk, Value, fill = group)) + geom_col(position = "dodge")
ggplot(data=sp_risk, aes(X, MW_SDM)) +
  geom_bar(stat="identity", width=0.5)


#SEA and SDM models
Al.vert_SEA_sdm <- ggplot() +
  geom_spatraster(data = Al.vert.SEA.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  geom_sf(data = MW_bound, fill = "NA", color = "black", size = 0.5) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Allocasuarina verticillata SEA current climate SDM")
Al.vert_SEACC90_sdm <- ggplot() +
  geom_spatraster(data = Al.vert.SEACC90.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  geom_sf(data = MW_bound, fill = "NA", color = "black", size = 0.5) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Allocasuarina verticillata SEA 2090 climate SDM")
Al.vert_CCsdm <- ggplot() +
  geom_spatraster(data = Al.vertCC90.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Allocasuarina verticillata 2090 climate SDM")
Al.vert_sdm <- ggplot() +
  geom_spatraster(data = Al.vert.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Allocasuarina verticillata current climate SDM")
grid.arrange(Al.vert_SEA_sdm, Al.vert_SEACC90_sdm, Al.vert_sdm, Al.vert_CCsdm, nrow = 2)

Ac.vert_SEA_sdm <- ggplot() +
  geom_spatraster(data = Ac.vert.SEA.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  geom_sf(data = MW_bound, fill = "NA", color = "black", size = 0.5) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Acacia verticillata SEA current climate SDM")
Ac.vert_SEACC90_sdm <- ggplot() +
  geom_spatraster(data = Ac.vert.SEACC90.sdm_crop)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  geom_sf(data = MW_bound, fill = "NA", color = "black", size = 0.5) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Acacia verticillata SEA 2090 climate SDM")
Ac.vert_CCsdm <- ggplot() +
  geom_spatraster(data = Ac.vertCC90.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Acacia verticillata 2090 climate SDM")
Ac.vert_sdm <- ggplot() +
  geom_spatraster(data = Ac.vert.sdm)+
  scale_fill_gradient(low = "white", high = "dark green", limits=c(0,1), labels = scales::label_number()) +
  theme_minimal() +
  labs(fill = "Climate suitability", title = "Acacia verticillata current climate SDM")
grid.arrange(Ac.vert_SEA_sdm, Ac.vert_SEACC90_sdm, Ac.vert_sdm, Ac.vert_CCsdm, nrow = 2)

Ac.vert.SEA.sdm_proj_disagg <- disagg(Ac.vert.SEA.sdm_proj, fact = 8.216)
Ac.vert.SEACC90.sdm_proj_disagg <- disagg(Ac.vert.SEACC90.sdm_proj, fact = 8.216)
Ac.vert.SEA.sdm_MWcrop <- crop(Ac.vert.SEA.sdm_proj_disagg, Ac.vert.sdm)
MW2extent <- ext(244753.2, 426253.2, 5730022, 5879522)
Ac.vert.SEACC90.sdm_MWcrop <- crop(Ac.vert.SEACC90.sdm_proj_disagg, MW2extent, snap="near")
A1 <- crop(Ac.vert.SEACC90.sdm_proj_disagg, ext(244753.2, 426253.2, 5730022, 5879522))
extent2 <- align(MW2extent, Ac.vert.SEACC90.sdm_proj_disagg, snap="near")
r.new = resample(Ac.vertCC90.sdm, Ac.vert.SEACC90.sdm_proj_disagg, "bilinear")
ex = ext(Ac.vertCC90.sdm)
r2 = crop(Ac.vert.SEACC90.sdm_proj_disagg, ex)
r.new = mask(Ac.vertCC90.sdm, r2)

alignExtent(A1, Ac.vertCC90.sdm)

diff_Ac.vert_SEA_MWsdm = A1 - Ac.vertCC90.sdm

values(Al.vert.SEA.sdm_MWcrop) <- 1:ncell(Al.vert.SEA.sdm_MWcrop)

plot(Ac.vert.SEA.sdm_proj_disagg)

terra::ext(diff_Ga.sieb_MW_sdm)
ext(diff_Ga.sieb_MW_taca)
str(diff_Ga.sieb_MW_sdm)
#AGGREGATE TACA TO SAME RESOLUTION AS SDM
diff_Ga.sieb_MW_taca_agg <- aggregate(diff_Ga.sieb_MW_taca, fact = 10)
#change the extent of the taca model to the same as the sdm 
diff_Ga.sieb_MW_taca_agg2 <- resample(diff_Ga.sieb_MW_taca_agg, diff_Ga.sieb_MW_sdm)
hasMinMax(diff_Ga.sieb_MW_taca_agg2)
setMinMax(diff_Ga.sieb_MW_taca_agg2, force=TRUE)
#values(diff_Ga.sieb_MW_taca_agg2)
#compareGeom(diff_Ga.sieb_MW_taca_agg2, diff_Ga.sieb_MW_sdm)

Diff_maps <- ggplot() +
  geom_spatraster(data = diff_Ga.sieb_MW_sdm) + 
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = 1, limits=c(), 
    labels = scales::label_number())+
  geom_spatraster(data = diff_Ga.sieb_MW_taca_agg2, alpha = 0.5)

+
  scale_fill_terrain_c(direction = 1, limits=c(0))
  
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = 1, limits=c(), alpha = 0.5, 
    labels = scales::label_number()) +
  theme_minimal() +
geom_spatraster(data = diff_Ga.sieb_MW_taca_agg2)+
  scale_fill_whitebox_c(
    palette = "bl_yl_rd", direction = 1, limits=c(),
    labels = scales::label_number()) +
labs(fill = "Climate suitability", title = "Gahnia sieberiana SDM model difference")

# Se instalan una serie de paquetes.
if(!"remotes" %in% installed.packages()) {
  install.packages("remotes")
}

cran_pkgs = c(
  "sf",
  "tidygraph",
  "igraph",
  "osmdata",
  "dplyr",
  "tibble",
  "ggplot2",
  "units",
  "tmap",
  "rgrass7",
  "link2GI",
  "nabor"
)

library(sf)
library(tidygraph)
library(igraph)
library(dplyr)
library(tibble)
library(ggplot2)
library(units)
library(tmap)
library(osmdata)
library(rgrass7)
library(link2GI)
library(nabor)
library(magick)

# remotes::install_cran(cran_pkgs)

# We choose Tacubaya a little neighborhood of Mexico City (el lugar donde nací)
CDMX <- opq(bbox =  c(-99.2000, 19.391555, -99.1800, 19.40755)) %>% 
  add_osm_feature(key = 'highway') %>% 
  osmdata_sf() %>% 
  osm_poly2line()

cdmx_center <- CDMX$osm_lines %>% 
  select(highway)

cdmx_center

ggplot(data = cdmx_center) + geom_sf() + theme_bw()

ggplot(data = cdmx_center) + geom_sf() + theme(panel.background = element_rect(fill = NA),panel.grid.major = element_blank(), panel.grid.minor = element_blank())


ggplot(data = cdmx_center) + geom_sf() + theme(axis.title.x=element_blank(), 
                                               axis.text.x=element_blank(), 
                                               axis.ticks.x=element_blank(),
                                               axis.title.y=element_blank(), 
                                               axis.text.y=element_blank(), 
                                               axis.ticks.y=element_blank(),
                                               panel.background = element_rect(fill = NA),
                                               panel.grid.major = element_blank(), 
                                               panel.grid.minor = element_blank())
###########

# We choose Tacubaya a little neighborhood of Mexico City (el lugar donde nací)
CDMX <- opq(bbox =  c(-99.2000, 19.381555, -99.1800, 19.42755)) %>% 
  add_osm_feature(key = 'highway') %>% 
  osmdata_sf() %>% 
  osm_poly2line()

cdmx_center <- CDMX$osm_lines %>% 
  select(highway)

cdmx_center

ggplot(data = cdmx_center) + geom_sf() + theme_bw()

ggplot(data = cdmx_center) + geom_sf() + theme(panel.background = element_rect(fill = NA),panel.grid.major = element_blank(), panel.grid.minor = element_blank())


imagen<- ggplot(data = cdmx_center) + geom_sf() + theme(axis.title.x=element_blank(), 
                                               axis.text.x=element_blank(), 
                                               axis.ticks.x=element_blank(),
                                               axis.title.y=element_blank(), 
                                               axis.text.y=element_blank(), 
                                               axis.ticks.y=element_blank(),
                                               panel.background = element_rect(fill = "blue"),
                                               panel.grid.major = element_blank(), 
                                               panel.grid.minor = element_blank())

imagen
frink <- image_read("~/Art_color/Rplot02.png")

i <-image_crop(frink, "800x750+50")
ia <-image_crop(i, "800x650-50")
ia

ib <-image_crop(ia, "500x590-350")
ib

ic <-image_crop(ib, "500x590-120")
ic


img <- image_read("~/Art_color/ib.png")
mask <- image_read(tf)
mask <- image_scale(mask, as.character(image_info(img)$width))

image_composite(mask, img, "plus") 
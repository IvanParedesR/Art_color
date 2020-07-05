# Se instalan una serie de paquetes.
#Usamos remotes para instalar
#if(!"remotes" %in% installed.packages()) {
#  install.packages("remotes")
#}

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
  add_osm_feature(key = 'amenity') %>%
  osmdata_sf() %>% 
  osm_poly2line()

cdmx_center <- CDMX$osm_lines %>% 
  select(highway)

cdmx_center

#Con cuadriculas de fondo y marco
ggplot(data = cdmx_center) + geom_sf() + theme_bw()

#Sin marco, pero con números de ejes
ggplot(data = cdmx_center) + geom_sf() + theme(panel.background = element_rect(fill = NA),panel.grid.major = element_blank(), panel.grid.minor = element_blank())

#Sin marco, sin número de ejes
ggplot(data = cdmx_center) + geom_sf() + theme(axis.title.x=element_blank(), 
                                               axis.text.x=element_blank(), 
                                               axis.ticks.x=element_blank(),
                                               axis.title.y=element_blank(), 
                                               axis.text.y=element_blank(), 
                                               axis.ticks.y=element_blank(),
                                               panel.background = element_rect(fill = NA),
                                               panel.grid.major = element_blank(), 
                                               panel.grid.minor = element_blank())


ggplot() +
  geom_sf(data = cdmx_center,
          inherit.aes = FALSE,
          color = "#7fc0ff",
          size = .4,
          alpha = .8) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = "#ffbe7f",
          size = .2,
          alpha = .6) +
  coord_sf(xlim = c(-99.1800, 19.40755)), 
           ylim = c(-99.2000, 19.391555),
           expand = FALSE) +
  theme_void() +
  theme(
    plot.background = element_rect(fill = "#282828")
  )


CDMX <- opq(bbox =  c(-0.13, 51.5, -0.11, 51.52)) %>% 
  add_osm_feature(key = 'highway') %>% 
  osmdata_sf() %>% 
  osm_poly2line()

cdmx_center <- CDMX$osm_lines %>% 
  select(highway)

cdmx_center

#Con cuadriculas de fondo y marco
ggplot(data = cdmx_center) + geom_sf() + theme_bw()


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
                                               panel.background = element_rect(fill = NA),
                                               panel.grid.major = element_blank(), 
                                               panel.grid.minor = element_blank())



imagen
frink <- image_read("~/Art_color/Rplot04.png")
frink

i <-image_crop(frink, "1800x750+50")
ia <-image_crop(i, "800x650-50")
ia

ib <-image_crop(ia, "500x590-350")
ib

ic <-image_crop(ib, "500x590-120")
ic

png(tf <- tempfile(fileext = ".png"), 2500, 2500)
par(mar = rep(0,4), yaxs="i", xaxs="i")
plot(0, type = "n", ylim = c(0,1), xlim=c(0,1), axes=F, xlab=NA, ylab=NA)
plotrix::draw.circle(.5,0.5,.5, col="black")
dev.off()


img <- image_read("~/Art_color/Rplot04.png")
img
mask <- image_read(tf)
mask <- image_scale(mask, as.character(image_info(img)$width))
mask
image_composite(mask, img, "plus") 

image_composite(mask, img, "minus") 


png(tf <- tempfile(fileext = ".png"), 1000, 1000)
par(mar = rep(0,4), yaxs="i", xaxs="i")
plot(0, type = "n", ylim = c(0,1), xlim=c(0,1), axes=F, xlab=NA, ylab=NA)
plotrix::draw.circle(.5,0.5,.5, col="black")
dev.off()

fn <- "https://www.gravatar.com/avatar/f57aba01c52e5c67696817eb87df84f2?s=328&d=identicon&r=PG&f=1"
img <- image_read(fn)
img
mask <- image_read(tf)
mask <- image_scale(mask, as.character(image_info(img)$width))
mask
image_composite(mask, img, "plus") 
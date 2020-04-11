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

remotes::install_cran(cran_pkgs)

# We choose Tacubaya a little neighborhood of Mexico City
CDMX <- opq(bbox =  c(-99.2300, 19.391555, -99.1800, 19.40755)) %>% 
  add_osm_feature(key = 'highway') %>% 
  osmdata_sf() %>% 
  osm_poly2line()

cdmx_center <- CDMX$osm_lines %>% 
  select(highway)

cdmx_center

ggplot(data = cdmx_center) + geom_sf() + theme_bw()

ggplot(data = cdmx_center) + geom_sf() + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())

library(grid)
?opts
ggplot(data = cdmx_center) + geom_sf() + opts(panel.background = theme_rect(fill='white', colour='black')) + opts(panel.grid.major = none, panel.grid.minor = none)

png(tf <- tempfile(fileext = ".png"), 1000, 1000)
par(mar = rep(0,4), yaxs="i", xaxs="i")
plot(0, type = "n", ylim = c(0,1), xlim=c(0,1), axes=F, xlab=NA, ylab=NA)
plotrix::draw.circle(.5,0.5,.5, col="black")
dev.off()


library(magick)
fn <- "https://www.gravatar.com/avatar/f57aba01c52e5c67696817eb87df84f2?s=328&d=identicon&r=PG&f=1"
img <- image_read(fn)
mask <- image_read(tf)
mask <- image_scale(mask, as.character(image_info(img)$width))
mask
img
image_composite(mask, img, "plus") 

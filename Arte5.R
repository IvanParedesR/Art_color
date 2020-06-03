library(imager)
DR<-load.image("~/Art_color/Libro_Los_Viejos_Abuelos_Foto_68.png")
class(DR)

layout(t(1:2))
plot(DR)
plot(DR/2)

cscale <- function(r,g,b) rgb(g,r,b)
plot(DR,colourscale=cscale,rescale=FALSE)

cscale <- function(v) rgb(0,0,v)
grayscale(DR) %>% plot(colourscale=cscale,rescale=FALSE)
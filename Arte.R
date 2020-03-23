#Cargamos librerias
library(readxl)
library(tidyverse)
library(RColorBrewer)

#Cargamos datos, se toma el PIB de la página de Inegi de 1980 a la actualidad
BIE_ <- read_excel("C:/Users/iparedes/Downloads/Graphs/BIE_BIE20200320185601.xls", range = "A4:G164")

#Pensé en convertir z en una fecha, al final es irrelevante pues lo use como factor.
#z <- as.Date(BIE_BIE20200320185601$Periodo, "%Y%q")
BIE_$z <- as.factor(BIE_$Grupo)

# Hacer la grafica
p <- ggplot(BIE_, aes(x=as.factor(Periodo), y=PIB2013PM)) +
  # Aqui se agrega el color
  geom_bar(stat="identity", fill=alpha("red", 0.9)) +
  ylim(-10000000,24000000) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-2,4), "cm")     # This remove unnecessary margin around plot
  ) +
  
  # Se hacen coordenadas polares y no cartesianas
  coord_polar(start = -50)
p

# Set a number of 'empty bar' to add at the end of each group
empty_bar <- 4
to_add <- data.frame( matrix(NA, empty_bar*nlevels(BIE_$z), ncol(BIE_)) )
colnames(to_add) <- colnames(BIE_)
to_add$z <- rep(levels(BIE_$z), each=empty_bar)
BIE_ <- rbind(BIE_, to_add)
BIE_ <- BIE_  %>% arrange(z)
#BIE_ $P <- seq(1, nrow(z))
BIE_$t <- 1:192

# Make the plot
p <- ggplot(BIE_, aes(x=as.factor(t), y=PIB2013PM, fill=z)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
  geom_bar(stat="identity", alpha=0.5) +
  ylim(-10000000,24000000) +
  theme_minimal() +
  theme(
    legend.position = "none",
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-1,4), "cm") 
  ) +
  coord_polar()
p2 <- p + scale_fill_brewer(palette="YlGnBu")
p2
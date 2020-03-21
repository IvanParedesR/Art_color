library(readxl)
BIE_BIE20200320185601 <- read_excel("C:/Users/iparedes/Downloads/Graphs/BIE_BIE20200320185601.xls", range = "A4:F164"))

# Usando Cuentas nacionales > 
# Producto interno bruto trimestral, base 2013 > Valores a precios de 2013 Producto Interno Bruto, a precios de mercado 
# Libraries
library(tidyverse)

# Propuesta inicial, finalmente no se uso. z <- as.Date(BIE_BIE20200320185601$Periodo, "%Y%q")

# Haz la gráfica
p <- ggplot(BIE_BIE20200320185601, aes(x=as.factor(Periodo), y=PIB2013PM)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
  
# Se llena de color azul
 geom_bar(stat="identity", fill=alpha("blue", 0.3)) +
  
  # Limits of the plot = very important. The negative value controls the size of the inner circle, the positive one is useful to add size over each bar
  ylim(-10000000,24000000) +
  
  # Custom the theme: no axis title and no cartesian grid
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-2,4), "cm")     # This remove unnecessary margin around plot
  ) +
  
  # This makes the coordinate polar instead of cartesian.
  coord_polar(start = 0)
p

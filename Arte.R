#Cargamos librerias
library(readxl)
library(tidyverse)
library(RColorBrewer)

#https://jokergoo.github.io/circlize_book/book/

#Cargamos datos, se toma el PIB de la página de Inegi de 1980 a la actualidad
BIE_ <- read_excel("~/Art_color/BIE_BIE20200320185601.xls", range = "A4:F164")

#BIE_$Periodo <- as.Date(BIE_$Periodo)

#Generamos una variable llamada z.
BIE_$z <- 1 

# Hacer la grafica
p <- ggplot(BIE_, aes(x=as.factor(Periodo), y=PIB2013PM)) +
  # Aqui se agrega el color
  geom_bar(stat="identity", fill=alpha("red", 0.9)) + #agregamos color rojo
  ylim(-10000000,24000000) + #establecemos minimos y máximos
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-2,4), "cm")   
  ) +
  # Se hacen coordenadas polares y no cartesianas
  coord_polar(start = -58) 
p

# modificamos el data frame para separar los datos por sexenio
BIE_$z<- ifelse((BIE_$Periodo >= "2018/04" & BIE_$Periodo <= "2019/04"), 9,+
                  ifelse((BIE_$Periodo >= "2012/04" & BIE_$Periodo <= "2018/03"), 8,+
                           ifelse((BIE_$Periodo >= "2006/04" & BIE_$Periodo <= "2012/03"), 7,+
                                    ifelse((BIE_$Periodo >= "2000/04" & BIE_$Periodo <= "2006/03"), 6,+
                                             ifelse((BIE_$Periodo >= "1994/04" & BIE_$Periodo <= "2000/03"), 5,+
                                                      ifelse((BIE_$Periodo >= "1988/04" & BIE_$Periodo <= "1994/03"), 4,+
                                                               ifelse((BIE_$Periodo >= "1982/04" & BIE_$Periodo <= "1988/03"), 3,+
                                                                        ifelse((BIE_$Periodo >= "1980/04" & BIE_$Periodo <= "1982/03"), 2,+
                                                                                 ifelse((BIE_$Periodo >= "1980/01" & BIE_$Periodo <= "1980/03"), 1, 0)))))))))

# Guardamos el grupo como factor
BIE_$z <- as.factor(BIE_$z)

# Aqui vamos poniendo un numero de barras en blanco para separar
empty_bar <- 4
to_add <- data.frame( matrix(NA, empty_bar*nlevels(BIE_$z), ncol(BIE_)) )
colnames(to_add) <- colnames(BIE_)
to_add$z <- rep(levels(BIE_$z), each=empty_bar)
BIE_ <- rbind(BIE_, to_add)
BIE_ <- BIE_  %>%   arrange(z)
BIE_ $P <- seq(1, nrow(BIE_))
BIE_$t <- 1:196

# Una nueva versión de la gráfica con colores distintos para cada sexenio
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

### Pendiente
BIE_2 <- c("Periodo", "PIB2013AP", "PIB2013AS", "PIB2013AT", "z")
newdata <- BIE_[BIE_2]

newdata <- newdata %>%
  pivot_longer(cols = c(`PIB2013AP`, `PIB2013AS`, `PIB2013AT`), names_to = "PIBxSectores", values_to = "PIB")

newdata$PIBxSectores <- as.factor(newdata$PIBxSectores)

p3 <- ggplot(newdata) +      
  
  # Add the stacked bar
  geom_bar(aes(x=as.factor(Periodo), y=PIB, fill=PIBxSectores), stat="identity", alpha=0.5) +
  scale_fill_viridis(discrete=TRUE) +
  coord_polar() +
  theme_minimal() +
  theme(
    legend.position = "none",
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-1,4), "cm") 
  )
p3

library(readxl)
ca57_2018 <- read_excel("ca57_2018.xlsx", 
                        range = "A13:J629", col_names = FALSE)
View(ca57_2018)

library(ggridges)
library(ggplot2)

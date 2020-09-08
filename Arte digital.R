library(plotly)
library(dplyr)

fig <- ggplot2::diamonds
fig <- fig %>% count(cut, clarity)
fig <- fig %>% plot_ly(x = ~cut, y = ~n, color = ~clarity)

fig
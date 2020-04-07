library(readxl)
mip_ <- read_excel("C:/Users/iparedes/Pictures/Final.xlsx")
df <- scale(mip_)
heatmap(df, scale = "none", Rowv = NA, Colv = "Rowv")


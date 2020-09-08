#' k-nearest neighbour graph
#'
#' Computes a k-nearest neighbour graph for a given set of points. Refer to the \href{https://en.wikipedia.org/wiki/Nearest_neighbor_graph}{Wikipedia article} for details.
#' @param points A data frame with x, y coordinates for the points
#' @param k Number of neighbours
#' @keywords nearest neightbour graph
#' @export
#' @examples
#' k_nearest_neighbour_graph()

k_nearest_neighbour_graph <- function(points, k=8) {
  get_k_nearest <- function(points, ptnum, k) {
    xi <- points$x[ptnum]
    yi <- points$y[ptnum]     
    points %>%
      dplyr::mutate(dist = sqrt((x - xi)^2 + (y - yi)^2)) %>%
      dplyr::arrange(dist) %>%
      dplyr::filter(row_number() %in% seq(2, k+1)) %>%
      dplyr::mutate(xend = xi, yend = yi)
  }
  
  1:nrow(points) %>%
    purrr::map_df(~get_k_nearest(points, ., k))
}


install.packages(c("devtools", "mapproj", "tidyverse", "ggforce", "Rcpp"))
library(devtools, mapproj, tidyverse, ggforce, Rcpp)
devtools::install_github("marcusvolz/mathart")
devtools::install_github("marcusvolz/ggart")

# Generate rrt edges
set.seed(1)
df <- rapidly_exploring_random_tree() %>% mutate(id = 1:nrow(.))

theme_blankcanvas <- function(bg_col = "transparent", margin_cm = 2.5) {
  theme(axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.line = element_blank(),
        legend.position = "none",
        panel.background = element_rect(fill = bg_col, colour = bg_col),
        panel.border = element_blank(),
        panel.grid = element_blank(),
        plot.background = element_rect(fill = bg_col, colour = bg_col),
        plot.margin = unit(rep(margin_cm, 4), "cm"), # top, right, bottom, left
        strip.background = element_blank(),
        strip.text = element_blank())
}

# Create plot
ggplot() +
  geom_segment(aes(x, y, xend = xend, yend = yend, size = -id, alpha = -id), df, lineend = "round") +
  coord_equal() +
  scale_size_continuous(range = c(0.1, 0.75)) +
  scale_alpha_continuous(range = c(0.1, 1)) +
  theme_blankcanvas(margin_cm = 0)
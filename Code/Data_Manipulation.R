library(tidyverse)
df1=read.csv("C:/Users/lipidomics/Desktop/AdjacencyResults_AB.csv")


df2=read.csv("C:/Users/lipidomics/Desktop/AdjacencyResults_CB.csv")


df1=df1%>%
  mutate(name="Original")

df2=df2%>%
  mutate(name="Shrunk GAL4")%>%
  bind_rows(df1)

###set up publication theme from Zacharias Steinmetz
theme_publish <- function(base_size = 12, base_family = "",
                          base_linewidth = 0.25, ...) {
  half_line <- base_size / 2
  small_rel <- 0.8
  small_size <- small_rel * base_size
  
  theme_bw(base_size = base_size, base_family = base_family, ...) %+replace%
    theme(
      rect = element_rect(fill = "transparent", colour = NA, color = NA,
                          linewidth = 0, linetype = 0),
      text = element_text(family = base_family, face = "plain",
                          colour = "black", size = base_size, hjust = 0.5,
                          vjust = 0.5, angle = 0, lineheight = 0.9,
                          margin = ggplot2::margin(), debug = F),
      
      axis.text = element_text(size = small_size),
      axis.text.x = element_text(margin = ggplot2::margin(t = small_size/4),
                                 vjust = 1),
      axis.text.y = element_text(margin = ggplot2::margin(r = small_size/4), 
                                 hjust = 1),
      axis.title.x = element_text(margin = ggplot2::margin(t = small_size,
                                                           b = small_size)),
      axis.title.y = element_text(angle = 90,
                                  margin = ggplot2::margin(r = small_size,
                                                           l = small_size/4)),
      axis.ticks = element_line(colour = "black", linewidth = base_linewidth),
      axis.ticks.length = unit(0.25, 'lines'),
      
      axis.line = element_line(colour = "black", linewidth = base_linewidth),
      axis.line.x = element_line(colour = "black", linewidth = base_linewidth), 
      axis.line.y = element_line(colour = "black", linewidth = base_linewidth), 
      
      legend.spacing = unit(base_size/4, "pt"),
      legend.key = element_blank(),
      legend.key.size = unit(1 * base_size, "pt"),
      legend.key.width = unit(1.5 * base_size, 'pt'),
      legend.text = element_text(size = rel(small_rel)),
      legend.title = element_text(size = rel(small_rel), face = 'bold'),
      legend.position = 'bottom',
      legend.box = 'horizontal',
      
      panel.spacing = unit(1, "lines"),
      panel.background = element_blank(),
      panel.border = element_blank(), 
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      
      strip.text = element_text(size = base_size),
      strip.background = element_rect(fill = NA, colour = "black",
                                      linewidth = 0.125),
      strip.text.x = element_text(face = 'bold', hjust = 0,
                                  margin = ggplot2::margin(b = small_size/2,
                                                           t = small_size/4)),
      strip.text.y = element_text(angle = -90, face = 'bold',
                                  margin = ggplot2::margin(l = small_size/2,
                                                           r = small_size/4)),
      
      plot.margin = unit(c(5,5,0,0), "pt"),
      plot.background = element_blank(),
      plot.title = element_text(face = "bold", size = 1.2 * base_size, 
                                margin = ggplot2::margin(b = half_line),
                                hjust = 0)
    )
}


ggplot(df2,aes(Dist.min.EdgeA.EdgeB))+
  geom_histogram(bins=20)+
  facet_grid(cols=vars(name))+
  theme_publish()+
  labs(x="Distance From nc82 to Nearest GAL4 (µM)", y="Counts")

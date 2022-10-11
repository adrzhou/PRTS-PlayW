library(dplyr)
library(stringr)
library(ggplot2)


df <- readRDS('data/levels.RDS')

draw <- function(code) {
  
  stage <- dplyr::filter(df, code == (!! code), challenge == FALSE)
  w = stage[['width']]
  h = stage[['height']]
  stage <- stage[['tiles']]  %>%
    bind_rows() %>% 
    mutate(x = rep(1:w, h), 
           y = rep(h:1, each = w),
           tileKey = str_replace_all(tileKey,
                                     c('tile_end' = '目标点',
                                       'tile_start' = '侵入点',
                                       'tile_floor' = '禁止部署',
                                       'tile_forbidden' = '场景',
                                       'tile_empty' = '无实体',
                                       'tile_road' = '近战位',
                                       'tile_wall' = '远程位')))
  
  colors <- c('目标点' = 'blue', '侵入点' = 'red', '近战位' = 'green',
              '远程位' = 'darkolivegreen', '禁止部署' = 'yellow',
              '场景' = 'darkgray', '无实体' = 'antiquewhite')
  
  ggplot(data = stage, aes(x = x, y = y, fill = tileKey)) +
    geom_tile(color = 'white', lwd = 0.5, linetype = 1) +
    coord_fixed() +
    scale_y_discrete(limits = factor(h:1)) +
    scale_x_discrete(limits = factor(1:w), position = 'top') +
    scale_fill_manual(values = colors, name = '类型') +
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank())
  
}
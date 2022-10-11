library(jsonlite)
library(tibble)
library(dplyr)
library(stringr)


json <- fromJSON('levels.json', simplifyDataFrame = TRUE) %>% 
  mutate(challenge = str_ends(stageId, '#f#'), 
         storyline = str_starts(stageId, 'easy'),
         ordeal = str_starts(stageId, 'tough')) %>% 
  select(-c(levelId, view, stageId))

saveRDS(tibble(json), file = 'levels.RDS')

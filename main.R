suppressPackageStartupMessages({
  library(tercen)
  library(dplyr)
  library(data.table)
})

ctx <- tercenCtx()

df <- ctx %>% 
  select(.y, .ci, .ri) %>%
  as.data.table()

df[,
    list(mad = median(abs(.y - median(.y)))),
    by = .(.ci, .ri)
  ] %>%
  as_tibble() %>%
  ctx$addNamespace() %>%
  ctx$save()
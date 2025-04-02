library(dplyr)


datos_cuanti <- readRDS("Data/output/datos_dep.rds") %>% 
  select(P_S6P66       ,P_S7P84F      ,P_S7P85B      ,P_S12P150A    ,P_S15P158B    )


# Vector de medias



# Covarianza
cov(datos_cuanti)



# Correlacion
cor(datos_cuanti)

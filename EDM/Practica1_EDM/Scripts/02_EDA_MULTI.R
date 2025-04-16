library(dplyr)


datos_cuanti <- readRDS("Data/output/datos_dep.rds") %>% 
  select(P_S6P66,P_S7P84F,P_S7P85B,P_S12P150A,P_S15P158B)

datos_cuali <- readRDS("Data/output/datos_dep.rds") %>% 
  select(PRED_ETNICA_c,S05_TENENCIA_c,P_S6P71_c,P_S6P65_c)

# Resumen Cuanti ----------------------------------------------------------



# Vector de medias



# Covarianza
cov(datos_cuanti)



# Correlacion
cor(datos_cuanti)


# Variables cuali ---------------------------------------------------------

tabla1<-table(datos$PRED_ETNICA_c,datos$PRED_ETNICA_c)
tabla1 <- addmargins(tabla1)
knitr::kable(tabla1)


